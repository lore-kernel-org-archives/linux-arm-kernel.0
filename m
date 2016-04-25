From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 25 Apr 2016 06:59:14 -0400
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <20160425095715.GA2366@piout.net>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
Message-ID: <1461581954.24648.16.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, 2016-04-25 at 11:57 +0200, Alexandre Belloni wrote:
> Hi,
> 
> this requires a commit message.
> 
> Also, you should think about separating those changes in multiple patches
> to ease inclusion in the kernel.
> 
> On 25/04/2016 at 10:47:57 +0100, Eric Engestrom wrote :
> > Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
> > ---
> >  arch/arm/mach-at91/pm.c                 | 2 +-
> >  arch/arm/mach-bcm/bcm_kona_smc.c        | 2 +-
> >  arch/arm/mach-clps711x/board-autcpu12.c | 2 +-
> >  arch/arm/mach-cns3xxx/core.c            | 2 +-
> >  arch/arm/mach-davinci/da8xx-dt.c        | 2 +-
> >  arch/arm/mach-lpc32xx/phy3250.c         | 2 +-
> >  arch/arm/mach-mxs/mach-mxs.c            | 2 +-
> >  arch/arm/mach-omap2/prm_common.c        | 2 +-
> >  arch/arm/mach-omap2/vc.c                | 2 +-
> >  arch/arm/mach-spear/time.c              | 2 +-
> >  10 files changed, 10 insertions(+), 10 deletions(-)
> > 
...

> > diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> > index b2f9e22..1ae7230 100644
> > --- a/arch/arm/mach-lpc32xx/phy3250.c
> > +++ b/arch/arm/mach-lpc32xx/phy3250.c
> > @@ -159,7 +159,7 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
> >  	.dma_filter = pl08x_filter_id,
> >  };
> >  
> > -static const struct of_dev_auxdata const lpc32xx_auxdata_lookup[] __initconst = {
> > +static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
> >  	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
> >  	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
> >  	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),

A patch was already submitted for the LPC32xx:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/493312/

...
> > -- 
> > 2.7.4
> > 
> 
Sylvain
