From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Thu, 31 May 2018 10:22:48 +0200
Subject: [PATCH v2 1/2] ARM: debug: Add Iproc UART3 debug addresses
In-Reply-To: <93c2d07a-9344-ed39-261e-11084067a3fa@broadcom.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
 <93c2d07a-9344-ed39-261e-11084067a3fa@broadcom.com>
Message-ID: <CAJiuCcek9KU6QWsAAxVCLUaf1v97uR6FcLOfY=A1LGCMTmjHjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rai,

On Wed, 30 May 2018 at 19:25, Ray Jui <ray.jui@broadcom.com> wrote:
>
> Hi Cl?ment,
>
> Correct me if I'm wrong, but I thought the trend is to move to use
> earlycon that can be activated from kernel command line for early print
> before the serial driver is loaded.
>
> Have you tried earlcon?
No, only tested this method.

Thanks,
Clement

>
> Thanks,
>
> Ray
>
> On 5/30/2018 6:19 AM, Cl?ment P?ron wrote:
> > From: Cl?ment Peron <clement.peron@devialet.com>
> >
> > Broadcom Iproc SoCs typically use the UART3 for
> > debug/console, provide a known good location for that.
> >
> > Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> > ---
> >
> >   arch/arm/Kconfig.debug | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 199ebc1c4538..4ea9d5793b91 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -207,6 +207,14 @@ choice
> >               depends on ARCH_BCM_HR2
> >               select DEBUG_UART_8250
> >
> > +     config DEBUG_BCM_IPROC_UART3
> > +             bool "Kernel low-level debugging on BCM IPROC UART3"
> > +             depends on ARCH_BCM_CYGNUS
> > +             select DEBUG_UART_8250
> > +             help
> > +               Say Y here if you want the debug print routines to direct
> > +               their output to the third serial port on these devices.
> > +
> >       config DEBUG_BCM_KONA_UART
> >               bool "Kernel low-level debugging messages via BCM KONA UART"
> >               depends on ARCH_BCM_MOBILE
> > @@ -1557,6 +1565,7 @@ config DEBUG_UART_PHYS
> >       default 0x18000400 if DEBUG_BCM_HR2
> >       default 0x18010000 if DEBUG_SIRFATLAS7_UART0
> >       default 0x18020000 if DEBUG_SIRFATLAS7_UART1
> > +     default 0x18023000 if DEBUG_BCM_IPROC_UART3
> >       default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
> >       default 0x20001000 if DEBUG_HIP01_UART
> >       default 0x20060000 if DEBUG_RK29_UART0
> > @@ -1676,6 +1685,7 @@ config DEBUG_UART_VIRT
> >       default 0xf1002000 if DEBUG_MT8127_UART0
> >       default 0xf1006000 if DEBUG_MT6589_UART0
> >       default 0xf1009000 if DEBUG_MT8135_UART3
> > +     default 0xf1023000 if DEBUG_BCM_IPROC_UART3
> >       default 0xf11f1000 if DEBUG_VERSATILE
> >       default 0xf1600000 if DEBUG_INTEGRATOR
> >       default 0xf1c28000 if DEBUG_SUNXI_UART0
> > @@ -1791,7 +1801,7 @@ config DEBUG_UART_8250_WORD
> >               DEBUG_KEYSTONE_UART0 || DEBUG_KEYSTONE_UART1 || \
> >               DEBUG_ALPINE_UART0 || \
> >               DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
> > -             DEBUG_DAVINCI_DA8XX_UART2 || \
> > +             DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_BCM_IPROC_UART3 || \
> >               DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2
> >
> >   config DEBUG_UART_8250_PALMCHIP
> >
