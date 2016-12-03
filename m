From: shawnguo@kernel.org (Shawn Guo)
Date: Sat,  3 Dec 2016 20:36:40 +0800
Subject: [PATCH] arm64: dts: zte: clean up gic-v3 redistributor properties
Message-ID: <1480768600-20827-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gic-v3 property redistributor-stride is only meant as a workaround
for broken platforms that have a redistributor stride deviating what the
architecture defines, i.e. 128KiB for GICv3, 256KiB for GICv4.  This is
not the case for ZX296718, and redistributor-stride is not really
necessary.  Let's drop it.

Also, #redistributor-regions is only required when there is more than
one such region is present.  Let's remove it as well.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 6b239a365f01..dd2cd73c774c 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -239,8 +239,6 @@
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
-		#redistributor-regions = <1>;
-		redistributor-stride = <0x20000>;
 		interrupt-controller;
 		reg = <0x02a00000 0x10000>,
 		      <0x02b00000 0xc0000>;
-- 
1.9.1
