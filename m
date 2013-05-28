From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 May 2013 14:29:44 +0900
Subject: [PATCH 04/12] ARM: shmobile: r8a7740: Add DT name to clock list
 for CMT10
In-Reply-To: <20130528032948.GF13532@quad.lixom.net>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-5-git-send-email-horms+renesas@verge.net.au>
 <20130528032948.GF13532@quad.lixom.net>
Message-ID: <20130528052944.GC25005@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 08:29:48PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, May 27, 2013 at 05:59:45PM +0900, Simon Horman wrote:
> > From: Bastian Hecht <hechtb@gmail.com>
> > 
> > This adds temporarily the alternative device name to the clock list
> > that is used when booting via Device Tree setup.
> 
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> > index 5bd8da0..8fc396a 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> > @@ -582,6 +582,7 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
> >  
> >  	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
> > +	CLKDEV_DEV_ID("e6138010.timer",		&mstp_clks[MSTP329]),
> >  	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
> >  	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
> >  	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
> > -- 
> > 1.7.10.4
> > 
> 
> Usually this is instead handled by adding entries to OF_DEV_AUXDATA() to
> rename the device in the board file. Would you mind doing that instead?

Magnus has indicated in the past that he prefers this method over
using OF_DEV_AUXDATA() and the above is consistent with other
shmobile code.
