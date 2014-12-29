From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:48 +0900
Subject: [PATCH 6/6] ARM: shmobile: lager dts: Drop console= bootargs parameter
In-Reply-To: <cover.1419809774.git.horms+renesas@verge.net.au>
References: <cover.1419809774.git.horms+renesas@verge.net.au>
Message-ID: <569dd56c9971c699472d3b270e988baf7f6de8c9.1419809774.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit FIXME ("ARM: shmobile: lager: Remove legacy board support"),
lager is restricted to booting from DT, so chosen/stdout-path is always
used, and we can drop the "console=" parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index ec84319..4118030 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -52,7 +52,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scifa0;
 	};
 
-- 
2.1.3
