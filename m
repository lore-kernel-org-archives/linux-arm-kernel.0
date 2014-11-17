From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 17 Nov 2014 14:24:01 -0800
Subject: exynos boot falures in linux-next
In-Reply-To: <7hoas54y7k.fsf@deeprootsystems.com> (Kevin Hilman's message of
 "Mon, 17 Nov 2014 07:57:03 -0800")
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7hoas54y7k.fsf@deeprootsystems.com>
Message-ID: <7hlhn9zcse.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@kernel.org> writes:

> FYI...
>
> Various new exynos5 boot failures starting next-20141117.  Looking in
> the boot logs, the boot stops during DRM initialization.
>
> Note that the boot failures are only on exynos_defconfig, and not
> multi_v7_defconfig.

As might have been expected, reverting the change that enables the
DRM/display options in exynos_defconfig fixes the problem.

Kevin

> Excerpt from boot report below, or recent exynos boots can also be
> explored here:
>
>    http://status.armcloud.us/boot/?exynos
>
> Kevin
>
>
> Kevin's boot bot <khilman@kernel.org> writes:
>
>> Full Build report: http://status.armcloud.us/build/next/kernel/next-20141117/
>> Full Boot report:  http://status.armcloud.us/boot/all/job/next/kernel/next-20141117/
>>
>> Tree/Branch: next
>> Git describe: next-20141117
>>
>> Failed boot tests
>> =================
>
> [...]
>
>>            exynos5422-odroid-xu3:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5422-odroid-xu3.html
>>               exynos5250-arndale:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5250-arndale.html
>>              exynos5800-peach-pi:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5800-peach-pi.html

[1]
commit 0ef76aea7a344ac520b02822a8080797fa06124c
Author: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date:   Thu Nov 13 11:51:42 2014 +0900

    ARM: exynos_defconfig: Enable options for display panel support

    Many Exynos devices have a display panel. Most of them just have
    a simple panel while others have more complex configurations that
    requires an embedded DisplayPort (eDP) to LVDS bridges.

    This patch enables the following features to be built in the kernel
    image to support both setups:

    - Direct Rendering Manager (DRM)
    - DRM bridge registration and lookup framework
    - Parade ps8622/ps8625 eDP/LVDS bridge
    - NXP ptn3460 eDP/LVDS bridge
    - Exynos Fully Interactive Mobile Display controller (FIMD)
    - Panel registration and lookup framework
    - Simple panels
    - Backlight & LCD device support

    Signed-off-by: Javier Martinez Canillas
    <javier.martinez@collabora.co.uk>
    Tested-by: Kevin Hilman <khilman@linaro.org>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
