From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 12:22:40 +0100
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <201101111827.12291.jeremy.kerr@canonical.com>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
	<20110111101636.GF26617@pengutronix.de>
	<201101111827.12291.jeremy.kerr@canonical.com>
Message-ID: <20110111112240.GQ12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:27:11PM +0800, Jeremy Kerr wrote:
> Hi Sascha,
>  
> > The i.MX clk implementation disables the old parent if clk is enabled
> > and enables the new parent if clk is enabled (modulo bugs). Shouldn't
> > we do this here aswell?
> 
> Sounds reasonable, yes.
> 
> > I thought about returning -EBUSY if clk_set_parent is called for an
> > enabled clk, but this way we could never reparent the cpu clock which I
> > think is done in the Freescale BSP for power saving.
> 
> I think that the possibility for changing the parent really depends on the 
> implementation; in some cases we may want to disallow it, in others it might 
> be fine.
> 
> Related: do we really need globally-accessible clk_{get,set}_parent in the clk 
> API? For cases where we need to set the parent, we probably need details about 
> the platform clock configuration (eg, which clocks are possible parents). In 
> this case, we could just call into the clock driver directly.

I agree that drivers have no business calling clk_{get,set}_parent, this
is purely platform specific.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
