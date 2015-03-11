From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 10:53:39 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <20150310173550.GT5264@atomide.com>
 <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
Message-ID: <3439869.6umCuOq6SV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 02:00:59 Javier Martinez Canillas wrote:
> Hello Tony,
> 
> On Tue, Mar 10, 2015 at 6:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>
> >> we do have to make sure these wl18xx bindings are future-compatible
> >> with the wl12xx ones, but i think the current bindings are pretty much
> >> standard (and are actually a subset of the bindings needed by wl12xx),
> >> so it should be fine.
> >
> > Well how about add just the parsing of the clock and assume it's always
> > WL12XX_REFCLOCK_38 for now as that's the only thing we're currently
> > using. Then we can add a property or compatible value if using something
> > else as needed.
> >
> 
> What do you mean by parsing here? IIUC there isn't a clock driver for
> these clocks and are setup directly in the
> drivers/net/wireless/ti/wl12xx/main.c driver.
> 
> So you can't make the WLAN chip dev node a consumer of these clocks by
> adding a phandle to a clock provider and clock specifiers since there
> isn't a provider to be referenced in the DT. Or did I misunderstand?

As I understand it, the clock signal is provided by an external oscillator,
which we can easily model in DT, and then you call clk_get_rate on that.

If there is no external clock provider for this chip and the clocks
are provided by the device itself, then all we need is a clock-frequency
property in the device node.

	Arnd
