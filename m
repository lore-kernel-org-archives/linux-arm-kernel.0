From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Jan 2017 18:34:47 +0100
Subject: [PATCH v3 5/7] clk: sunxi-ng: Add sun5i CCU driver
In-Reply-To: <CAGb2v65uzxu7P3AcnhJJ_rEvT5OL8=d9-jVjU5sWNNqJpkpSRw@mail.gmail.com>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
 <a51d856e896b7fe59a1a544a7de3081688e377ff.1484897383.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65uzxu7P3AcnhJJ_rEvT5OL8=d9-jVjU5sWNNqJpkpSRw@mail.gmail.com>
Message-ID: <20170121173447.hjtddypjxr6achyt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 21, 2017 at 09:34:15AM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 20, 2017 at 3:29 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The Allwinner A10s, A13, R8 and NextThing GR8 are all based on the same
> > silicon, and all share the same clocks.
> >
> > However, they're not packaged in the same way, and therefore not all the
> > controllers are actually available on all these SoCs.
> >
> > Introduce a clock controller driver for all these SoCs with different
> > compatibles to take that into account.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!

> > ---
> >  drivers/clk/sunxi-ng/Kconfig          |   10 +-
> >  drivers/clk/sunxi-ng/Makefile         |    1 +-
> >  drivers/clk/sunxi-ng/ccu-sun5i.c      | 1008 ++++++++++++++++++++++++++-
> >  drivers/clk/sunxi-ng/ccu-sun5i.h      |   67 ++-
> >  include/dt-bindings/clock/sun5i-ccu.h |  103 +++-
> >  include/dt-bindings/reset/sun5i-ccu.h |   32 +-
> 
> I thought having these 2 in a separate patch would be better for
> cross tree merges?

Not really. This was needed when we had several drivers using it, but
since we merged all of them, it's not really needed anymore. Having it
split wouldn't make it easier, because both the DT bits and the
drivers bits would depend on it.

We don't have much for the sun5i stuff queued for 4.11, so we can just
have the DT bits merged through the clk tree.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170121/e790e8d0/attachment.sig>
