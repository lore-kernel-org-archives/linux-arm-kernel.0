From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 13 May 2014 13:40:46 -0300
Subject: [PATCH RESEND v4 1/8] clk: sunxi: Implement A31 USB clock
In-Reply-To: <1399995862-17788-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399995862-17788-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53724B0E.1010307@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 13/05/14 12:44, Maxime Ripard escribi?:
> The A31 USB clock slightly differ from its older counterparts, mostly because
> it has a different gate for each PHY, while the older one had a single gate for
> all the phy.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mike Turquette <mturquette@linaro.org>

I have queued this commit in sunxi-clk-for-mike for my 3.16 pull. I have 
also queued the trivial patch below to keep the new compatible documented.

Cheers,

Emilio

--->8---

clk: sunxi: document new A31 USB clock compatible

Support for the USB gates and resets on A31 has been recently added
using a new compatible, so let's document it here.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
  1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt 
b/Documentation/devicetree/bindings/clock/sunxi.txt
index a5160d8..1f6d3f4 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -41,6 +41,7 @@ Required properties:
  	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
  	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
  	"allwinner,sun5i-a13-usb-clk" - for usb gates + resets on A13
+	"allwinner,sun6i-a31-usb-clk" - for usb gates + resets on A31

  Required properties for all clocks:
  - reg : shall be the control register address for the clock.
-- 
1.9.2
