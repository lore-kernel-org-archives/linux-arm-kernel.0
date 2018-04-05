From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 5 Apr 2018 10:32:38 +0200
Subject: [RESEND PATCH] ARM: pxa: stargate2: use device properties for
 at24 eeprom
In-Reply-To: <878ta24uyy.fsf@belgarion.home>
References: <20180404114706.15856-1-brgl@bgdev.pl>
 <878ta24uyy.fsf@belgarion.home>
Message-ID: <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-04 21:44 GMT+02:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
>> We want to work towards phasing out the at24_platform_data structure.
>> There are few users and its contents can be represented using generic
>> device properties. Using device properties only will allow us to
>> significantly simplify the at24 configuration code.
>>
>> Remove the at24_platform_data structure and replace it with an array
>> of property entries. Drop the byte_len/size property, as the model name
>> already implies the EEPROM's size.
> Hi Bartosz,
>
> I'd like a little explanation for the last sentence. Are you implying that
> ac24.c is using the "type" field, and if so could you point me to the correct
> line, because I was under the impression a property called "size" is used for
> byte_len value ... ?
>

Yes, it does use the type field from i2c_board_info implicitly over
i2c-core. The type field is copied over to client->name and then is
matched against the i2c ID table from which we get the associated chip
data (unless the type is "at24") containing the size and flags.

Hope that helps.

Bartosz
