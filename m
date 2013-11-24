From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:38:51 -0500
Subject: [PATCH 1/2] ARM: dts: OMAP5: Add maintenance interrupt for
 virtualisation
In-Reply-To: <1385251666-27532-2-git-send-email-santosh.shilimkar@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
 <1385251666-27532-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <52914A9B.7040602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 November 2013 07:07 PM, Santosh Shilimkar wrote:
> Add a maintenance IRQ using PPI 9 to OMAP5 device tree
> needed for virtualisation.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Beno?t Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index fc3fad5..c9f1ae4 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -74,6 +74,7 @@
>  		      <0x48212000 0x1000>,
>  		      <0x48214000 0x2000>,
>  		      <0x48216000 0x2000>;
> +		interrupts = <1 9 0x304>;
I should have used the GIC flags. Updated version end of the
email.

Regards,
Santosh


>From 91cbd5f65ccd9a0780614fa7ab5505922bdce577 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 12 Sep 2013 15:53:13 -0400
Subject: [PATCH 1/2] ARM: dts: OMAP5: Add maintenance interrupt for
 virtualisation

Add a maintenance IRQ using PPI 9 to OMAP5 device tree
needed for virtualisation.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..907ab7b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -74,6 +74,7 @@
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	/*
-- 
1.7.9.5
