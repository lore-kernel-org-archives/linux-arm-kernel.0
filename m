From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 12 Dec 2012 14:21:23 +0100
Subject: imx_v6_v7_defconfig: use v7 optimized atomic64* instead of
 GENERIC_ATOMIC64?
Message-ID: <50C884D3.2070605@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Working mainly with the i.MX6 using the imx_v6_v7_defconfig, we get 
CONFIG_GENERIC_ATOMIC64=y due to

CONFIG_CPU_V6=y
CONFIG_CPU_V6K=y
CONFIG_CPU_V7=y

and

select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)

in arch/arm/Kconfig.

With this, on the V7 i.MX6 we use the (non-optimized) generic atomic64* 
implementation from lib/atomic64.c instead of the V7 optimized ones from 
arch/arm/include/asm/atomic.h.

Is this intended using imx_v6_v7_defconfig on V7 devices?

Is there any chance to use the optimized atomic64* functionality on V7 
with imx_v6_v7_defconfig? Or is this only possible by disabling 
CONFIG_CPU_V6 and CONFIG_CPU_V6K in the imx_v6_v7_defconfig?

Many thanks and best regards

Dirk
