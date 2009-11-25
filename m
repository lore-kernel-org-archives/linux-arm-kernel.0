From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 13:36:01 +0000
Subject: [PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
In-Reply-To: <20091125130435.GD14091@buzzloop.caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-14-git-send-email-daniel@caiaq.de>
	<20091125114946.GB3175@sirena.org.uk>
	<20091125130435.GD14091@buzzloop.caiaq.de>
Message-ID: <20091125133601.GC14045@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 02:04:35PM +0100, Daniel Mack wrote:
> On Wed, Nov 25, 2009 at 11:49:47AM +0000, Mark Brown wrote:

> > Either use regulator_get_exclusive() (at which point you own the
> > regulator) or keep track of the on/off switch yourself.

> The issue I was facing here was that the mmc power enable callback was
> called more than once with the same value for 'on', so the calls were
> not balanced and the regulator driver bailed.

If you use regulator_get_exclusive() then your usage is OK since other
users can't collide with your usage, otherwise you'd need to remember
the state in your driver if the caller isn't giving you balanced
enable/disable calls.
