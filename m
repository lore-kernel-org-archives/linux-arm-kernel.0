From: henryc.chen@mediatek.com (Henry Chen)
Date: Thu, 28 Jan 2016 15:16:41 +0800
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <20160127144105.GQ6042@sirena.org.uk>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
Message-ID: <1453965401.19407.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2016-01-27 at 14:41 +0000, Mark Brown wrote:
> On Wed, Jan 27, 2016 at 01:00:59PM +0100, John Crispin wrote:
> 
> > +		/* Constrain board-specific capabilities according to what
> > +		 * this driver and the chip itself can actually do.
> > +		 */
> > +		c = rdev->constraints;
> > +		c->valid_modes_mask |= REGULATOR_MODE_NORMAL |
> > +				       REGULATOR_MODE_STANDBY;
> > +		c->valid_ops_mask |= REGULATOR_CHANGE_MODE;
> 
> No, drivers should *never* enable things that weren't explictly enabled
> by the machine constraints.  This misses the whole point of having
> constraints.  They are there so that the system integrator can enable
> the functionality that is safe on a given board.  

Okay..the constrains should be define on device tree.
But which optional properties was suitable to fill on device tree if consumers want to call
regulator_set_mode directly ?
I have check the of_regulator.c and not found the suitable property name which can set valid_modes_mask & valid_ops_mask.

Thanks,
Henry 
> 
> The comment is also inaccurate, it claims it's imposing constraints but
> in fact it's adding additional permissions.
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
