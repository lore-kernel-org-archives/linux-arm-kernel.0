From: jon.mason@broadcom.com (Jon Mason)
Date: Mon,  5 Dec 2016 18:12:21 -0500
Subject: [PATCH 1/2] arm64: dts: NS2: reserve memory for Nitro firmware
In-Reply-To: <1480979542-26871-1-git-send-email-jon.mason@broadcom.com>
References: <1480979542-26871-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1480979542-26871-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nitro firmware is loaded into memory by the bootloader at a specific
location.  Set this memory range aside to prevent the kernel from using
it.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 96ed47b..9f9e203 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -30,6 +30,8 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/memreserve/ 0x81000000 0x00200000;
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/bcm-ns2.h>
 
-- 
2.7.4
