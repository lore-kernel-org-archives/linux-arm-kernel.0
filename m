From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Nov 2015 17:52:25 -0800
Subject: [PATCH] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <CAGb2v651vNyUqE_LXYnuYNhN0siywtg7Pt1TDQZUMxwZ3psmJg@mail.gmail.com>
References: <1445964626-6484-2-git-send-email-jenskuske@gmail.com>
 <1446651896-22902-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v651vNyUqE_LXYnuYNhN0siywtg7Pt1TDQZUMxwZ3psmJg@mail.gmail.com>
Message-ID: <20151109015225.GX6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Thu, Nov 05, 2015 at 10:28:00AM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 4, 2015 at 11:44 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Remove the fixed dividers from the PLL6 driver to be able to have a
> > reusable driver that can be used across several SoCs that share the same
> > controller, but don't have the same set of dividers for this clock, and to
> > also be reused multiple times in the same SoC, since we're droping the
> > clock name.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > Hi Jens,
> >
> > Here is an alternative (untested) patch to deal with the PLL6 issue you're
> > experiencing with the H3.
> >
> > It doesn't rely on parsing clock-output-names that turns out to be pretty
> > fragile.
> 
> A quick look through. I've no problems with changing the design, but I'd
> like to keep the original names, i.e. pll6x2 for the clock module bits,
> and pll6 for the fixed divider. It better matches the user manual.
> 
> From the PLL6 register description:
> In the Clock Control Module, PLL(2X) output = PLL * 2= 24 MHz * N * K.
> 
> And all places that use the "normal" output say PLL_PERIPH (that is PLL6),
> while MBUS on A23/A33 use the 2X output, and say PLL_PERIPH(2X).

Ack, I'll change this.

> On the side, do we want to get rid of all the divs clocks?

Eventually, yes. A10's PLL6 is pretty much in the same situation.

PLL5 is a different story though, since it has an extra adjustable
divider. It would probably deserve its own driver.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/d9730557/attachment.sig>
