From: girishks2000@gmail.com (Girish KS)
Date: Mon, 8 Apr 2013 17:22:29 +0530
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
 <20130408101530.GC9243@opensource.wolfsonmicro.com>
 <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
Message-ID: <CAKrE-Kd3ua3H7C03H67-8unCsW9R98mvmWWnuHCScngARvPkaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 8, 2013 at 5:15 PM, Girish KS <girishks2000@gmail.com> wrote:
> On Mon, Apr 8, 2013 at 3:45 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Apr 08, 2013 at 03:21:03PM +0530, Girish KS wrote:
>>> On Mon, Apr 1, 2013 at 6:27 PM, Mark Brown
>>
>>> > It's also a bit odd that we end up checking cs_gpio and then using line
>>> > in the code, it'd be more idiomatic if cs_gpio were the GPIO number.
>>
>>> In the original driver it was assumed that the cs line is always a gpio pin.
>>> But the current controller that i am working on has no gpio pin for cs
>>> selection.
>>> All the lines to the device are internally connected. There is no
>>> option to select
>>> the cs signal. So cs-gpio property parsing has to skipped for this
>>> controller, that means
>>> cs_gpio cannot be a GPIO number. If it has to be a number then it has
>>> to be < 0 to say
>>> it is not gpio. Any >= 0 number implies it is a valid gpio (in reality
>>> for this controller it is not.)
>>
>> Two options here, one is to just assume nobody will use GPIO 0 and the
>> other is to set the number appopriately during probe so that only probe
>> needs to worry about the issue.
>
> regarding the first option, may be others also should agree to it (in
> case if somebody is
> using the gpio 0).
> In the second option if the gpio number is set in the probe, then we
> are overwriting the
> actual gpio number assigned in the platform data.
> If I move the cs_gpio from the platform data to controller private
> data then the dependency
> on other platforms can be removed, but still the check (true or false)
> before setting the gpio
> line will remain. If agreed upon this i can go ahead and post the patch

Sorry for the allignment. there is some issue with my interface
