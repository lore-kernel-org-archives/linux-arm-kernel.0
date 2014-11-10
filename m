From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:25 +0900
Subject: [PATCH 8/8] ARM: shmobile: alt dts: Drop console= bootargs parameter
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
Message-ID: <89aeff9989e87bb2d9d652994010bc18c68675d9.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alt is booted from DT, so chosen/stdout-path is
always used, and we can drop the "console=" parameter from chosen/bootargs.

This change has a side-effect of changing the console speed from 38400
to 115200. This is intentional as 115200 is consistently used on
all other shmobile boards.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 8aec512..f2cf757 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif2;
 	};
 
-- 
2.1.1
