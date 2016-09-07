From: wente.wang@nxp.com (Winter Wang)
Date: Wed, 7 Sep 2016 12:53:04 +0000
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: add sgtl5000 sound card
 support
In-Reply-To: <CAOMZO5CRQwOcHE1sHi35r6KjDvVh1Q5xTbBxL7gxZW2aNvgb6Q@mail.gmail.com>
References: <1473063707-31282-1-git-send-email-wente.wang@nxp.com>
 <CAOMZO5CRQwOcHE1sHi35r6KjDvVh1Q5xTbBxL7gxZW2aNvgb6Q@mail.gmail.com>
Message-ID: <AM3PR04MB52998B7D202FC6F1EFB8BC38FF80@AM3PR04MB529.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> To: Wente Wang <wente.wang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> Sascha Hauer <kernel@pengutronix.de>; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH] ARM: dts: imx6ul-pico-hobbit: add sgtl5000 sound card
> support
> 
> Hi Winter,
> 
> On Mon, Sep 5, 2016 at 5:21 AM, Winter Wang <wente.wang@nxp.com> wrote:
> > use simple-audio-card to support sgtl5000 with SAI interface.
> 
> Is this really needed? Currently we get audio working via sound/soc/fsl/fsl-
> asoc-card.c driver.
> > diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h
> > b/arch/arm/boot/dts/imx6ul-pinfunc.h
> > index 0034eeb..3397b49 100644
> > --- a/arch/arm/boot/dts/imx6ul-pinfunc.h
> > +++ b/arch/arm/boot/dts/imx6ul-pinfunc.h
> > @@ -924,7 +924,7 @@
> >  #define MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI              0x01fc 0x0488
> 0x053c 3 1
> >  #define MX6UL_PAD_CSI_DATA06__EIM_AD06                 0x01fc 0x0488
> 0x0000 4 0
> >  #define MX6UL_PAD_CSI_DATA06__GPIO4_IO27               0x01fc 0x0488
> 0x0000 5 0
> > -#define MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA             0x01fc 0x0488
> 0x0000 6 0
> > +#define MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA             0x01fc 0x0488
> 0x05E4 6 1
> 
> This should be a separate change and you need to explain it.
I'm trying to enable pico's sgtl5000 on 4.4 kernel, but recording is not working sometimes.
I think it may related with pinfunc.h, will check that.
