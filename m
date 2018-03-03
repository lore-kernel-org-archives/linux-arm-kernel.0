From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  3 Mar 2018 19:40:43 -0300
Subject: [PATCH v2 4/5] ARM: dts: vf610m4: Remove skeleton.dtsi inclusion
In-Reply-To: <1520116844-1145-1-git-send-email-festevam@gmail.com>
References: <1520116844-1145-1-git-send-email-festevam@gmail.com>
Message-ID: <1520116844-1145-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as
deprecated") the inclusion of skeleton.dtsi is deprecated, so
remove it as this file will eventually go away someday.

Move its content to the SoC dtsi file, so that the resultant dtb
is the same.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- None

 arch/arm/boot/dts/vf610m4.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
index 1474bd3..5d52af2 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -42,10 +42,17 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include "vfxxx.dtsi"
 
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0>; };
+};
+
 &mscm_ir {
 	interrupt-parent = <&nvic>;
 };
-- 
2.7.4
