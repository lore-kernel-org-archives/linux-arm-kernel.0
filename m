From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Apr 2014 11:31:53 -0700
Subject: [PATCH 5/5] ARM: sunxi: Remove sun4i and sun7i machine definitions
In-Reply-To: <CAOesGMhgTJugKyfa3QB=Zk1O0bDX9EgBnr4i9KeCD5bBpZ9mVw@mail.gmail.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-6-git-send-email-maxime.ripard@free-electrons.com>
 <1401022774.yKcHJAmPtb@wuerfel>
 <CAOesGMhgTJugKyfa3QB=Zk1O0bDX9EgBnr4i9KeCD5bBpZ9mVw@mail.gmail.com>
Message-ID: <20140430183153.GG3000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 28, 2014 at 06:08:53PM -0700, Olof Johansson wrote:
> On Wed, Apr 23, 2014 at 9:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 23 April 2014 17:04:36 Maxime Ripard wrote:
> >>
> >> -static void __init sunxi_dt_init(void)
> >> -{
> >> -       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >> -}
> >> -
> >> -static const char * const sunxi_board_dt_compat[] = {
> >> -       "allwinner,sun4i-a10",
> >> -       "allwinner,sun5i-a10s",
> >> -       "allwinner,sun5i-a13",
> >> -       NULL,
> >> -};
> >> -
> >> -DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
> >> -       .init_machine   = sunxi_dt_init,
> >> -       .dt_compat      = sunxi_board_dt_compat,
> >> -MACHINE_END
> >> -
> >>  static const char * const sun6i_board_dt_compat[] = {
> >>         "allwinner,sun6i-a31",
> >>         NULL,
> >
> > I'd like to hear more opinions on this. We could either rely
> > on the generic code, or we could keep the entry with just
> > the .dt_compat line and the name, so /proc/cpuinfo contains
> > a meaningful platform name.
> >
> > Either approach works for me, but I think we should do this
> > consistent across platforms. Olof, do you have an opinion?
> 
> In reality, today, most platforms still need some out-of-tree stuff
> that usually goes into the mach directory on out of tree kernels. It
> also gives a place to stick the Kconfig entries, it's been nice to
> have them split out in per-platform Kconfigs instead of having them
> all modify and conflict the shared one.
> 
> I know those aren't strong arguments to keep it, but given that all
> other things are more or less equal, it's a good a reason as any.

I guess the /proc/cpuinfo thing just tip the scales to keeping the
minimal machines. I'll update the patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/702c4a24/attachment-0001.sig>
