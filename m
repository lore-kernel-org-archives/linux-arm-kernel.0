From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 23:43:15 +0800
Subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
In-Reply-To: <CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
	<1309879568-25837-4-git-send-email-shawn.guo@linaro.org>
	<CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
Message-ID: <20110706154314.GC4034@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:54:34AM -0600, Grant Likely wrote:
> On Tue, Jul 5, 2011 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > The patch adds device tree probe support for sdhci-esdhc-imx driver.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > ?.../devicetree/bindings/mmc/fsl-imx-esdhc.txt ? ? ?| ? 40 ++++++++
> > ?drivers/mmc/host/sdhci-esdhc-imx.c ? ? ? ? ? ? ? ? | ?102 +++++++++++++++++++-
> > ?2 files changed, 137 insertions(+), 5 deletions(-)
> > ?create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > new file mode 100644
> > index 0000000..351d239
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -0,0 +1,40 @@
> > +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> > +
> > +The Enhanced Secure Digital Host Controller on Freescale i.MX family
> > +provides an interface for MMC, SD, and SDIO types of memory cards.
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-esdhc"
> > +- reg : Should contain eSDHC registers location and length
> > +- interrupts : Should contain eSDHC interrupt
> > +- cd-type : String, card detection (CD) method. ?Supported values are:
> > + ? ?"none" : No CD
> > + ? ?"controller" : Uses eSDHC controller internal CD signal
> > + ? ?"gpio" : Uses GPIO pin for CD
> > + ? ?"permanent" : No CD because card is permanently wired to host
> > +- wp-type : String, write protection (WP) method. ?Supported values are:
> > + ? ?"none" : No WP
> > + ? ?"controller" : Uses eSDHC controller internal WP signal
> > + ? ?"gpio" : Uses GPIO pin for WP
> > +- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, if
> > + ?properties cd-type and wp-type are "gpio".
> 
> Again, be explicit in your gpios property names.  Create a different
> property for each gpio: cd-gpios and wp-gpios.
> 
> As for wp-type and cd-type, I think you can drop them.  Default to
> internal controller CD and WP pins.  Use gpio if cd-gpios or wp-gpios
> is present, and define specific properties for the no-wp, no-cd and
> fixed-card cases.  (can you tell that I'm not a fan of the "*-type"
> binding for this driver?)  :-)
> 
I would let default be no CD/WP, and define properties for
controller internal CD/WP and wired case, if you do not see a
problem with it.

-- 
Regards,
Shawn
