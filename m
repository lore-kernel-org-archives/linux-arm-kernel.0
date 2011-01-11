From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 11 Jan 2011 18:27:11 +0800
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110111101636.GF26617@pengutronix.de>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
	<20110111101636.GF26617@pengutronix.de>
Message-ID: <201101111827.12291.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
 
> The i.MX clk implementation disables the old parent if clk is enabled
> and enables the new parent if clk is enabled (modulo bugs). Shouldn't
> we do this here aswell?

Sounds reasonable, yes.

> I thought about returning -EBUSY if clk_set_parent is called for an
> enabled clk, but this way we could never reparent the cpu clock which I
> think is done in the Freescale BSP for power saving.

I think that the possibility for changing the parent really depends on the 
implementation; in some cases we may want to disallow it, in others it might 
be fine.

Related: do we really need globally-accessible clk_{get,set}_parent in the clk 
API? For cases where we need to set the parent, we probably need details about 
the platform clock configuration (eg, which clocks are possible parents). In 
this case, we could just call into the clock driver directly.

Cheers,


Jeremy
