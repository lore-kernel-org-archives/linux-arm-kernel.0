From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  3 Aug 2016 14:38:58 -0400
Subject: [PATCH 03/11] ARM: dts: NSP: Specify RAM amount for BCM958625K board
In-Reply-To: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
References: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1470249546-12440-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 2GB of memory starting at physical offset 0x6000_0000.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625k.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index f41a13b..feed1b7 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -46,6 +46,11 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
 };
 
 &uart0 {
-- 
2.7.4
