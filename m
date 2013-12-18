From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Dec 2013 16:40:12 -0800
Subject: [PATCH v12 06/08] ARM: hi3xxx: add hotplug support
In-Reply-To: <1386748497-11290-7-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Wed, 11 Dec 2013 15:54:55 +0800")
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
 <1386748497-11290-7-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87sitrm1oz.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Enable hotplug support on hi3xxx platform
>
> How to test:
> cat proc/interrupts
> echo 0 > /sys/devices/system/cpu/cpuX/online
> cat proc/interrupts
> echo 1 > /sys/devices/system/cpu/cpuX/online
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

ugh, more checkpatch errors:

ERROR: do not initialise statics to 0 or NULL
#120: FILE: arch/arm/mach-hi3xxx/hotplug.c:65:
+static void __iomem *ctrl_base = NULL;

Fixed this one too, but any more and the flames might start to appear.

Kevin
