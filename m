From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jun 2017 18:51:23 +0200
Subject: [PATCH 2/4] arm64: dts: marvell: armada-3720-db: Add information
 about the V2 board
In-Reply-To: <20170608165125.27630-1-gregory.clement@free-electrons.com>
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
Message-ID: <20170608165125.27630-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial device tree file was for the board V1.4. Now the V2.0 board
is also available. The same dtb will work for both, but the CON number
have changed, so update the comment in the dts to reflect this.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index d6f12fafac6c..3ee920ac0015 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -42,6 +42,10 @@
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * This file is compatible with the version 1.4 and the version 2.0 of
+ * the board, however the CON numbers are different between the 2
+ * version
  */
 
 /dts-v1/;
@@ -78,6 +82,7 @@
 	};
 };
 
+/* Gigabit module on CON19(V2.0)/CON21(V1.4) */
 &eth0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -86,6 +91,7 @@
 	status = "okay";
 };
 
+/* Gigabit module on CON18(V2.0)/CON20(V1.4) */
 &eth1 {
 	phy-mode = "sgmii";
 	phy = <&phy1>;
@@ -133,7 +139,7 @@
 	};
 };
 
-/* CON17 (PCIe) / CON12 (mini-PCIe) */
+/* CON15(V2.0)/CON17(V1.4) : PCIe / CON15(V2.0)/CON12(V1.4) :mini-PCIe */
 &pcie0 {
 	status = "okay";
 };
@@ -184,19 +190,22 @@
 	};
 };
 
-/* Exported on the micro USB connector CON32 through an FTDI */
+/*
+ * Exported on the micro USB connector CON30(V2.0)/CON32(V1.4) through
+ * an FTDI
+ */
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
 	status = "okay";
 };
 
-/* CON27 */
+/* CON27(V2.0)/CON29(V1.4) */
 &usb2 {
 	status = "okay";
 };
 
-/* CON31 */
+/* CON29(V2.0)/CON31(V1.4) */
 &usb3 {
 	status = "okay";
 	usb-phy = <&usb3_phy>;
-- 
2.11.0
