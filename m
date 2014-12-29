From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:46 +0900
Subject: [PATCH 4/6] ARM: shmobile: lager: Rename SCIFA[01] serial ports to
 ttySC[01]
In-Reply-To: <cover.1419809774.git.horms+renesas@verge.net.au>
References: <cover.1419809774.git.horms+renesas@verge.net.au>
Message-ID: <78c11ec2e0c63262bae78c99872d4df81fb6d1e6.1419809774.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

There's no reason to name the only two available serial ports on the
board ttySC6 and ttySC7 (apart from confusing userspace, which we should
try to avoid).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 636d53b..ec84319 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -47,12 +47,12 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial6 = &scifa0;
-		serial7 = &scifa1;
+		serial0 = &scifa0;
+		serial1 = &scifa1;
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "console=ttySC0,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scifa0;
 	};
 
-- 
2.1.3
