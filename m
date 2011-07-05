From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 5 Jul 2011 23:35:10 +0800
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
In-Reply-To: <20110704062548.GI15152@ponder.secretlab.ca>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
	<1309681851-23052-4-git-send-email-shawn.guo@linaro.org>
	<20110704062548.GI15152@ponder.secretlab.ca>
Message-ID: <20110705153509.GA14954@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 12:25:48AM -0600, Grant Likely wrote:
> On Sun, Jul 03, 2011 at 04:30:51PM +0800, Shawn Guo wrote:
> > The patch adds device tree probe support for sdhci-esdhc-imx driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   40 ++++++++
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 |   99 +++++++++++++++++++-
> >  2 files changed, 134 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > new file mode 100644
> > index 0000000..e182e7c
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
> > +- cd-type : String, card detection (CD) method.  Supported values are:
> 
> Similar to previous comments, use the "fsl," prefix to this property name.
> 
I did not know even property name could be written like this.  I tried
it and found it works :)

> > +    "none" : No CD
> > +    "controller" : Uses eSDHC controller internal CD signal
> > +    "gpio" : Uses GPIO pin for CD
> 
> I would say the presence of a "cd-gpios" property would implicitly
> mean gpio is to be used for the CD pin.
> 
Yes, you are right.  But I would say this is a direct translation of
the existing platform_data.  After all, we are sharing most of code
path between platform and dt.

-- 
Regards,
Shawn
