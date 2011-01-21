From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Jan 2011 20:32:10 +0100
Subject: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
	platforms
In-Reply-To: <4D39B042.5050004@freescale.com>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
	<20110121153351.GR14956@pengutronix.de>
	<4D39B042.5050004@freescale.com>
Message-ID: <20110121193210.GU14956@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Fri, Jan 21, 2011 at 02:11:46PM -0200, Fabio Estevam wrote:
> On 1/21/2011 1:33 PM, Uwe Kleine-K?nig wrote:
> > On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> >> Currently MMC_MXC driver can be selected by all i.MX devices.
> >>
> >> Restrict its use only for the appropriate processors.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >>  drivers/mmc/host/Kconfig |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index d618e86..a3a9ec1 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -288,7 +288,7 @@ config MMC_MSM
> >>  
> >>  config MMC_MXC
> >>  	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
> >> -	depends on ARCH_MXC
> >> +	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
> > What about
> > 
> > 	depends IMX_HAVE_PLATFORM_MXC_MMC
> 
> I would prefer to let the architectures explicitly in Kconfig.
> 
> If someone selects IMX_HAVE_PLATFORM_MXC_MMC by mistake on a MX51
> board, it will be possible to select the MXC_MMC driver in the kernel
> for MX51, which is incorrect.
it's not optimal, but nothing happens unless this someone registers a
corresponding device, too.

> Using the approach of explicitly marking the architectures that
> support MXC_MMC would avoid such problems as well.
> > 
> > ?  Then if i.MX29 has the same IP you don't need to touch this again.
> 
> Not likely to happen. 
I wouldn't bet ...

Note I don't argue, if you still prefer the explicit list it's OK for
me.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
