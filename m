From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 11:25:57 +0100
Subject: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
In-Reply-To: <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net>
 <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
 <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
Message-ID: <20180226102557.7bgjs3txp7cbridn@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 05:43:01PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 26, 2018 at 5:38 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
> >> Some NM PLLs doesn't work well when their output clock rate is set below
> >> certain rate.
> >>
> >> Add support for that constrain.
> >
> > In such a case, you should round the rate to the minimum the clock can
> > operate at, and not return an error.
> 
> That's true for round_rate. But what's the expected behavior of set_rate?
> AFAIK we presume all users call round_rate before set_rate, but that doesn't
> seem to be true all the time.

One of the first things that happens during a set_rate is a round_rate:
https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/clk/clk.c#L1873

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/542a49ab/attachment.sig>
