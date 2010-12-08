From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Dec 2010 00:36:01 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Use chip_data to store the shift for
	EINTs
In-Reply-To: <20101201115535.GK24176@rakim.wolfsonmicro.main>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>	<1290698309-7691-3-git-send-email-broonie@opensource.wolfsonmicro.com>	<003101cb914d$1caf7040$560e50c0$%kim@samsung.com>
	<20101201115535.GK24176@rakim.wolfsonmicro.main>
Message-ID: <4CFED2F1.3010902@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/10 11:55, Mark Brown wrote:
> On Wed, Dec 01, 2010 at 08:44:25PM +0900, Kukjin Kim wrote:
>> Mark Brown wrote:
> 
>>> This makes all the functions that use the shift slightly smaller, one
>>> instruction in most cases but more for ack() and maskack().
> 
>> Uhm...I'm not sure to use chip_data for the eint_irq_to_bit() is best to us.
> 
> Could you elaborate on your concern here?  I can't think of anything
> else we might want to include in the data, and avoiding the shifts
> and/or dereferences seems useful for anyone doing interrupt heavy work.

Hi, post code to show difference in output would be good!
