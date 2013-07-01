From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Jul 2013 16:20:34 +0900
Subject: [PATCH v4 3/3] ARM: shmobile: lager: enable nfsroot in DTS
In-Reply-To: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372663234-13486-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Ether support has been added to the lager board
it is possible to use nfsroot. This configuration is
in line with that of other shmobile boards.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "ARM: shmobile: lager: enable Ether"

v2
* Split out as a new patch from "ARM: shmobile: lager: enable Ether"
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 09a84fc..b2f61f0 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -16,7 +16,7 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel";
+		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw";
 	};
 
 	memory at 40000000 {
-- 
1.8.2.1
