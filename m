From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 00:11:43 +0200
Subject: [PATCH 3/3] ARM: mxs: dts: Enable DCP for MXS
In-Reply-To: <21060.7210.127710.800708@ipc1.ka-ro>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-3-git-send-email-marex@denx.de>
 <21060.7210.127710.800708@ipc1.ka-ro>
Message-ID: <201309300011.44070.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lothar Wa?mann,

> Hi,
> 
> Marek Vasut writes:
> > Enable the DCP by default on both i.MX23 and i.MX28.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > To: linux-crypto at vger.kernel.org
> > ---
> > 
> >  arch/arm/boot/dts/imx23.dtsi | 4 +++-
> >  arch/arm/boot/dts/imx28.dtsi | 5 +++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> > index 87faa6e..0630a9a 100644
> > --- a/arch/arm/boot/dts/imx23.dtsi
> > +++ b/arch/arm/boot/dts/imx23.dtsi
> > @@ -337,8 +337,10 @@
> > 
> >  			};
> >  			
> >  			dcp at 80028000 {
> > 
> > +				compatible = "fsl,mxs-dcp";
> > 
> >  				reg = <0x80028000 0x2000>;
> > 
> > -				status = "disabled";
> > +				interrupts = <53 54>;
> > +				status = "okay";
> > 
> >  			};
> 
> AFAICT the policy seems to be that nodes, that are always enabled
> don't get a 'status' property at all.

Is this documented somewhere ?

Best regards,
Marek Vasut
