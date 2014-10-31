From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:31 +0100
Subject: [PATCH 2/6] ARM: nomadik: disable chrystals in top level board files
In-Reply-To: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
References: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1414788335-28334-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not force disable the chrystals in the SoC file, this is
per-board dependent.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 35c79eb24f93..1ee9372191df 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -182,8 +182,6 @@
 	src: src at 101e0000 {
 		compatible = "stericsson,nomadik-src";
 		reg = <0x101e0000 0x1000>;
-		disable-sxtalo;
-		disable-mxtalo;
 
 		/*
 		 * MXTAL "Main Chrystal" is a chrystal oscillator @19.2 MHz
-- 
1.9.3
