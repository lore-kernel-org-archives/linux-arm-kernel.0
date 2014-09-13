From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 13 Sep 2014 12:26:03 +0200
Subject: [PATCH 3/7] clk: sunxi: unify sun6i AHB1 clock with proper PLL6
 pre-divider
In-Reply-To: <CAGb2v66L36nsoucSgLY8pV8f=wjKTvtjJby43Z=Ct+NiRonptQ@mail.gmail.com>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-4-git-send-email-wens@csie.org>
 <20140911210211.GM31276@lukather>
 <CAGb2v66L36nsoucSgLY8pV8f=wjKTvtjJby43Z=Ct+NiRonptQ@mail.gmail.com>
Message-ID: <20140913102603.GZ31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 11:16:26AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Sep 12, 2014 at 5:02 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sat, Sep 06, 2014 at 06:47:24PM +0800, Chen-Yu Tsai wrote:
> >> This patch unifies the sun6i AHB1 clock, originally supported
> >> with separate mux and divider clks. It also adds support for
> >> the pre-divider on the PLL6 input, thus allowing the clock to
> >> be muxed to PLL6 with proper clock rate calculation.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > It looks fine, but I'd rather see this in a separate file, especially
> > since we don't seem to have any order dependency.
> 
> Sorry, just to be clear, separate file under clk/sunxi?

Yes

> This cannot be in a separate file, as it shares a spinlock with apb1
> divider. They share the same register.
> 
> We could move apb1 out though. But i would prefer to do that when
> we split out all the clocks into individual OF_CLK_DECLAREs.

Ah right, my bad :)

My plan on the long term is to kill clk-sunxi as a place where all the
clocks are defined, and only leave the "policy" there, for example the
clock protection code (even if that should probably be removed too,
together with clkdev), the various rates / parenting enforcements,
etc.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/364cc588/attachment.sig>
