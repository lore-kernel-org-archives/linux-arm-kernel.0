From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 12:22:03 +0800
Subject: [PATCH 1/3] ARM: sun8i: a83t: Drop skeleton.dtsi
In-Reply-To: <20170418042205.27894-1-wens@csie.org>
References: <20170418042205.27894-1-wens@csie.org>
Message-ID: <20170418042205.27894-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

skeleton.dtsi is deprecated. Remove it from sun8i-a83t.dtsi and add
the needed device nodes directly.

Also drop an extra, non-style-conforming line in the copyright license
header.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 0ec143773ee9..913aacafe8d5 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -40,15 +40,20 @@
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
-
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+	};
+
+	chosen {
+	};
 
 	cpus {
 		#address-cells = <1>;
@@ -146,6 +151,11 @@
 		};
 	};
 
+	memory {
+		reg = <0x40000000 0x80000000>;
+		device_type = "memory";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.11.0
