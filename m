From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 10:34:50 +0200
Subject: [PATCH 19/22] ARM: sunxi: Add earlyprintk support using R_UART
 (sun6i/sun8i)
In-Reply-To: <CAGb2v66jL5-rmSy0W38og6bLiNkGu0wekEZfOuh0Fn2oOsJpaQ@mail.gmail.com>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-20-git-send-email-wens@csie.org>
 <20140525184636.GN10768@lukather>
 <CAGb2v66jL5-rmSy0W38og6bLiNkGu0wekEZfOuh0Fn2oOsJpaQ@mail.gmail.com>
Message-ID: <20140527083450.GG4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 05:25:43PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 26, 2014 at 2:46 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Fri, May 23, 2014 at 03:51:22PM +0800, Chen-Yu Tsai wrote:
> >> sun6i/sun8i have a UART in the RTC block group, which can be used
> >> as an early console. This is most useful on sun8i as UART0 is muxed
> >> with MMC0, which is not available if we boot from MMC.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/Kconfig.debug | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> >> index eab8ecb..9e22708 100644
> >> --- a/arch/arm/Kconfig.debug
> >> +++ b/arch/arm/Kconfig.debug
> >> @@ -694,6 +694,14 @@ choice
> >>                 Say Y here if you want kernel low-level debugging support
> >>                 on Allwinner A1X based platforms on the UART1.
> >>
> >> +     config DEBUG_SUNXI_R_UART
> >> +             bool "Kernel low-level debugging messages via sunXi R_UART"
> >> +             depends on ARCH_SUNXI
> >
> > It should rather depend on MACH_SUN8I.
> 
> I assume no sun6i devices would use it, or have pads available for
> it?  If so, then MACH_SUN8I makes sense.

Then a depends on MACH_SUN6I || MACH_SUN8I.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/9c9eaf70/attachment.sig>
