From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 11 Oct 2013 12:44:16 +0200
Subject: CONFIG_HZ=250 on Kirkwood
Message-ID: <5257D680.6040400@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

according to a statement from Russell King:

commit b28748fb5d21d5d64c9ce31579ffbbd41f317042
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Feb 17 14:40:33 2013 +0000

     ARM: add SCHED_HRTICK config option

     As we don't include kernel/Kconfig.hz as this defines HZ values
     unsuitable for ARM platforms, add the SCHED_HRTICK to properly 
configure
     the scheduler for hrtimer operation.

     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


and to arch/arm/Kconfig:

config HZ
         int
         default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
                 ARCH_S5PV210 || ARCH_EXYNOS4
         default AT91_TIMER_HZ if ARCH_AT91
         default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
         default 100

the only safe value for CONFIG_HZ on Kirkwood would be 100.

We would like to use CONFIG_HZ=250 on our Kirkwood devices and NOT use 
the SCHED_HRTICK feature.
Does anyone have know whether (and why) this would be a bad idea?

Thanks a lot!
Gerlando
