From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 9 Oct 2014 08:07:39 +0530
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <7hiojuno9e.fsf@deeprootsystems.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <7hiojuno9e.fsf@deeprootsystems.com>
Message-ID: <CAM4voanoOV44EQveAeikp1P0bXCU8HHdX2XDi3jwLkfQOP0CNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Oct 9, 2014 at 4:49 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Vikas Sajjan <vikas.sajjan@samsung.com> writes:
>
> [...]
>
>> Tested on Kukjin Kim's tree, for-next branch +
>> 1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
>> 2] https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37260.html
>> 3] with the CLK_IGNORE_UNUSED flag for aclk200_disp1 CLK
>>
>> on Exynos5420 based chromebook (peach-pit board)
>>
>> Below procedures were followed to test S2R:
>> Procedure A:
>>       1. make multi_v7_defconfig
>>       2  enable MCPM for 5420
>>       3. enable S3C RTC
>>       5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>> Procedure B:
>>       1. make exynos_defconfig
>>       4. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>
> I went tried to this on exynos5800-peach-pi and found first that
> exynos_defonfig is missing the MAX77802 kconfig options for the RTC
> source clock:
>
> CONFIG_REGULATOR_MAX77802=y
> CONFIG_COMMON_CLK_MAX77802=y

I am using exynos_defconfig (no changes) with the internal SoC RTC
which is enabled by default. I did not enable the MAX77802 RTC.
>
> With those, rtc0 then comes up, but isn't waking from suspend.  However,
> writing something to rtc0/wakealarm does result in /proc/interrupts
> having an interrupt for the RTC, it's just not waking the system.
>
> Anyone else tried this on 5800/peach-pi?

I have tested this on a Peach-Pi and the system is resuming fine. The
patches applied on kgene's for-next branch along with the
aclk200_disp1 fix are:
http://lkml.org/lkml/2014/9/30/156
https://lkml.org/lkml/2014/10/6/89
http://www.spinics.net/lists/arm-kernel/msg368207.html
http://www.spinics.net/lists/linux-samsung-soc/msg37647.html

Abhilash
