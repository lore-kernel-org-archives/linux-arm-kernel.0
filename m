From: spk.linux@gmail.com (Sachin Kamat)
Date: Tue, 15 Jul 2014 22:40:00 +0530
Subject: [PATCH] ARM: config: update multi_v7_defconfig
In-Reply-To: <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
References: <1405411346-12471-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
Message-ID: <CAK5sBcGcnG9FMuJLSkFamcTw3VR1KeLNKRRo7Xhp05s=og-+zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Tue, Jul 15, 2014 at 9:29 PM, Doug Anderson <dianders@chromium.org> wrote:
> Naveen,
>
> On Tue, Jul 15, 2014 at 1:02 AM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> Enabled S3C24XX I2C driver and MAX77686 PMIC MFD and Voltage
>> regulator drivers used on Exynos5250 based Snow board.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> ---
>> By enabling the symbols to compile S3C24XX I2C driver, MAX77686 PMIC
>> under MFD and REGULATOR.
>>
>> http://arm-soc.lixom.net/bootlogs/next/next-20140711/snow-multi_v7_defconfig.html
>> The warnings by cpufreq on Snow board are fixed.
>>
>> Booted and verified on  on Exynos5420 based Snow board
>>
>>  arch/arm/configs/multi_v7_defconfig |    3 +++
>>  1 file changed, 3 insertions(+)
>
> Is there a reason not to add more of the max77686 configs?
>
> +CONFIG_RTC_DRV_MAX77686=y
> +CONFIG_COMMON_CLK_MAX77686=y
>
> I also seems like it would be nice to reconcile this with Sacin's
> latest patch.  For starters I notice that you're missing:
>   CONFIG_EXYNOS5420_MCPM=y
>
> I'll leave it up to you to look for other things that might be
> missing.  If some of the things in exynos5_defconfig can't go into the
> multi-config, please explain.

multi_v7_defconfig update patch, inline with exynos_defconfig is already on my
TODO list. I wanted to send this one along with the next update of
exynos_defconfig
(around -rc7) as Olof preferred to have a single patch updating most
of the available
things. By then I believe remaining drivers like 5420/5800 regulators,
display and cpufreq
drivers would have been merged.

 --
Regards,
Sachin.
