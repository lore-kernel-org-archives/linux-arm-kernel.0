From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Feb 2012 10:58:13 +0100
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <4F3945B1.9070900@samsung.com>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
 <4F3945B1.9070900@samsung.com>
Message-ID: <20120220095813.GB11307@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:17 Mon 13 Feb     , Karol Lewandowski wrote:
> On 09.02.2012 03:25, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> Hi!
> 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> > Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA at public.gmane.org
> > Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ at public.gmane.org
> > ---
> > v2:
> > 
> > 	use devm
> > 	update DT bindings to i2c-gpio and sda-open-drain...
> > 	update against "of: introduce helper to manage boolean"
> > 
> > Best Regards,
> > J.
> >  .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 +++++++
> >  drivers/i2c/busses/i2c-gpio.c                      |   95 +++++++++++++++----
> >  2 files changed, 107 insertions(+), 20 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > new file mode 100644
> > index 0000000..9710ed2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > @@ -0,0 +1,32 @@
> > +Device-Tree bindings for i2c gpio driver
> > +
> > +Required properties:
> > +	- compatible = "i2c-gpio";
> > +	- gpios: sda and scl gpio
> > +
> > +
> > +Optional properties:
> > +	- i2c-gpio,sda-open-drain: sda as open drain
> > +	- i2c-gpio,scl-open-drain: scl as open drain
> > +	- i2c-gpio,scl-output-only: scl as output only
> 
> 
> > +	- udelay: delay between GPIO operations (may depend on each platform)
> > +	- timeout: timeout to get data (ms)
> 
> 
> If these are really needed then I would prefer to have these fully
> qualified (with unit type "-ms/-millisecs" appended).
> 
> Regulator framework, with its "-microvolt/-microamp", serve here as
> prime example of being quite descriptive (one doesn't neet to look up
> the docs). Please see:
> 
>   http://permalink.gmane.org/gmane.linux.ports.arm.omap/67637
timeout are usualy in ms I don't really see the need of -ms or so

Best Regards,
J.
