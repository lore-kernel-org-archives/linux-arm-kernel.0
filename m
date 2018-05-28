From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 28 May 2018 11:01:36 -0700
Subject: [PATCH v4 5/6] arm64: dt: set initial SR watchdog timeout to 60
 seconds
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set initial Stingray watchdog timeout to 60 seconds

By the time when the userspace watchdog daemon is ready and taking
control over, the watchdog timeout will then be reset to what's
configured in the daemon

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..1e1cf49 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -420,6 +420,7 @@
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
 			clock-names = "wdogclk", "apb_pclk";
+			timeout-sec = <60>;
 		};
 
 		gpio_hsls: gpio at d0000 {
-- 
2.1.4
