From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Apr 2018 21:44:53 +0200
Subject: [RESEND PATCH] ARM: pxa: stargate2: use device properties for
 at24 eeprom
In-Reply-To: <20180404114706.15856-1-brgl@bgdev.pl> (Bartosz Golaszewski's
 message of "Wed, 4 Apr 2018 13:47:06 +0200")
References: <20180404114706.15856-1-brgl@bgdev.pl>
Message-ID: <878ta24uyy.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
Hi Bartosz,

I'd like a little explanation for the last sentence. Are you implying that
ac24.c is using the "type" field, and if so could you point me to the correct
line, because I was under the impression a property called "size" is used for
byte_len value ... ?

Cheers.

--
Robert
