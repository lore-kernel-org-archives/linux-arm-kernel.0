From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 14:20:25 +0200
Subject: [PATCH 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <CAGb2v65hHJDS6-Sz5Hi4a_F_cHTdBkFUzRR3a0JSE43AbDYmcw@mail.gmail.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65hHJDS6-Sz5Hi4a_F_cHTdBkFUzRR3a0JSE43AbDYmcw@mail.gmail.com>
Message-ID: <20150918122025.GR4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 05:47:44PM +0800, Chen-Yu Tsai wrote:
> On Fri, Sep 18, 2015 at 4:48 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The R8 is a new Allwinner SoC based on the A13. While both are very
> > similar, there's still a few differences. Introduce a new compatible to
> > deal with them.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-sunxi/sunxi.c   | 3 ++-
> >  drivers/clk/sunxi/clk-sunxi.c | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > index 65bab2876343..8583a9ca86bd 100644
> > --- a/arch/arm/mach-sunxi/sunxi.c
> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > @@ -26,10 +26,11 @@ static const char * const sunxi_board_dt_compat[] = {
> >         "allwinner,sun4i-a10",
> >         "allwinner,sun5i-a10s",
> >         "allwinner,sun5i-a13",
> > +       "allwinner,sun5i-r8",
> >         NULL,
> >  };
> >
> > -DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
> > +DT_MACHINE_START(SUNXI_DT, "Allwinner sun4i/sun5i Families")
> 
> Nit: might want to mention the rename.

Indeed, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/b919225f/attachment.sig>
