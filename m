From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Nov 2009 10:56:13 +0100
Subject: [PATCH 17/25] imx/eukrea_cpuimx27: use new nand device
	registration
In-Reply-To: <20091116223237.GG3568@n2100.arm.linux.org.uk>
References: <1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091116223237.GG3568@n2100.arm.linux.org.uk>
Message-ID: <20091117095613.GB7407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 16, 2009 at 10:32:37PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2009 at 09:35:00PM +0100, Uwe Kleine-K?nig wrote:
> >  static void __init eukrea_cpuimx27_init(void)
> >  {
> > +	struct mxc_nand_platform_data mxc_nand_pdata = {
> > +		.width = 1,
> > +		.hw_ecc = 1,
> > +	};
> > +
> 
> Have you checked what code the compiler spits out for this?
> 
> What the compiler will do is create a copy of the structure data in the
> read-only data section.  It will allocate space on the stack, and memcpy
> from that read-only version to the stack version.  It will then use the
> stacked version for mxc_nand_data.
> 
> This saves nothing - the data remains in-core.
> 
> What you want to do is to keep the original definition, and mark it with
> __initdata so that it gets discarded.
OK, will fix that later today.

Best regards and thanks
Uwe 

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
