From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 25 Dec 2014 13:25:19 +0100
Subject: [PATCH] ARM: dts: sun6i: ippo-q8h-v5: Fix serial0 alias
In-Reply-To: <1419510319-32400-1-git-send-email-hdegoede@redhat.com>
References: <1419510319-32400-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1419510319-32400-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ippo q8h has its serial console connected to the r-uart. Adjust the
serial0 alias to match.

This fixes the kernel serial console no longer working since 3.19-rc1, because
8250_dw.c now honors dt aliases, causing the serial console to be ttyS5 rather
then being ttyS0, as it was in 3.18 and before.

Note that adjusting bootargs instead is not an acceptable fix, because
console=ttyS0,115200 is used by a lot of bootscripts, etc. and this should
continue to work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 7f2117c..32ad808 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -55,6 +55,10 @@
 	model = "Ippo Q8H Dual Core Tablet (v5)";
 	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
 
+	aliases {
+		serial0 = &r_uart;
+	};
+
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
-- 
2.1.0
