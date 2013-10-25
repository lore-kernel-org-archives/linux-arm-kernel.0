From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 25 Oct 2013 16:14:30 +0800
Subject: [PATCH v3 5/5] ARM: dts: imx28: changing usb compatible string
 as only "fsl,imx28-usb"
In-Reply-To: <20131025082330.GA13790@S2101-09.ap.freescale.net>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-5-git-send-email-peter.chen@freescale.com>
 <20131025082330.GA13790@S2101-09.ap.freescale.net>
Message-ID: <20131025081429.GA10442@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 04:23:32PM +0800, Shawn Guo wrote:
> On Fri, Oct 25, 2013 at 02:02:23PM +0800, Peter Chen wrote:
> > Due to imx28 usb has special write request, it is not compatible
> > with other imx27 sytle usb controllers.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx28.dtsi |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 7363fde..6cd2607 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -1041,7 +1041,7 @@
> >  		ranges;
> >  
> >  		usb0: usb at 80080000 {
> > -			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
> > +			compatible = "fsl,imx28-usb";
> 
> You shouldn't need the change as long as you put "fsl,imx28-usb" before
> "fsl,imx27-usb" in driver ci_hdrc_imx_dt_ids[] table.
> 

I know it can work without this dts change, but that driver change like
a workaround. Since the imx28-usb is not compatible with imx27-usb,
we'd better only keep "fsl, imx28-usb" compatible string at imx28 dtsi.

-- 

Best Regards,
Peter Chen
