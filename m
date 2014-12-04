From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Dec 2014 10:21:50 +0000
Subject: [PATCH v2 RESEND 09/11] mtd: st_spi_fsm: Provide documentation for
 boot device mask property
In-Reply-To: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
References: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1417688512-7644-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system configuration registers which display which device the system
booted on are in the same place on all boards which support the FSM.
However, the bits do shift every so slightly.  To combat these we're
adding a new property which supplies the necessary mask used to abstract
the required information.

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mtd/st-fsm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/st-fsm.txt b/Documentation/devicetree/bindings/mtd/st-fsm.txt
index c248939..2ef9710 100644
--- a/Documentation/devicetree/bindings/mtd/st-fsm.txt
+++ b/Documentation/devicetree/bindings/mtd/st-fsm.txt
@@ -11,6 +11,10 @@ Optional properties:
   - st,syscfg          : Phandle to boot-device system configuration registers
   - st,boot-device-reg : Address of the aforementioned boot-device register(s)
   - st,boot-device-spi : Expected boot-device value if booted via this device
+  - st,boot-device-msk : Mask to use when extracting boot device from the
+			 above system config registers
+  NB: If any of the st,boot-device-* properties are missing, the driver falls
+  back to the default assumption of 'booted from SPI'.
 
 Example:
 	spifsm: spifsm at fe902000{
-- 
1.9.1
