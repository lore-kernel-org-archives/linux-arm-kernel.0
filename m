From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Tue, 18 Jun 2013 21:49:19 +0530
Subject: linux-next: origen build failed at drivers/pinctrl/pinctrl-exynos.c
Message-ID: <CA+G9fYu3_-RZxFyRENuqJvzsM=YToT7PG+5fUytMzhsFu3=z7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

linux-next branch failed to build origen build

defconfig: exynos_defconfig

full build log:
----------------
https://ci.linaro.org/jenkins/job/linux-next/hwpack=origen,label=kernel_cloud/72/console

build error log:
--------------------
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:
In function ?exynos_wkup_irq_mask?:
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:299:3:
error: implicit declaration of function ?exynos_wkup_irq_ack?
[-Werror=implicit-function-declaration]
05:02:12    exynos_wkup_irq_ack(irqd);
05:02:12    ^
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:
At top level:
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:310:13:
warning: conflicting types for ?exynos_wkup_irq_ack? [enabled by
default]
05:02:12  static void exynos_wkup_irq_ack(struct irq_data *irqd)
05:02:12              ^
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:310:13:
error: static declaration of ?exynos_wkup_irq_ack? follows non-static
declaration
05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:299:3:
note: previous implicit declaration of ?exynos_wkup_irq_ack? was here
05:02:12    exynos_wkup_irq_ack(irqd);
05:02:12    ^
05:02:12 cc1: some warnings being treated as errors
05:02:12 make[3]: *** [drivers/pinctrl/pinctrl-exynos.o] Error 1
05:02:12 make[2]: *** [drivers/pinctrl] Error 2

Best regards
Naresh kamboju
