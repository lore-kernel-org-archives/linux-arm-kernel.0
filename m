From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Sep 2014 15:16:40 +0200
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20140920121242.GA3833@katana>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
Message-ID: <20140922131640.GU3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 02:12:43PM +0200, Wolfram Sang wrote:
> Hi,
> 
> thanks for the submission.
> 
> On Mon, Aug 25, 2014 at 01:51:22PM +0200, Anders Berg wrote:
> > Add I2C bus driver for the controller found in the LSI Axxia family SoCs. The
> > driver implements 10-bit addressing and SMBus transfer modes via emulation
> > (including SMBus block data read).
> > 
> > Signed-off-by: Anders Berg <anders.berg@avagotech.com>
> 
> Looks pretty good already. Still, some comments:
> 
> > +config I2C_AXXIA
> > +	tristate "Axxia I2C controller"
> > +	depends on ARCH_AXXIA
> > +	help
> > +	  Say yes if you want to support the I2C bus on Axxia platforms.
> > +
> > +	  If you don't know, say Y.
> 
> I'd say skip this sentence and consider 'default y' if it is really
> needed on this platform.
Still better:

	depends on ARCH_AXXIA || COMPILE_TEST
	default ARCH_AXXIA

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
