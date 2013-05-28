From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 28 May 2013 15:57:01 -0700
Subject: build failure: linux-next: ARM/SH-mobile defconfigs: kota2, marzen
Message-ID: <87txlmaf2a.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Both kota2_defconfig and marzen_defconfig started failing in the most
recnet linux-next (next-20130527) but were successful in the previous
build (next-20130523).

Both fail wit this error:

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
/work/kernel/next/drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to `shdma_chan_filter'
make[1]: *** [vmlinux] Error 1
make[1]: Target `_all' not remade because of errors.

Full build logs are available here:

  https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=kota2_defconfig,label=kernel_cloud/54/console
  https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=marzen_defconfig,label=kernel_cloud/54/console

Kevin
