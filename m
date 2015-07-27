From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jul 2015 17:42:08 -0400 (EDT)
Subject: [PATCH v2] ARM: appropriate __init annotation for const data
In-Reply-To: <CAOMZO5DAMNh=Wfr=BzxMsRGiHofUBVUemUD2sfO3MEx7LkJRAQ@mail.gmail.com>
References: <alpine.LFD.2.20.1507271659350.1806@knanqh.ubzr>
 <CAOMZO5DAMNh=Wfr=BzxMsRGiHofUBVUemUD2sfO3MEx7LkJRAQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1507271740030.1806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jul 2015, Fabio Estevam wrote:

> On Mon, Jul 27, 2015 at 6:15 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> > Init data marked const should be annotated with __initconst for
> 
> > diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> > index 2e7cec86e5..1063af930d 100644
> > --- a/arch/arm/mach-mxs/mach-mxs.c
> > +++ b/arch/arm/mach-mxs/mach-mxs.c
> > @@ -282,7 +282,7 @@ static void __init apx4devkit_init(void)
> >  #define TX28_FEC_PHY_RESET     MXS_GPIO_NR(4, 13)
> >  #define TX28_FEC_nINT          MXS_GPIO_NR(4, 5)
> >
> > -static const struct gpio tx28_gpios[] __initconst = {
> > +static const struct gpio const tx28_gpios[] __initconst = {
> >         { ENET0_MDC__GPIO_4_0, GPIOF_OUT_INIT_LOW, "GPIO_4_0" },
> >         { ENET0_MDIO__GPIO_4_1, GPIOF_OUT_INIT_LOW, "GPIO_4_1" },
> >         { ENET0_RX_EN__GPIO_4_2, GPIOF_OUT_INIT_LOW, "GPIO_4_2" },
> > @@ -528,7 +528,7 @@ static void mxs_restart(enum reboot_mode mode, const char *cmd)
> >         soft_restart(0);
> >  }
> >
> > -static const char *mxs_dt_compat[] __initdata = {
> > +static const char *mxs_dt_compat[] __initconst = {

                        ^
A "const" is still missing here.
Argh...


Nicolas
