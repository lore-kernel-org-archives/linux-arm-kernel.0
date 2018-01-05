From: ran.wang_1@nxp.com (Ran Wang)
Date: Fri, 5 Jan 2018 17:40:06 +0800
Subject: [PATCH 1/4] arm: dts: ls1021a: Enable usb3-lpm-capable for usb3 node
Message-ID: <20180105094009.22599-1-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB3 HW LPM feature for ls1021a and active patch for
snps erratum A-010131. It will disable U1/U2 temperary when
initiate U3 request.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index f81fad2..21a4488 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -709,6 +709,8 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 		};
 
 		pcie at 3400000 {
-- 
1.7.1
