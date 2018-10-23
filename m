From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2018 09:52:09 +0100
Subject: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
In-Reply-To: <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
References: <20181009112021.756-1-peron.clem@gmail.com>
 <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
Message-ID: <20181023085208.GL30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 10:47:05AM +0200, Cl?ment P?ron wrote:
> Hi Dinh / Russell,
> 
> Could you have a look at these patchs please ?

Nothing to do with me - it's up to the socfpga maintainer and arm-soc
maintainers.

> Thanks,
> Clement
> 
> On Tue, 9 Oct 2018 at 13:20, Cl?ment P?ron <peron.clem@gmail.com> wrote:
> >
> > These functions are unused externally, removed them and declare
> > the one used locally as static.
> >
> > Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
> > ---
> >  arch/arm/mach-socfpga/core.h    | 2 --
> >  arch/arm/mach-socfpga/socfpga.c | 2 +-
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> > index 65e1817d8afe..92cae0a9213f 100644
> > --- a/arch/arm/mach-socfpga/core.h
> > +++ b/arch/arm/mach-socfpga/core.h
> > @@ -34,8 +34,6 @@
> >
> >  #define RSTMGR_MPUMODRST_CPU1          0x2     /* CPU1 Reset */
> >
> > -extern void socfpga_init_clocks(void);
> > -extern void socfpga_sysmgr_init(void);
> >  void socfpga_init_l2_ecc(void);
> >  void socfpga_init_ocram_ecc(void);
> >  void socfpga_init_arria10_l2_ecc(void);
> > diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> > index dde14f7bf2c3..5fb6f79059a8 100644
> > --- a/arch/arm/mach-socfpga/socfpga.c
> > +++ b/arch/arm/mach-socfpga/socfpga.c
> > @@ -32,7 +32,7 @@ void __iomem *rst_manager_base_addr;
> >  void __iomem *sdr_ctl_base_addr;
> >  unsigned long socfpga_cpu1start_addr;
> >
> > -void __init socfpga_sysmgr_init(void)
> > +static void __init socfpga_sysmgr_init(void)
> >  {
> >         struct device_node *np;
> >
> > --
> > 2.17.1
> >

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
