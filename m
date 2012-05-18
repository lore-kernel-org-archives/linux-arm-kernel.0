From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 May 2012 08:47:25 -0700
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120517104249.GI9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120516111744.GB9571@n2100.arm.linux.org.uk>
 <CACRpkdazMG1D6L6nWo330EWTZ_Fn6K0F5cjZSfMRGmk9OsaVXw@mail.gmail.com>
 <20120517104249.GI9571@n2100.arm.linux.org.uk>
Message-ID: <20120518154725.GA10583@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 11:42:50AM +0100, Russell King - ARM Linux wrote:
> On Wed, May 16, 2012 at 01:59:42PM +0200, Linus Walleij wrote:
> > Maybe just rename this thing cctl_memcpy then?
> 
> I've just noticed that arm-soc contains this (eg):
> 
> struct pl08x_channel_data spear310_dma_info[] = {
>         {
>                 .bus_id = "uart0_rx",
>                 .min_signal = 2,
>                 .max_signal = 2,
>                 .muxval = 0,
>                 .cctl = 0,
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 .periph_buses = PL08X_AHB1,
> 
> So, changing .cctl to .cctl_memcpy breaks the compilation for all the spear
> platforms.  Moreover, these explicit-zero initializers should not be here.
> Even with these gone, one still remains in the spear6xx code for their
> memcpy support.
> 
> Can we get these zero initializers killed for this merge window please.

Introduced by "SPEAr: Add PL080 DMA support for 3xx and 6xx". 

There are some muxval implicit 0 initalizers too, removed them while I was at
it.

Viresh, can I get an acked-by?


>From cda9fbb62852a1b1fc0b1e77eec8b916d0f4d762 Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 18 May 2012 08:43:39 -0700
Subject: [PATCH] ARM: spear3xx: remove some zero initalizers

Removing some unnecessary 0 initializers from platform pl08x platform
data structures.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-spear3xx/spear300.c | 38 --------------------------------------
 arch/arm/mach-spear3xx/spear310.c | 38 --------------------------------------
 arch/arm/mach-spear3xx/spear320.c | 38 --------------------------------------
 3 files changed, 114 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index f74a05b..e3d6933 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -119,183 +119,145 @@ struct pl08x_channel_data spear300_dma_info[] = {
 		.bus_id = "uart0_rx",
 		.min_signal = 2,
 		.max_signal = 2,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart0_tx",
 		.min_signal = 3,
 		.max_signal = 3,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_rx",
 		.min_signal = 8,
 		.max_signal = 8,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_tx",
 		.min_signal = 9,
 		.max_signal = 9,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c_rx",
 		.min_signal = 10,
 		.max_signal = 10,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c_tx",
 		.min_signal = 11,
 		.max_signal = 11,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "irda",
 		.min_signal = 12,
 		.max_signal = 12,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "adc",
 		.min_signal = 13,
 		.max_signal = 13,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "to_jpeg",
 		.min_signal = 14,
 		.max_signal = 14,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "from_jpeg",
 		.min_signal = 15,
 		.max_signal = 15,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras0_rx",
-		.min_signal = 0,
-		.max_signal = 0,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras0_tx",
 		.min_signal = 1,
 		.max_signal = 1,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras1_rx",
 		.min_signal = 2,
 		.max_signal = 2,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras1_tx",
 		.min_signal = 3,
 		.max_signal = 3,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras2_rx",
 		.min_signal = 4,
 		.max_signal = 4,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras2_tx",
 		.min_signal = 5,
 		.max_signal = 5,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras3_rx",
 		.min_signal = 6,
 		.max_signal = 6,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras3_tx",
 		.min_signal = 7,
 		.max_signal = 7,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras4_rx",
 		.min_signal = 8,
 		.max_signal = 8,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras4_tx",
 		.min_signal = 9,
 		.max_signal = 9,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras5_rx",
 		.min_signal = 10,
 		.max_signal = 10,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras5_tx",
 		.min_signal = 11,
 		.max_signal = 11,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras6_rx",
 		.min_signal = 12,
 		.max_signal = 12,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras6_tx",
 		.min_signal = 13,
 		.max_signal = 13,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras7_rx",
 		.min_signal = 14,
 		.max_signal = 14,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras7_tx",
 		.min_signal = 15,
 		.max_signal = 15,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	},
 };
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 84dfb09..13ee447 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -204,183 +204,145 @@ struct pl08x_channel_data spear310_dma_info[] = {
 		.bus_id = "uart0_rx",
 		.min_signal = 2,
 		.max_signal = 2,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart0_tx",
 		.min_signal = 3,
 		.max_signal = 3,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_rx",
 		.min_signal = 8,
 		.max_signal = 8,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_tx",
 		.min_signal = 9,
 		.max_signal = 9,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c_rx",
 		.min_signal = 10,
 		.max_signal = 10,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c_tx",
 		.min_signal = 11,
 		.max_signal = 11,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "irda",
 		.min_signal = 12,
 		.max_signal = 12,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "adc",
 		.min_signal = 13,
 		.max_signal = 13,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "to_jpeg",
 		.min_signal = 14,
 		.max_signal = 14,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "from_jpeg",
 		.min_signal = 15,
 		.max_signal = 15,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart1_rx",
-		.min_signal = 0,
-		.max_signal = 0,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart1_tx",
 		.min_signal = 1,
 		.max_signal = 1,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart2_rx",
 		.min_signal = 2,
 		.max_signal = 2,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart2_tx",
 		.min_signal = 3,
 		.max_signal = 3,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart3_rx",
 		.min_signal = 4,
 		.max_signal = 4,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart3_tx",
 		.min_signal = 5,
 		.max_signal = 5,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart4_rx",
 		.min_signal = 6,
 		.max_signal = 6,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart4_tx",
 		.min_signal = 7,
 		.max_signal = 7,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart5_rx",
 		.min_signal = 8,
 		.max_signal = 8,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart5_tx",
 		.min_signal = 9,
 		.max_signal = 9,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras5_rx",
 		.min_signal = 10,
 		.max_signal = 10,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras5_tx",
 		.min_signal = 11,
 		.max_signal = 11,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras6_rx",
 		.min_signal = 12,
 		.max_signal = 12,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras6_tx",
 		.min_signal = 13,
 		.max_signal = 13,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras7_rx",
 		.min_signal = 14,
 		.max_signal = 14,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ras7_tx",
 		.min_signal = 15,
 		.max_signal = 15,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	},
 };
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index a88fa84..8ceb0c5 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -212,183 +212,145 @@ struct pl08x_channel_data spear320_dma_info[] = {
 		.bus_id = "uart0_rx",
 		.min_signal = 2,
 		.max_signal = 2,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "uart0_tx",
 		.min_signal = 3,
 		.max_signal = 3,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_rx",
 		.min_signal = 8,
 		.max_signal = 8,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp0_tx",
 		.min_signal = 9,
 		.max_signal = 9,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c0_rx",
 		.min_signal = 10,
 		.max_signal = 10,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "i2c0_tx",
 		.min_signal = 11,
 		.max_signal = 11,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "irda",
 		.min_signal = 12,
 		.max_signal = 12,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "adc",
 		.min_signal = 13,
 		.max_signal = 13,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "to_jpeg",
 		.min_signal = 14,
 		.max_signal = 14,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "from_jpeg",
 		.min_signal = 15,
 		.max_signal = 15,
-		.muxval = 0,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB1,
 	}, {
 		.bus_id = "ssp1_rx",
-		.min_signal = 0,
-		.max_signal = 0,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "ssp1_tx",
 		.min_signal = 1,
 		.max_signal = 1,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "ssp2_rx",
 		.min_signal = 2,
 		.max_signal = 2,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "ssp2_tx",
 		.min_signal = 3,
 		.max_signal = 3,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "uart1_rx",
 		.min_signal = 4,
 		.max_signal = 4,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "uart1_tx",
 		.min_signal = 5,
 		.max_signal = 5,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "uart2_rx",
 		.min_signal = 6,
 		.max_signal = 6,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "uart2_tx",
 		.min_signal = 7,
 		.max_signal = 7,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2c1_rx",
 		.min_signal = 8,
 		.max_signal = 8,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2c1_tx",
 		.min_signal = 9,
 		.max_signal = 9,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2c2_rx",
 		.min_signal = 10,
 		.max_signal = 10,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2c2_tx",
 		.min_signal = 11,
 		.max_signal = 11,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2s_rx",
 		.min_signal = 12,
 		.max_signal = 12,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "i2s_tx",
 		.min_signal = 13,
 		.max_signal = 13,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "rs485_rx",
 		.min_signal = 14,
 		.max_signal = 14,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	}, {
 		.bus_id = "rs485_tx",
 		.min_signal = 15,
 		.max_signal = 15,
 		.muxval = 1,
-		.cctl = 0,
 		.periph_buses = PL08X_AHB2,
 	},
 };
-- 
1.7.10.1.488.g05fbf7a
