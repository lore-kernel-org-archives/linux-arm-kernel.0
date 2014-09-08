From: nm@ti.com (Nishanth Menon)
Date: Mon, 8 Sep 2014 13:47:27 -0500
Subject: [PATCH 6/6] ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable
In-Reply-To: <1408716235-26164-7-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
 <1408716235-26164-7-git-send-email-nm@ti.com>
Message-ID: <20140908184727.GA2103@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:03-20140822, Nishanth Menon wrote:
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins>;
> +	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH
> +			       &dra7_pmx_core 0x3e0>;
^^
Thanks to Lee Jones pointing this out to me in a different context[1]
I made the wrong usage. Fixing the syntax to stay in sync with
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

[1] http://marc.info/?l=linux-omap&m=140930980325273&w=2

-----8<----
>From c3c284ebd2b8d5535abf297ef7537b2caa7fe67b Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Fri, 6 Jun 2014 20:53:22 -0500
Subject: [PATCH V2 6/6] ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable

Mark rxd as wakeupcapable for 115200n8 no hardware-flow control
configuration. If h/w flow control is being used, then rts/cts
appropriately should be used.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 50f8022..08434c7 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -303,6 +303,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
+	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			      <&dra7_pmx_core 0x3e0>;
 };
 
 &uart2 {
-- 
1.7.9.5


-- 
Regards,
Nishanth Menon
