From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 30 Jan 2014 13:54:53 +0800
Subject: [PATCH 2/2] ARM: dts: sirf: add pin group for USP0 with only RX or TX
 frame sync for atlas6
Message-ID: <1391061293-2195-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

add pin groups for USP0 only holding one of TX and RX frame sync. this patch
matches with the change in drivers/pinctrl/sirf.

commit 73f68c01f46 did this for prima2, but missed prima2. this patch fixes
the problem.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 0c81dc9..8e60ae1 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -551,6 +551,18 @@
                                                 sirf,function = "usp0_uart_nostreamctrl";
                                         };
                                 };
+				usp0_only_utfs_pins_a: usp0 at 2 {
+					usp0 {
+						sirf,pins = "usp0_only_utfs_grp";
+						sirf,function = "usp0_only_utfs";
+					};
+				};
+				usp0_only_urfs_pins_a: usp0 at 3 {
+					usp0 {
+						sirf,pins = "usp0_only_urfs_grp";
+						sirf,function = "usp0_only_urfs";
+					};
+				};
                                 usp1_pins_a: usp1 at 0 {
                                         usp1 {
                                                 sirf,pins = "usp1grp";
-- 
1.7.5.4
