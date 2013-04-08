From: girishks2000@gmail.com (Girish KS)
Date: Mon, 8 Apr 2013 19:19:05 +0530
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <20130408122056.GG9243@opensource.wolfsonmicro.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
 <20130408101530.GC9243@opensource.wolfsonmicro.com>
 <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
 <20130408122056.GG9243@opensource.wolfsonmicro.com>
Message-ID: <CAKrE-KcMy1qzzg1JXqBOvAJTdQM3rLU6dHoQRnyryLz4p0rpaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 8, 2013 at 5:50 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 08, 2013 at 05:15:26PM +0530, Girish KS wrote:
>> On Mon, Apr 8, 2013 at 3:45 PM, Mark Brown
>
>> > Two options here, one is to just assume nobody will use GPIO 0 and the
>> > other is to set the number appopriately during probe so that only probe
>> > needs to worry about the issue.
>>
>> In the second option if the gpio number is set in the probe, then we
>> are overwriting the
>> actual gpio number assigned in the platform data.
>> If I move the cs_gpio from the platform data to controller private
>> data then the dependency
>> on other platforms can be removed, but still the check (true or false)
>> before setting the gpio
>> line will remain. If agreed upon this i can go ahead and post the patch
>
> I think logic in probe should be fine, it just felt really cumbersome
> having this on every single use but doing it once on probe ought to be
> OK.

I will move the populating cs_gpio logic to probe. But the enable_cs
and disable_cs will have the
check before calling the gpio_set_value api (because it takes cs-line
as a parameter),
