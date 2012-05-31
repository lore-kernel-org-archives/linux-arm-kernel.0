From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 May 2012 13:00:58 +0100
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120531120057.GA15786@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 11:31:31AM +0300, Peter De Schrijver wrote:

> > What I wonder most is if this should be done at the clock level or at
> > the device level. In the end you reset the IP block, not the clock,
> > right ?

> Yes. but, every block has at least 1 clock and thus the mapping is identical
> down to the register level. Ie. we could do this outside the clockframework,
> but then we would have the keep a list of IDs (1 per module) which the drivers
> can use to call some tegra reset function which would in the end use registers
> in the same memory area to cause a reset. (the registers controlling
> modulereset are interleaved with those controlling the enable/disable of the
> main moduleclock and bitpositions are identical)

One option which doesn't really need anything from the clock API is for
the module resets to restore these registers so the clock API never
notices anything changed.
