From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Aug 2012 09:22:02 +0900
Subject: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs using
 'make dtbs'
In-Reply-To: <1346113322-21133-1-git-send-email-horms@verge.net.au>
References: <1346113322-21133-1-git-send-email-horms@verge.net.au>
Message-ID: <1346113322-21133-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Add compilation support for dtbs using 'make dtbs'

Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile.boot | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 498efd9..a1227ce 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -7,3 +7,7 @@ __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
 #
 #params_phys-y (Instead: Pass atags pointer in r2)
 #initrd_phys-y (Instead: Use compiled-in initramfs)
+
+dtb-$(CONFIG_MACH_KZM9G) += sh73a0-kzm9g.dtb
+dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dts
+dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dts
-- 
1.7.10.2.484.gcd07cc5
