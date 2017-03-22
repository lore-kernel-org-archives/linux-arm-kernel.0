From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:07 -0500
Subject: [PATCH 09/15] ARM: dts: versatile: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-9-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/versatile-pb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 33a8eb28374e..8c936a16413b 100644
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
2.10.1
