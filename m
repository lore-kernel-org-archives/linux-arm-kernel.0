From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 Oct 2013 16:46:09 +0800
Subject: [PATCH v3 5/5] ARM: dts: imx28: changing usb compatible string
 as only "fsl,imx28-usb"
In-Reply-To: <20131025081429.GA10442@shlinux1.ap.freescale.net>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-5-git-send-email-peter.chen@freescale.com>
 <20131025082330.GA13790@S2101-09.ap.freescale.net>
 <20131025081429.GA10442@shlinux1.ap.freescale.net>
Message-ID: <20131025084607.GC13790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 04:14:30PM +0800, Peter Chen wrote:
> > > @@ -1041,7 +1041,7 @@
> > >  		ranges;
> > >  
> > >  		usb0: usb at 80080000 {
> > > -			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
> > > +			compatible = "fsl,imx28-usb";
> > 
> > You shouldn't need the change as long as you put "fsl,imx28-usb" before
> > "fsl,imx27-usb" in driver ci_hdrc_imx_dt_ids[] table.
> > 
> 
> I know it can work without this dts change, but that driver change like
> a workaround.

No, it's not a workaround.  Before of_match_device() gets improved to
match the best one, it should just work that way.

> Since the imx28-usb is not compatible with imx27-usb,
> we'd better only keep "fsl, imx28-usb" compatible string at imx28 dtsi.

>From hardware point of view, the USB block on imx28 *is* inherited from
imx27, and compatible to imx27 USB block, even though we have a little
difference to handle in software.  The compatible string is written in
this way at the first place exactly for the reason we can save such
DTS change when we have some little incompatibility to handle.

Shawn
