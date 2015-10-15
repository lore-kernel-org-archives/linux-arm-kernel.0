From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:35:43 +0800
Subject: [PATCH v6 04/10] ARM: dts: Add arm,
 pl330-broken-no-flushp quirk for rk3288 platform
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872943-2341-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rock-chips.com>

Pl330 integrated in rk3288 platform doesn't support
DMAFLUSHP function. So we add arm,pl330-broken-no-flushp quirk
for it.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Olof Johansson <olof@lixom.net>
cc: Sonny Rao <sonnyrao@chromium.org>

Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- amend the author
- add Reviewed-by: Doug Anderson <dianders@chromium.org>
- amend Olof's mail address

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.
- remove Sunny's tag

 arch/arm/boot/dts/rk3288.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..6978ff6 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -145,6 +145,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC2>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac_bus_ns: dma-controller at ff600000 {
@@ -156,6 +157,7 @@
 			clocks = <&cru ACLK_DMAC1>;
 			clock-names = "apb_pclk";
 			status = "disabled";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac_bus_s: dma-controller at ffb20000 {
@@ -166,6 +168,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 	};
 
-- 
2.3.7
