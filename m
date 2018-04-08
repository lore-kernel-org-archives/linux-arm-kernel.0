From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 08 Apr 2018 11:03:48 +0200
Subject: [RESEND PATCH] ARM: pxa: stargate2: use device properties for
 at24 eeprom
In-Reply-To: <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
 (Bartosz Golaszewski's message of "Thu, 5 Apr 2018 10:32:38 +0200")
References: <20180404114706.15856-1-brgl@bgdev.pl>
 <878ta24uyy.fsf@belgarion.home>
 <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
Message-ID: <87sh862hor.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> 2018-04-04 21:44 GMT+02:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> Yes, it does use the type field from i2c_board_info implicitly over
> i2c-core. The type field is copied over to client->name and then is
> matched against the i2c ID table from which we get the associated chip
> data (unless the type is "at24") containing the size and flags.

Ah yes, the "struct i2c_device_id at24_ids" part, I see.

Applied to pxa/for-next, thanks.

-- 
Robert
