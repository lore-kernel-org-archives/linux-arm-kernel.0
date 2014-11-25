From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Nov 2014 23:06:39 +0100
Subject: [PATCH v4 0/6] clk: sun6i: Unify AHB1 clock and fix rate
 calculation
In-Reply-To: <CAGb2v660qfQEikxWnZA8EFRK+RBuK6yED+3aaLOVOEjByFhPpA@mail.gmail.com>
References: <1416717205-15406-1-git-send-email-wens@csie.org>
 <20141125152202.GA3949@lukather>
 <CAGb2v660qfQEikxWnZA8EFRK+RBuK6yED+3aaLOVOEjByFhPpA@mail.gmail.com>
Message-ID: <20141125220639.GH25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 11:38:36PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 25, 2014 at 11:22 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sun, Nov 23, 2014 at 12:33:19PM +0800, Chen-Yu Tsai wrote:
> >> Hi everyone,
> >>
> >> This is v4 of the sun6i AHB1 clock unification series. This series
> >> unifies the mux and divider parts of the AHB1 clock found on sun6i
> >> and sun8i, while also adding support for the pre-divider on the
> >> PLL6 input.
> >>
> >> The rate calculation logic must factor in which parent it is using to
> >> calculate the rate, to decide whether to use the pre-divider or not.
> >> This is beyond the original factors clk design in sunxi. To avoid
> >> feature bloat, this is implemented as a seperate composite clk.
> >>
> >> The new clock driver is registered with a separate OF_CLK_DECLARE.
> >> As it shares its register with the APB1 div clock, thus shares the same
> >> spinlock, it cannot reside in a separate file.
> >>
> >> This series also fixes up the PLL6 clock. Those patches were merged
> >> and are included for completeness.
> >
> > Please don't do that. Now, I have no idea what should be merged, and
> > what not.
> 
> The first 3 have been merged:
> 
>   clk: sunxi: Specify number of child clocks for divs clocks
>   clk: sunxi: Implement A31 PLL6 as a divs clock for 2x output
>   ARM: sun6i: DT: Add PLL6 multiple outputs
> 
> The latter 3 have not:
> 
>   clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
>   ARM: dts: sun6i: Unify ahb1 clock nodes
>   ARM: dts: sun8i: Unify ahb1 clock nodes
> 
> The dts patches should probably be taken through the clock tree,
> to avoid breaking arm-soc again? But they do depend on the third
> patch, which you've included in the arm-soc pull request.

Ok, thanks for the clarification.

This will be aimed at 3.20 anyway, so it can go through both the clock
or the arm-soc trees, and yeah, I'd lean toward the first given this
pull request experience.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/4d550bf0/attachment.sig>
