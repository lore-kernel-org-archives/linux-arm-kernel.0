From: dianders@chromium.org (Doug Anderson)
Date: Fri, 19 Sep 2014 17:14:06 -0700
Subject: [PATCH v10 0/6] Add Maxim 77802 RTC support
In-Reply-To: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=VHVWVtgOoB83cJ9XKAcyBmHwSawh2EWEZViqcQrTpQjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Fri, Sep 19, 2014 at 3:26 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Andrew,
>
> This series add support for the Real Time clock present in
> the Maxim 77802 Power Managment IC. The version number is
> quite high because it previously was part of a bigger series
> [0] that aimed to add support for all the devices in the
> max77802 PMIC. But now that the max77802 dependencies were
> already merged for 3.17, the series were split but I kept
> the version numbering.
>
> While working on the max77802 rtc support a lot of feedback
> was given and the issues pointed out also apply to a driver
> for a similar PMIC RTC (max77686). So patches 01/06 to 05/06
> in the series are cleanups for the max77686 driver and patch
> 06/06 adds the support for the max77802 RTC.
>
> This version address the issues pointed out on the previous
> version [1] and changelog are present on each patch when is
> applicable.
>
> The series were tested on an Exynos5250 Snow (max77686) and
> Exynos5420 Peach Pit (max77802) machines and applies cleanly
> to both 3.17-rc1 and today's linux-next (20140919).
>
> NOTE: The patches from the previous version [1] were already
> present in the -mm tree [2] so I didn't know if I should had
> sent this as a delta or as a new revision. I decided to do
> the later but please let me know if you expected the former.

My records show that Andrew has already accepted most of these.  They
may not show up in linuxnext yet, but that doesn't mean Andrew hasn't
taken them (I think).


> Doug Anderson (1):
>   rtc: max77686: Allow the max77686 rtc to wakeup the system

    http://ozlabs.org/~akpm/mmots/broken-out/rtc-max77686-allow-the-max77686-rtc-to-wakeup-the-system.patch

> Javier Martinez Canillas (5):
>   rtc: max77686: Remove dead code for SMPL and WTSR.

    http://ozlabs.org/~akpm/mmots/broken-out/rtc-max77686-remove-dead-code-for-smpl-and-wtsr.patch

>   rtc: max77686: Fail to probe if no RTC regmap irqchip is set

    http://ozlabs.org/~akpm/mmots/broken-out/rtc-max77686-fail-to-probe-if-no-rtc-regmap-irqchip-is-set.patch

>   rtc: max77686: Remove unneded info log

    http://ozlabs.org/~akpm/mmots/broken-out/rtc-max77686-remove-unneded-info-log.patch

>   rtc: max77686: Use ffs() to calculate tm_wday

This one hasn't been accepted...

>   rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock

    http://ozlabs.org/~akpm/mmots/broken-out/rtc-add-driver-for-maxim-77802-pmic-real-time-clock.patch


-Doug
