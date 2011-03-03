From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 11:52:42 +0000
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <20110302215238.GK22310@pengutronix.de>
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20110302215238.GK22310@pengutronix.de>
Message-ID: <20110303115242.GA25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 10:52:38PM +0100, Uwe Kleine-K?nig wrote:
> > +static int __init mx5_pm_init(void)
> > +{
> > +	if (cpu_is_mx51())
> > +		suspend_set_ops(&mx5_suspend_ops);
> I'd prefer to have that called by imx51_init_early.

This function name looks fine.  As we now have an init_early in the
arch hooks, let's keep things called foo_init_early() to that use
and not start using 'early' for stuff used from initcalls.

Renaming this is a recipe for causing confusion and having grep hit
false positives.  Please leave it as is.
