From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 30 Jun 2015 11:24:04 +0200
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150629091146.GA5103@amd>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
Message-ID: <20150630092404.GA19285@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Just tried booting 4.2-rc0 on n900 (commit
> 4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previous
> -rc0 version worked. This time, there's some output on console, but
> too fast for me to read.
> 
> It seems oopses happen before mounting root. If you have serial
> console, they should be easy to see.

I tried again according to pali's instructions, and it is still
broken the same way. Any other ideas? Does it work for you?

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..ff6f2bf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -570,6 +570,7 @@
 			interrupts = <49>;
 			dmas = <&sdma 69>;
 			dma-names = "rx";
+			status = "disabled";
 		};
 
 		smartreflex_core: smartreflex at 480cb000 {

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
