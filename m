From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 08:50:09 +0200
Subject: [PATCH 2/2] ARM: shmobile: kzm9g-reference: Remove early_printk from
 command line
In-Reply-To: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
References: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404715809-31331-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As early printk is not supported when devices are initialised
using DT, so remove it from the command line.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index a99171c..838f93e4 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -35,7 +35,7 @@
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200 rw";
+		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel rw";
 	};
 
 	memory {
-- 
2.0.0.rc2
