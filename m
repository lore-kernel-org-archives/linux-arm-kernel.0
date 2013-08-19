From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Aug 2013 21:53:17 +0800
Subject: [PATCH] ARM: dts: imx6sl reuses imx6q sdma firmware
In-Reply-To: <20130819123541-7656@mutt-kz>
References: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
 <20130819123541-7656@mutt-kz>
Message-ID: <20130819135315.GA28297@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 02:35:42PM +0200, Luka Perkov wrote:
> Hi Shawn,
> 
> On Mon, Aug 19, 2013 at 05:09:46PM +0800, Shawn Guo wrote:
> > There is no imx6sl specific sdma firmware.  Instead, imx6sl reuses
> > imx6q sdma firmware.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6sl.dtsi |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> > index c46651e..9fec772 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -619,7 +619,8 @@
> >  					 <&clks IMX6SL_CLK_SDMA>;
> >  				clock-names = "ipg", "ahb";
> >  				#dma-cells = <3>;
> > -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
> > +				/* imx6sl reuses imx6q sdma firmware */
> > +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
> 
> As you may have noticed my patch changes both imx6sl.dtsi and
> imx6qdl.dtsi because of the naming convention used in other sdma
> firmwares:

The convention is to use SoC name to specify the firmware for particular
SoC.  imx6 is not a SoC name.  Sure, sdma-imx6sl.bin is incorrect since
there is no imx6sl specific sdma firmware.  Instead, it reuses imx6q
one.

> 
> $ fgrep sdma-ram-script-name arch/arm/boot
> arch/arm/boot/dts/imx6qdl.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
> arch/arm/boot/dts/imx6sl.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
> arch/arm/boot/dts/imx51.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
> arch/arm/boot/dts/imx53.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
> 
> Also, last patch containing sdma firmware blobs sent to the mailing list
> [1] uses "sdma-imx6.bin" name.

The patch never got merged.  I do not like the name, simply because imx6
is not a SoC name.

> That is why I think patch I have sent
> recently [2] is more appropriate. Don't you think so?

No, I do not think so, and that's why I sent my version with you on Cc.

Shawn

> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143025.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191108.html
