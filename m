From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 17:30:34 +0800
Subject: [PATCH v3 2/5] ARM: dts: imx27: Add imx framebuffer device
In-Reply-To: <1372432206.785926201@f326.mail.ru>
References: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
 <1372431037-13519-3-git-send-email-mpa@pengutronix.de>
 <1372432206.785926201@f326.mail.ru>
Message-ID: <20130701093032.GG13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 07:10:06PM +0400, Alexander Shiyan wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index 8603886..10dcbd3 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -342,6 +342,15 @@
> >  			reg = <0x10020000 0x20000>;
> >  			ranges;
> >  
> > +			imxfb: fb at 10021000 {
> 
> If it can be fixed while applying, it would be right to use just "fb" here.
> We now use a lot of devices without "imx"-prefix, so I do not see any need to use it here.

I actually prefer to use the block name if it's not a thing defined by
ePAPR.  In this case, it's "lcdc".  But since "fb" is already used in
compatible.  Okay, I fixed it up by dropping "imx" prefix.

Applied the whole series, thanks.

Shawn
