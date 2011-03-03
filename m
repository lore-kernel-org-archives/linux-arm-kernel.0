From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Mar 2011 13:46:58 +0100
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <20110303115242.GA25891@n2100.arm.linux.org.uk>
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20110302215238.GK22310@pengutronix.de>
	<20110303115242.GA25891@n2100.arm.linux.org.uk>
Message-ID: <20110303124658.GR22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 11:52:42AM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 02, 2011 at 10:52:38PM +0100, Uwe Kleine-K?nig wrote:
> > > +static int __init mx5_pm_init(void)
> > > +{
> > > +	if (cpu_is_mx51())
> > > +		suspend_set_ops(&mx5_suspend_ops);
> > I'd prefer to have that called by imx51_init_early.
> 
> This function name looks fine.  As we now have an init_early in the
> arch hooks, let's keep things called foo_init_early() to that use
> and not start using 'early' for stuff used from initcalls.
> 
> Renaming this is a recipe for causing confusion and having grep hit
> false positives.  Please leave it as is.
It seems you and Thomas both didn't notice the "by" in my sentence.
Or maybe it's not proper English? The thing I wanted to express is that
instead of introducing another initcall I prefer that imx51_init_early
calls mx5_pm_init instead. The name mx5_pm_init is fine for me, though
imx51_pm_init would still be better.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
