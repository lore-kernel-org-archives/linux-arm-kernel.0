From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:39:31 +0900
Subject: [PATCH v2 2/4] ARM: shmobile: marzen: Remove early_printk from
 command line
In-Reply-To: <1400153973-25546-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153973-25546-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153973-25546-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As early printk support is not enabled in the kernel in the
shmobile defconfig it does not make much sense to provide for
it in the default command line.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added Ack from Laruent Pinchart
* Enhanced change log based on feedback from Laurent Pinchart
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 363f693..3212908 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -19,7 +19,7 @@
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
 	chosen {
-		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
 	};
 
 	memory {
-- 
1.8.5.2
