From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 10:47:09 +0800
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
Message-ID: <20120822024707.GP24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 12:22:56PM -0500, Matt Sealey wrote:
> It's not bloat just because it is by its very definition "a big list", is it?
> 
Grep for_each_node_by_*() and for_each_*_node() (include/linux/of.h)
in the tree to see how often these global device tree searching is
used, you may know how important not having so many nodes is.

> How do you explain duplicating the clock names in the array AND in the
> device node as NOT being bloated?
> 
> You're going to have to define these clocks as a tree with parents and
> leaf nodes anyway in the clock subsystem. Why not define these in the
> device tree in total and reference them by handle when you build the
> entire clock tree from the ground up? Or will it just be all the
> clocks defined in Linux, but the lookups (which is what I see here)
> moved into the DT? Why not form the lookups as part of the definition
> of the clock tree?
> 
This is something I had tried long time before, but it did not get
accepted because:

* It's unnecessary to encode the entire clock tree which is SoC
  specific in device tree.  Clock driver is a good place for that.

* Again, doing so will bloat device tree with hundreds of nodes.

-- 
Regards,
Shawn
