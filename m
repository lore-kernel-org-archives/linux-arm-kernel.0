From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 15:12:56 +0100
Subject: [PATCH RFCv1 6/6] ARM: mvebu: update coherency fabric DT binding
 documentation
In-Reply-To: <1388067176-18177-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388067176-18177-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388067176-18177-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Marvell coherency fabric DT binding documentation to
provide an example that uses valid register addresses for the second
register pair. Take this opportunity to change the example to have
only register offsets from the internal register base address instead
of absolute addresses, as is now done in the real DT files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/coherency-fabric.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
index 6bd8788..857de26 100644
--- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
+++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
@@ -20,10 +20,7 @@ Required properties:
 
 Example:
 
-coherency-fabric at d0020200 {
+coherency-fabric at 20200 {
 	compatible = "marvell,armada-370-coherency-fabric";
-	reg = <0xd0020200 0xb0>,
-		<0xd0021810 0x1c>;
-
+	reg = <0x20200 0xb0>, <0x21010 0x1c>;
 };
-
-- 
1.8.3.2
