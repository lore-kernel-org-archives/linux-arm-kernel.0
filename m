From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Oct 2014 22:11:38 +0200
Subject: [PATCH v2 1/7] ARM: sunxi: Introduce Allwinner A80 support
In-Reply-To: <CAGb2v66wMm-wZLmwzf==XSDUy9Z0EbjC_NN9EZvf9DFV8PbwrA@mail.gmail.com>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-2-git-send-email-wens@csie.org>
 <20140925132527.GF15315@lukather>
 <CAGb2v64LwgEZkiuej2KKi+CUU3OkUZaBKJ3ZZn_Y64tDD+LRwg@mail.gmail.com>
 <20141001093314.GI6884@lukather>
 <CAGb2v66wMm-wZLmwzf==XSDUy9Z0EbjC_NN9EZvf9DFV8PbwrA@mail.gmail.com>
Message-ID: <20141007201138.GF17925@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 02:23:03PM +0800, Chen-Yu Tsai wrote:
> On Wed, Oct 1, 2014 at 5:33 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Sep 27, 2014 at 09:16:02PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Sep 25, 2014 at 9:25 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Wed, Sep 24, 2014 at 10:48:55PM +0800, Chen-Yu Tsai wrote:
> >> >> The Allwinner A80 is a new Cortex octo-core A7/A15 big.LITTLE SoC.
> >> >> While it's processor cores and interconnecting bus are new, it
> >> >> re-uses many peripherals found in earlier Allwinner SoCs.
> >> >>
> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> ---
> >> >>  arch/arm/mach-sunxi/Kconfig | 5 +++++
> >> >>  arch/arm/mach-sunxi/sunxi.c | 9 +++++++++
> >> >>  2 files changed, 14 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> >> >> index 1aaa1e1..72f222b 100644
> >> >> --- a/arch/arm/mach-sunxi/Kconfig
> >> >> +++ b/arch/arm/mach-sunxi/Kconfig
> >> >> @@ -42,4 +42,9 @@ config MACH_SUN8I
> >> >>       select MFD_SUN6I_PRCM
> >> >>       select RESET_CONTROLLER
> >> >>
> >> >> +config MACH_SUN9I
> >> >> +     bool "Allwinner A80 (sun9i) SoCs support"
> >> >
> >> > With the new naming scheme, I wonder wether it makes sense to have the
> >> > A80 displayed here and in the machine definition.
> >>
> >> I expect anything that falls under sun9i to be compatible, or a trimmed
> >> down version. But that's just me.
> >
> > Well, compatible is a rather vague notion. They will be different for
> > sure. Maybe not that different, but still.
> 
> So what you're saying is we have a MACH_* Kconfig symbol for each SoC.
> As we add or test drivers, we mark them as compatible by adding that
> symbol to the DEPENDS part?
> 
> I can live with that.

No, what I'm saying is drop the A80 mention from the bool label, and
only leave the family there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/87e050d0/attachment.sig>
