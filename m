From: Baohua.Song@csr.com (Barry Song)
Date: Sun, 4 Sep 2011 22:15:17 -0700
Subject: [PATCH 2/3] ARM: CSR: extend the compatibility of gpio controller to
	pinmux in dts
In-Reply-To: <1315199718-10102-1-git-send-email-Baohua.Song@csr.com>
References: <1315199718-10102-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1315199718-10102-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio controller handles the switch of gpio and pinmux. And drivers/pinctrl/pinmux-sirf.c
will contain both gpio and pinmux.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2-cb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
index a0a423d..af86931 100644
--- a/arch/arm/boot/dts/prima2-cb.dts
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -279,7 +279,7 @@
 			gpio: gpio-controller at b0120000 {
 				#gpio-cells = <2>;
 				#interrupt-cells = <2>;
-				compatible = "sirf,prima2-gpio";
+				compatible = "sirf,prima2-gpio-pinmux";
 				reg = <0xb0120000 0x10000>;
 				gpio-controller;
 				interrupt-controller;
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
