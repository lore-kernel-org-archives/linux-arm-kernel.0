From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Jul 2017 16:09:40 -0500
Subject: [PATCH v2] ARM: dts: versatile: fix PCI bus dtc warnings
In-Reply-To: <20170726210943.6875-1-robh@kernel.org>
References: <20170726210943.6875-1-robh@kernel.org>
Message-ID: <20170726210943.6875-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
---
v2:
- rebase on v4.13-rc2

arm-soc, Please apply as Versatile has no maintainer.

 arch/arm/boot/dts/versatile-pb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 06e2331f666d..9abe26028c8b 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -39,7 +39,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		pci-controller at 10001000 {
+		pci at 10001000 {
 			compatible = "arm,versatile-pci";
 			device_type = "pci";
 			reg = <0x10001000 0x1000
-- 
2.11.0
