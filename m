From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:35:20 +0530
Subject: [PATCH v2 08/10] dts/ls2085a: Update Simulator DTS to add support of
 various peripherals
In-Reply-To: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441350322-4671-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2085a simulator DTS to add support of various
peripherals which are supported on the simulator platform and explicitly
disables those which are yet not supported on the platform.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   54 ++++++++++++++++++--
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index cf45d38..e874f7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -20,11 +20,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
  * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
@@ -63,3 +58,52 @@
 		interrupts = <0 58 0x1>;
 	};
 };
+
+&esdhc {
+	status = "disabled";
+};
+
+&ifc {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	status = "disabled";
+};
+
+&dspi {
+	status = "disabled";
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&sata0 {
+	status = "disabled";
+};
+
+&sata1 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "disabled";
+};
+
+&usb1 {
+	status = "disabled";
+};
+
-- 
1.7.9.5
