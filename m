From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Dec 2010 11:55:35 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Use chip_data to store the shift for
	EINTs
In-Reply-To: <003101cb914d$1caf7040$560e50c0$%kim@samsung.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1290698309-7691-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<003101cb914d$1caf7040$560e50c0$%kim@samsung.com>
Message-ID: <20101201115535.GK24176@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 08:44:25PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > This makes all the functions that use the shift slightly smaller, one
> > instruction in most cases but more for ack() and maskack().

> Uhm...I'm not sure to use chip_data for the eint_irq_to_bit() is best to us.

Could you elaborate on your concern here?  I can't think of anything
else we might want to include in the data, and avoiding the shifts
and/or dereferences seems useful for anyone doing interrupt heavy work.
