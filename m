From: yao.yuan@nxp.com (Yao Yuan)
Date: Tue, 8 Mar 2016 02:03:21 +0000
Subject: [PATCH v4 4/7] Documentation: fsl-quadspi: Add fsl,ls2080a-dspi
 compatible string
In-Reply-To: <20160307203200.GW55664@google.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
 <1453793041-35868-4-git-send-email-yao.yuan@freescale.com>
 <20160307203200.GW55664@google.com>
Message-ID: <AM2PR04MB0722F2CC1847AA5E9FDD96F289B20@AM2PR04MB0722.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 4:32AM, Brian Norris wrote:
> On Tue, Jan 26, 2016 at 03:23:58PM +0800, Yuan Yao wrote:
> > new compatible string: "fsl,ls2080a-qspi".
> 
> ^^ This line doesn't match the subject or the content of the patch.
> 
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changed in v4:
> > No changes.
> >
> > Changed in v3:
> > Add the modifier for new compatible string like:
> > "fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
> >
> > Changed in v2:
> > Update my email to <yao.yuan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 5 ++++-
> 
> ^^ What is this change doing in this series anyway? You're touching MTD stuff,
> not SPI stuff, and this string doesn't get used in any driver. Is this controller
> somehow related, or is it a separate IP block that happens to be on some of the
> same SoCs?
> 

Sorry for the wrong subject, this patch is used for add the SPI(DSPI) binging document.
It should be some mistake that I make the wrong subject and the commit message.

> Anyway, you should send this kind of stuff to the SPI list, not the MTD one.

I will resend it to SPI list, thanks for your review.

> Regards,
> Brian
> 
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > index fa77f87..1ad0fe3 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > @@ -1,7 +1,10 @@
> >  ARM Freescale DSPI controller
> >
> >  Required properties:
> > -- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi", "fsl,ls2085a-dspi"
> > +- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
> > +		"fsl,ls2085a-dspi"
> > +		or
> > +		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
> >  - reg : Offset and length of the register set for the device
> >  - interrupts : Should contain SPI controller interrupt
> >  - clocks: from common clock binding: handle to dspi clock.
> > --
> > 2.1.0.27.g96db324
> >
