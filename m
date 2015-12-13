From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 13 Dec 2015 10:15:17 +0100
Subject: [PATCH 2/2 v2] ARM: Documentation: l2c2x0: Mention separate
 controllers explicitly
In-Reply-To: <1449998117-5998-1-git-send-email-dirk.behme@gmail.com>
References: <1449998117-5998-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1449998117-5998-2-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation in l2c2x0.txt is only valid for L2C210/L2C220/L2C310
(also known as PL210/PL220/PL310 and variants). Mention this explicitly.
And add a note why this isn't valid for integrated L2 controllers.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Changes in v2:
Teplace the PL prefix with L2C

 Documentation/devicetree/bindings/arm/l2c2x0.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index 06c88a4..1c04354 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -1,7 +1,8 @@
 * ARM L2 Cache Controller
 
-ARM cores often have a separate level 2 cache controller. There are various
-implementations of the L2 cache controller with compatible programming models.
+ARM cores often have a separate L2C210/L2C220/L2C310 (also known as PL210/PL220/
+PL310 and variants) based level 2 cache controller. All these various implementations
+of the L2 cache controller have compatible programming models (Note 1).
 Some of the properties that are just prefixed "cache-*" are taken from section
 3.7.3 of the ePAPR v1.1 specification which can be found at:
 https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
@@ -91,3 +92,9 @@ L2: cache-controller {
         cache-level = <2>;
 	interrupts = <45>;
 };
+
+Note 1: The description in this document doesn't apply to integrated L2
+	cache controllers as found in e.g. Cortex-A15/A7/A57/A53. These
+	integrated L2 controllers are assumed to be all preconfigured by
+	early secure boot code. Thus no need to deal with their configuration
+	in the kernel at all.
-- 
2.6.4
