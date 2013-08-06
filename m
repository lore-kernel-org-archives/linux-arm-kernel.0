From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  6 Aug 2013 16:50:11 +0900
Subject: [PATCH v7 3/3] ARM: shmobile: lager: enable nfsroot in DTS
In-Reply-To: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
References: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375775411-4545-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Ether support has been added to the lager board
it is possible to use nfsroot. This configuration is
in line with that of other shmobile boards.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "ARM: shmobile: lager: enable Ether"

v6
* Do not add rsize and wsize settings.
  These do not seem to be useful.

v2
* Split out as a new patch from "ARM: shmobile: lager: enable Ether"
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 631b93b..203bd08 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -16,7 +16,7 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw";
+		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
 
 	memory at 40000000 {
-- 
1.8.3.2
