From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 14 Aug 2013 11:53:39 +0800
Subject: [PATCH 1/2] arm: mach-imx: Move anatop related from board file
 to anatop driver
In-Reply-To: <20130814034632.GC16915@S2101-09.ap.freescale.net>
References: <1376292414-22922-1-git-send-email-peter.chen@freescale.com>
 <20130814034632.GC16915@S2101-09.ap.freescale.net>
Message-ID: <20130814035338.GB30404@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 11:46:34AM +0800, Shawn Guo wrote:
> I change the subject prefix to "ARM: imx: ".
> 
> On Mon, Aug 12, 2013 at 03:26:53PM +0800, Peter Chen wrote:
> > Move anatop related (For USB) from board file to anatop driver
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  arch/arm/mach-imx/anatop.c     |    4 +++-
> >  arch/arm/mach-imx/common.h     |    1 -
> >  arch/arm/mach-imx/mach-imx6q.c |    5 -----
> >  3 files changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> > index f7efabe..71f1a08 100644
> > --- a/arch/arm/mach-imx/anatop.c
> > +++ b/arch/arm/mach-imx/anatop.c
> > @@ -115,7 +115,7 @@ void imx_anatop_post_resume(void)
> >  	imx_anatop_enable_weak2p5(false);
> >  }
> >  
> > -void imx_anatop_usb_chrg_detect_disable(void)
> > +static void imx_anatop_usb_chrg_detect_disable(void)
> >  {
> >  	regmap_write(anatop, ANADIG_USB1_CHRG_DETECT,
> >  		BM_ANADIG_USB_CHRG_DETECT_EN_B
> > @@ -157,4 +157,6 @@ void __init imx_anatop_init(void)
> >  	 */
> >  	imx_anatop_pu_enable(true);
> >  	imx_gpc_xpu_enable();
> > +
> > +	imx_anatop_usb_chrg_detect_disable();
> 
> The patch was generated from vendor tree.  I fixed it up and applied the
> patch.  Please do not do this next time.
> 

I see. Thanks.

-- 

Best Regards,
Peter Chen
