From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 11:41:56 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <CAJOA=zNEywZ6tbJDuLjekVQeJpr9O2X1u-sTXpp0GYWzc+OHig@mail.gmail.com>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207161554.04812.arnd@arndb.de>
 <CAJOA=zNEywZ6tbJDuLjekVQeJpr9O2X1u-sTXpp0GYWzc+OHig@mail.gmail.com>
Message-ID: <2442382.A2GKNpPZbv@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Monday 16 July 2012 13:47:01 Turquette, Mike wrote:
> On Mon, Jul 16, 2012 at 8:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
[snip]
> > board selection.
> >
> >> +struct clk {
> >> +     struct clk *parent;             /* parent clk */
> >> +     unsigned long rate;             /* clock rate in Hz */
> >> +     unsigned long divider;          /* clock divider */
> >> +     u32 usecount;                   /* reference count */
> >> +     struct clk_ops *ops;            /* clock operation */
> >> +     u32 enable_reg;                 /* clock enable register */
> >> +     u32 enable_mask;                /* clock enable mask */
> >> +};
> >
> > Platforms are now converting to the common clock framework in drivers/clk.
> > Mike Turquette as the subsystem maintainer can probably judge better 
whether
> > we should still be allowing new platforms with their own implementation
> > of clk, but my feeling is that you should use the subsystem instead
> > and add a driver in a subdirectory of drivers/clk instead of in the
> > platform.
> 
> Hi Florian & Arnd,
> 
> Adopting the new clock framework is highly preferable, especially if
> MCS814x support is being delayed until 3.7.  There is also a push to
> put clock drivers into drivers/clk and I would like to continue that
> trend, but I'm less strict on that measure if it proves very difficult
> for your platform immediately (e.g. duplicating headers across
> platform and generic code, etc).  Migrating code from arch/arm to
> drivers/clk can always be done in a future series.

Since we are now targetting 3.7, I would rather come up with proper DT clock 
bindings, which should make the mcs814x clock driver much nicer.

> 
> This platform also seems to be making use of DT so it would be very
> nice if we use MCS814x to push the state of clk DT bindings and
> adoption forward a bit.  There are not a lot of folks using the
> patches from Rob/Grant today.  Hopefully delaying these patches by
> another merge cycle means that these requests are not asking too much
> :-)

If we could get them merged during 3.6 that would allow me, and other ARM-soc 
maintainers to get their stuff fully migrated to DT. Are there any blockers to 
these patches?
--
Florian
