From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 10 Sep 2014 11:20:19 -0700
Subject: exynos5420/arndale-octa: imprecise external aborts on exynos_defconfig
Message-ID: <CANMBJr41TQx4jVjnOO9WThn=SiZCq12mx1xtGN8_ubzZrO1=YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420-based Arndale octa boards have recently started failing boot
tests due to imprecise external aborts.  This only appears to happen
when using exynos_defconfig and boots fine with multi_v7_defconfig.  The
issue seems to be intermittent, so is not reliably reproducable and
difficult to bisect.  Here are a few boot logs from recent
mainline/linux-next kernels that are failing:

mainline/v3.17-rc3-165-g56c2285:
    http://armv7.com/scheduler/job/5525/log_file#L_59_276

mainline/v3.17-rc3-176-g2b12164:
    http://armv7.com/scheduler/job/5595/log_file#L_59_278

mainline/v3.17-rc4-131-gd030671:
    http://armv7.com/scheduler/job/5770/log_file#L_193_277

mainline/v3.17-rc4-146-g619df5d:
    http://armv7.com/scheduler/job/6014/log_file#L_124_0

next/20140908:
    http://armv7.com/scheduler/job/5815/log_file#L_59_276

next/20140910:
    http://armv7.com/scheduler/job/6161/log_file#L_59_278

The ramdisk is used is a very minimal open embedded based filesystem,
which can be found here:

http://images.armcloud.us/lava/common/linaro-image-minimal-initramfs-genericarmv7a.cpio.gz.u-boot

Please let me know if any more information is needed to help
reproduce. If/when a root cause is determined, I am more than willing
to assist in testing any fixes provided.

Thanks,

-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
