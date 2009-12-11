From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Dec 2009 14:09:16 +0100
Subject: [PATCH 3/4] MXC: mc13783: Developing, trying to full support
	regulators.
In-Reply-To: <1260471013.2141.49.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
Message-ID: <20091211130916.GA16473@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 10, 2009 at 07:50:13PM +0100, Alberto Panizzo wrote:
> This patch add the ability to change voltages settings
> for all possible mc13783 regulators.
> Pay attention that it is a development patch with many 
> debug messages enabled.

Can you please develop on top of my rewrite of
drivers/mfd/mc13783-core.c that currently sits in 

	git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6.git for-next

and waits to hit Linus' tree.
The same applies to drivers/regulator/mc13783.c (though my update sits
in 

	git://git.kernel.org/pub/scm/linux/kernel/git/lrg/voltage-2.6.git for-next

And note that I plan to get rid of include/linux/mfd/mc13783-private.h.

> +	printk(KERN_DEBUG "%s frame: 0x%x\n", __func__, frame);
> +
if you define DEBUG, you can use pr_debug or better dev_dbg.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
