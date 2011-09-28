From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 28 Sep 2011 20:11:51 +0300
Subject: [PATCH v4 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <201109281516.42513.arnd@arndb.de>
References: <1317171902-14736-1-git-send-email-pdeschrijver@nvidia.com>
	<1317171902-14736-4-git-send-email-pdeschrijver@nvidia.com>
	<201109281516.42513.arnd@arndb.de>
Message-ID: <20110928171151.GN21166@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 03:16:42PM +0200, Arnd Bergmann wrote:
> On Wednesday 28 September 2011, Peter De Schrijver wrote:
> > --- a/arch/arm/mach-tegra/board-dt.c
> > +++ b/arch/arm/mach-tegra/board-dt.c
> > @@ -47,7 +47,7 @@
> >  
> >  void harmony_pinmux_init(void);
> >  void seaboard_pinmux_init(void);
> > -
> > +void ventana_pinmux_init(void);
> >  
> >  struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
> >         OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
> > @@ -95,6 +95,8 @@ static void __init tegra_dt_init(void)
> >                 harmony_pinmux_init();
> >         else if (of_machine_is_compatible("nvidia,seaboard"))
> >                 seaboard_pinmux_init();
> > +       else if (of_machine_is_compatible("nvidia,ventana"))
> > +               ventana_pinmux_init();
> 
> Are you (Peter, Colin, Olof) confident that this is not getting out
> of hand before it's getting better?
> 

We don't planning to add more derived boards besides ventana until we have the
devicetree bindings for the new pinmux API in at which point this code
will become obsolete.

Cheers,

Peter.
