From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:26 +0900
Subject: [PATCH 5/9] ARM: shmobile: lager: Fix adv7511 IRQ sensing
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <850346eccc2d32dd6d0a3b08e6ac127b8982c067.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The adv7511 IRQ is low level triggered, not falling edge triggered. The
wrong sense configuration results in no interrupt being triggered at
all, breaking hotplug detection. Fix it.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5ae07a8385c5..37dec5269491 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -548,7 +548,7 @@
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
2.1.4
