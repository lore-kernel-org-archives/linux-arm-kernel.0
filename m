From: gmbnomis@gmail.com (Simon Baatz)
Date: Fri, 12 Aug 2016 19:12:50 +0200
Subject: [PATCH] ARM: kirkwood: ib62x0: fix size of u-boot environment
 partition
Message-ID: <1471021970-21248-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 148c274ea644 ("ARM: kirkwood: ib62x0: add u-boot environment
partition") split the "u-boot" partition into "u-boot" and "u-boot
environment".  However, instead of the size of the environment, an offset
was given, resulting in overlapping partitions.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Fixes: 148c274ea644 ("ARM: kirkwood: ib62x0: add u-boot environment partition")
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Luka Perkov <luka@openwrt.org>
Cc: stable at vger.kernel.org # 3.13+
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index ef84d8699a76..5bf62897014c 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -113,7 +113,7 @@
 
 	partition at e0000 {
 		label = "u-boot environment";
-		reg = <0xe0000 0x100000>;
+		reg = <0xe0000 0x20000>;
 	};
 
 	partition at 100000 {
-- 
2.7.4
