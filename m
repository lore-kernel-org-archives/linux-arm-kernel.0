From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 May 2012 12:43:01 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531092603.GM5377@arwen.pp.htv.fi>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <20120531092603.GM5377@arwen.pp.htv.fi>
Message-ID: <20120531094301.GT8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > on Tegra:
> > > 
> > > device_reset(dev)
> > > 	-> dev_pm_domain->reset()
> > > 		-> tegra_periph_reset()
> > > 
> > 
> > These methods are also needed internally by the powergating code.
> 
> so ? Just call them when you need...
> 

the powergating code calls assert and deassert indepedently
ie:

tegra_periph_reset_assert()

do stuff

tegra_periph_reset_assert()

> > > on OMAP:
> > > 
> > > device_reset(dev)
> > > 	-> dev_pm_domain->reset()
> > > 		-> omap_hwmod_reset()
> > > 
> > > 
> > > btw:
> > > 
> > > tegra_periph_reset(....)
> > > {
> > > 	tegra_periph_reset_assert(...);
> > > 	udelay(2);
> > > 	tegra_periph_reset_deassert(...);
> > > }
> > 
> > which uses the clockframework currently.
> 
> no problems there. The point is that you already know which clock feed
> into which device, so if you have a device-based API for device
> soft-reset, you can figure out which exact clock to toggle, right ?

you have the struct clk, you could dive into that and grab clk_hw and call
some function directly. But sounds quite horrible to me.

Cheers,

Peter.
