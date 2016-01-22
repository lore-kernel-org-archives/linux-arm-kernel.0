From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 22 Jan 2016 19:06:48 +0800
Subject: [PATCH v7 5/9] ARM: dts: Add arm,
 pl330-broken-no-flushp quirk for rk3xxx platform
In-Reply-To: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1453460812-8498-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Pl330 integrated in rk3xxx platform doesn't support
DMAFLUSHP function. So we add arm,pl330-broken-no-flushp quirk
for it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.

 arch/arm/boot/dts/rk3xxx.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99eeea7..0012049 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -80,6 +80,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac1_ns: dma-controller at 2001c000 {
@@ -90,6 +91,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 			status = "disabled";
 		};
 
@@ -101,6 +103,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA2>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 	};
 
-- 
1.9.1
