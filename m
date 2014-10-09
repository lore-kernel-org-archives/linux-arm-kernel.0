From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 09 Oct 2014 16:34:26 -0700
Subject: [PATCH 1/1] ARM: exynos_defconfig: re-enable USB gadget and
 max77802 options
In-Reply-To: <1412879767-24326-1-git-send-email-javier.martinez@collabora.co.uk>
 (Javier Martinez Canillas's message of "Thu, 9 Oct 2014 20:36:07
 +0200")
References: <1412879767-24326-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <7h8ukolsvx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

> Commit 43eeaa42e03a ("ARM: exynos_defconfig: savedefconfig") removed a
> set of Kconfig symbols. For most of them there were no functional change
> since are selected by other Kconfig options or were deprecated but some
> options are not explicitly selected so they should not had been removed.
>
> The options that have to be enabled are USB gadget and the MAX77802 PMIC
> support which were enabled in commits:
>
> 508423bebcda ("ARM: exynos_defconfig: enable USB gadget support")
> 6e80e3d87549 ("ARM: exynos_defconfig: Enable MAX77802")
>
> Enable those options to leave the config in the state before the change.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

This is needed to get RTC wakeup from suspend working on
exynos5800-peach-pi.

Note that the s3c-rtc works fine, but the max77802-rtc doesn't seem to
work be functional for me:

[    2.408178] max77802-rtc max77802-rtc: rtc core: registered max77802-rtc as rtc0
[    3.595485] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1

root@(none):/# hwclock --rtc /dev/rtc0
hwclock: ioctl(RTC_RD_TIME) to /dev/rtc0 to read the time failed:
Invalid argument
root@(none):/# hwclock --rtc /dev/rtc1
Thu Oct  9 23:33:06 2014  -0.111978 seconds

Kevin
