From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:27:34 +0000
Subject: [PATCH 28/41] ARM: restart: pxa: use new restart hook
In-Reply-To: <E1RN6qW-0001YV-U3@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6qW-0001YV-U3@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117172734.GZ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:49:28PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-pxa/balloon3.c            |    1 +
>  arch/arm/mach-pxa/capc7117.c            |    3 ++-
>  arch/arm/mach-pxa/cm-x2xx.c             |    1 +
>  arch/arm/mach-pxa/cm-x300.c             |    1 +
>  arch/arm/mach-pxa/colibri-pxa270.c      |    2 ++
>  arch/arm/mach-pxa/colibri-pxa300.c      |    1 +
>  arch/arm/mach-pxa/colibri-pxa320.c      |    1 +
>  arch/arm/mach-pxa/corgi.c               |    8 +++++---
>  arch/arm/mach-pxa/csb726.c              |    1 +
>  arch/arm/mach-pxa/em-x270.c             |    2 ++
>  arch/arm/mach-pxa/eseries.c             |    6 ++++++
>  arch/arm/mach-pxa/ezx.c                 |    6 ++++++
>  arch/arm/mach-pxa/generic.h             |    2 ++
>  arch/arm/mach-pxa/gumstix.c             |    1 +
>  arch/arm/mach-pxa/h5000.c               |    1 +
>  arch/arm/mach-pxa/himalaya.c            |    1 +
>  arch/arm/mach-pxa/hx4700.c              |    1 +
>  arch/arm/mach-pxa/icontrol.c            |    3 ++-
>  arch/arm/mach-pxa/idp.c                 |    1 +
>  arch/arm/mach-pxa/include/mach/system.h |   10 +++-------
>  arch/arm/mach-pxa/littleton.c           |    1 +
>  arch/arm/mach-pxa/lpd270.c              |    1 +
>  arch/arm/mach-pxa/lubbock.c             |    1 +
>  arch/arm/mach-pxa/magician.c            |    1 +
>  arch/arm/mach-pxa/mainstone.c           |    1 +
>  arch/arm/mach-pxa/mioa701.c             |    6 +++---
>  arch/arm/mach-pxa/mp900.c               |    1 +
>  arch/arm/mach-pxa/palmld.c              |    3 ++-
>  arch/arm/mach-pxa/palmt5.c              |    3 ++-
>  arch/arm/mach-pxa/palmtc.c              |    3 ++-
>  arch/arm/mach-pxa/palmte2.c             |    3 ++-
>  arch/arm/mach-pxa/palmtreo.c            |    2 ++
>  arch/arm/mach-pxa/palmtx.c              |    3 ++-
>  arch/arm/mach-pxa/palmz72.c             |    3 ++-
>  arch/arm/mach-pxa/pcm027.c              |    1 +
>  arch/arm/mach-pxa/poodle.c              |    3 ++-
>  arch/arm/mach-pxa/raumfeld.c            |    3 +++
>  arch/arm/mach-pxa/reset.c               |    5 ++++-
>  arch/arm/mach-pxa/saar.c                |    1 +
>  arch/arm/mach-pxa/saarb.c               |    1 +
>  arch/arm/mach-pxa/spitz.c               |    6 ++++--
>  arch/arm/mach-pxa/stargate2.c           |    2 ++
>  arch/arm/mach-pxa/tavorevb.c            |    1 +
>  arch/arm/mach-pxa/tavorevb3.c           |    1 +
>  arch/arm/mach-pxa/tosa.c                |    4 ++--
>  arch/arm/mach-pxa/trizeps4.c            |    2 ++
>  arch/arm/mach-pxa/viper.c               |    1 +
>  arch/arm/mach-pxa/vpac270.c             |    3 ++-
>  arch/arm/mach-pxa/xcep.c                |    1 +
>  arch/arm/mach-pxa/z2.c                  |    1 +
>  arch/arm/mach-pxa/zeus.c                |    1 +
>  arch/arm/mach-pxa/zylonite.c            |    1 +
>  52 files changed, 95 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> index fc0b854..5e25e17 100644
> --- a/arch/arm/mach-pxa/balloon3.c
> +++ b/arch/arm/mach-pxa/balloon3.c
> @@ -829,4 +829,5 @@ MACHINE_START(BALLOON3, "Balloon3")
>  	.timer		= &pxa_timer,
>  	.init_machine	= balloon3_init,
>  	.atag_offset	= 0x100,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
> index 4efc16d..c2f0be0 100644
> --- a/arch/arm/mach-pxa/capc7117.c
> +++ b/arch/arm/mach-pxa/capc7117.c
> @@ -153,5 +153,6 @@ MACHINE_START(CAPC7117,
>  	.init_irq = pxa3xx_init_irq,
>  	.handle_irq = pxa3xx_handle_irq,
>  	.timer = &pxa_timer,
> -	.init_machine = capc7117_init
> +	.init_machine = capc7117_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
> index f2e4190..ec170a5 100644
> --- a/arch/arm/mach-pxa/cm-x2xx.c
> +++ b/arch/arm/mach-pxa/cm-x2xx.c
> @@ -524,4 +524,5 @@ MACHINE_START(ARMCORE, "Compulab CM-X2XX")
>  #ifdef CONFIG_PCI
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 3a7387f..dfd51d7 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -857,4 +857,5 @@ MACHINE_START(CM_X300, "CM-X300 module")
>  	.timer		= &pxa_timer,
>  	.init_machine	= cm_x300_init,
>  	.fixup		= cm_x300_fixup,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
> index 7db6646..17a29be 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> @@ -312,6 +312,7 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
>  MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
> @@ -321,5 +322,6 @@ MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
> index c825e8b..c01059a 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -189,5 +189,6 @@ MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
> index 692e1ff..6cc3caa 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -259,5 +259,6 @@ MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index 3e9483b..66faaaf 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -654,7 +654,7 @@ static void corgi_poweroff(void)
>  		/* Green LED off tells the bootloader to halt */
>  		gpio_set_value(CORGI_GPIO_LED_GREEN, 0);
>  
> -	arm_machine_restart('h', NULL);
> +	pxa_restart('h', NULL);
>  }
>  
>  static void corgi_restart(char mode, const char *cmd)
> @@ -663,13 +663,12 @@ static void corgi_restart(char mode, const char *cmd)
>  		/* Green LED on tells the bootloader to reboot */
>  		gpio_set_value(CORGI_GPIO_LED_GREEN, 1);
>  
> -	arm_machine_restart('h', cmd);
> +	pxa_restart('h', cmd);
>  }
>  
>  static void __init corgi_init(void)
>  {
>  	pm_power_off = corgi_poweroff;
> -	arm_pm_restart = corgi_restart;
>  
>  	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
>  	PCFR |= PCFR_OPDE;
> @@ -725,6 +724,7 @@ MACHINE_START(CORGI, "SHARP Corgi")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.init_machine	= corgi_init,
>  	.timer		= &pxa_timer,
> +	.restart	= corgi_restart,
>  MACHINE_END
>  #endif
>  
> @@ -736,6 +736,7 @@ MACHINE_START(SHEPHERD, "SHARP Shepherd")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.init_machine	= corgi_init,
>  	.timer		= &pxa_timer,
> +	.restart	= corgi_restart,
>  MACHINE_END
>  #endif
>  
> @@ -747,6 +748,7 @@ MACHINE_START(HUSKY, "SHARP Husky")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.init_machine	= corgi_init,
>  	.timer		= &pxa_timer,
> +	.restart	= corgi_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
> index 5e2cf39..fb5a51d 100644
> --- a/arch/arm/mach-pxa/csb726.c
> +++ b/arch/arm/mach-pxa/csb726.c
> @@ -278,4 +278,5 @@ MACHINE_START(CSB726, "Cogent CSB726")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.init_machine   = csb726_init,
>  	.timer          = &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index 94acc0b..bd396ba 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -1305,6 +1305,7 @@ MACHINE_START(EM_X270, "Compulab EM-X270")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= em_x270_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
>  MACHINE_START(EXEDA, "Compulab eXeda")
> @@ -1314,4 +1315,5 @@ MACHINE_START(EXEDA, "Compulab eXeda")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= em_x270_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
> index 8e697dd..8cafafa 100644
> --- a/arch/arm/mach-pxa/eseries.c
> +++ b/arch/arm/mach-pxa/eseries.c
> @@ -196,6 +196,7 @@ MACHINE_START(E330, "Toshiba e330")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e330_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -246,6 +247,7 @@ MACHINE_START(E350, "Toshiba e350")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e350_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -369,6 +371,7 @@ MACHINE_START(E400, "Toshiba e400")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e400_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -558,6 +561,7 @@ MACHINE_START(E740, "Toshiba e740")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e740_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -750,6 +754,7 @@ MACHINE_START(E750, "Toshiba e750")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e750_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -955,5 +960,6 @@ MACHINE_START(E800, "Toshiba e800")
>  	.fixup		= eseries_fixup,
>  	.init_machine	= e800_init,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 8308eee..15ab253 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -804,6 +804,7 @@ MACHINE_START(EZX_A780, "Motorola EZX A780")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = a780_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -870,6 +871,7 @@ MACHINE_START(EZX_E680, "Motorola EZX E680")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = e680_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -936,6 +938,7 @@ MACHINE_START(EZX_A1200, "Motorola EZX A1200")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = a1200_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1127,6 +1130,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = a910_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1193,6 +1197,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = e6_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1233,5 +1238,6 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = e2_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
> index 92a2e85..0d729e6 100644
> --- a/arch/arm/mach-pxa/generic.h
> +++ b/arch/arm/mach-pxa/generic.h
> @@ -57,3 +57,5 @@ void __init pxa_set_ffuart_info(void *info);
>  void __init pxa_set_btuart_info(void *info);
>  void __init pxa_set_stuart_info(void *info);
>  void __init pxa_set_hwuart_info(void *info);
> +
> +void pxa_restart(char, const char *);
> diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
> index 9c8208c..03e5e0b 100644
> --- a/arch/arm/mach-pxa/gumstix.c
> +++ b/arch/arm/mach-pxa/gumstix.c
> @@ -239,4 +239,5 @@ MACHINE_START(GUMSTIX, "Gumstix")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= gumstix_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
> index 4b5e110..fde6b4c 100644
> --- a/arch/arm/mach-pxa/h5000.c
> +++ b/arch/arm/mach-pxa/h5000.c
> @@ -209,4 +209,5 @@ MACHINE_START(H5400, "HP iPAQ H5000")
>  	.handle_irq = pxa25x_handle_irq,
>  	.timer = &pxa_timer,
>  	.init_machine = h5000_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
> index f2c3245..26d069a 100644
> --- a/arch/arm/mach-pxa/himalaya.c
> +++ b/arch/arm/mach-pxa/himalaya.c
> @@ -164,4 +164,5 @@ MACHINE_START(HIMALAYA, "HTC Himalaya")
>  	.handle_irq = pxa25x_handle_irq,
>  	.init_machine = himalaya_init,
>  	.timer = &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
> index 6f6368e..ce16bda 100644
> --- a/arch/arm/mach-pxa/hx4700.c
> +++ b/arch/arm/mach-pxa/hx4700.c
> @@ -845,4 +845,5 @@ MACHINE_START(H4700, "HP iPAQ HX4700")
>  	.handle_irq     = pxa27x_handle_irq,
>  	.init_machine = hx4700_init,
>  	.timer        = &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
> index f78d5db..e239b82 100644
> --- a/arch/arm/mach-pxa/icontrol.c
> +++ b/arch/arm/mach-pxa/icontrol.c
> @@ -196,5 +196,6 @@ MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= icontrol_init
> +	.init_machine	= icontrol_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
> index ddf20e5..fbabd84 100644
> --- a/arch/arm/mach-pxa/idp.c
> +++ b/arch/arm/mach-pxa/idp.c
> @@ -199,4 +199,5 @@ MACHINE_START(PXA_IDP, "Vibren PXA255 IDP")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= idp_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/include/mach/system.h b/arch/arm/mach-pxa/include/mach/system.h
> index d1fce8b..85494ff 100644
> --- a/arch/arm/mach-pxa/include/mach/system.h
> +++ b/arch/arm/mach-pxa/include/mach/system.h
> @@ -9,15 +9,11 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -
> -#include <asm/proc-fns.h>
> -#include "hardware.h"
> -#include "pxa2xx-regs.h"
> -
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
>  }
>  
> -
> -void arch_reset(char mode, const char *cmd);
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
> index 0037e57..1799a8e 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -444,4 +444,5 @@ MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform (aka Littleto
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= littleton_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
> index 1dd5302..6119c01 100644
> --- a/arch/arm/mach-pxa/lpd270.c
> +++ b/arch/arm/mach-pxa/lpd270.c
> @@ -505,4 +505,5 @@ MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= lpd270_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index c48ce6d..4b7a528 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -556,4 +556,5 @@ MACHINE_START(LUBBOCK, "Intel DBPXA250 Development Platform (aka Lubbock)")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= lubbock_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index 4b796c3..4e6774f 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -760,4 +760,5 @@ MACHINE_START(MAGICIAN, "HTC Magician")
>  	.handle_irq = pxa27x_handle_irq,
>  	.init_machine = magician_init,
>  	.timer = &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
> index 0567d39..ca14555 100644
> --- a/arch/arm/mach-pxa/mainstone.c
> +++ b/arch/arm/mach-pxa/mainstone.c
> @@ -622,4 +622,5 @@ MACHINE_START(MAINSTONE, "Intel HCDDBBVA0 Development Platform (aka Mainstone)")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= mainstone_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index 4f47a76..924a3b5 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -696,13 +696,13 @@ static void mioa701_machine_exit(void);
>  static void mioa701_poweroff(void)
>  {
>  	mioa701_machine_exit();
> -	arm_machine_restart('s', NULL);
> +	pxa_restart('s', NULL);
>  }
>  
>  static void mioa701_restart(char c, const char *cmd)
>  {
>  	mioa701_machine_exit();
> -	arm_machine_restart('s', cmd);
> +	pxa_restart('s', cmd);
>  }
>  
>  static struct gpio global_gpios[] = {
> @@ -734,7 +734,6 @@ static void __init mioa701_machine_init(void)
>  	pxa_set_udc_info(&mioa701_udc_info);
>  	pxa_set_ac97_info(&mioa701_ac97_info);
>  	pm_power_off = mioa701_poweroff;
> -	arm_pm_restart = mioa701_restart;
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  	gsm_init();
>  
> @@ -758,4 +757,5 @@ MACHINE_START(MIOA701, "MIO A701")
>  	.handle_irq	= &pxa27x_handle_irq,
>  	.init_machine	= mioa701_machine_init,
>  	.timer		= &pxa_timer,
> +	.restart	= mioa701_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
> index 4af5d51..169bf8f 100644
> --- a/arch/arm/mach-pxa/mp900.c
> +++ b/arch/arm/mach-pxa/mp900.c
> @@ -98,5 +98,6 @@ MACHINE_START(NEC_MP900, "MobilePro900/C")
>  	.init_irq	= pxa25x_init_irq,
>  	.handle_irq	= pxa25x_handle_irq,
>  	.init_machine	= mp900c_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
> index 3d4a281..1fa80f4f 100644
> --- a/arch/arm/mach-pxa/palmld.c
> +++ b/arch/arm/mach-pxa/palmld.c
> @@ -347,5 +347,6 @@ MACHINE_START(PALMLD, "Palm LifeDrive")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmld_init
> +	.init_machine	= palmld_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
> index 99d6bcf..5ba1431 100644
> --- a/arch/arm/mach-pxa/palmt5.c
> +++ b/arch/arm/mach-pxa/palmt5.c
> @@ -208,5 +208,6 @@ MACHINE_START(PALMT5, "Palm Tungsten|T5")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmt5_init
> +	.init_machine	= palmt5_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
> index 6ec7cae..e4dd719 100644
> --- a/arch/arm/mach-pxa/palmtc.c
> +++ b/arch/arm/mach-pxa/palmtc.c
> @@ -542,5 +542,6 @@ MACHINE_START(PALMTC, "Palm Tungsten|C")
>  	.init_irq	= pxa25x_init_irq,
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmtc_init
> +	.init_machine	= palmtc_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
> index 9376da0..5ebf49acb 100644
> --- a/arch/arm/mach-pxa/palmte2.c
> +++ b/arch/arm/mach-pxa/palmte2.c
> @@ -361,5 +361,6 @@ MACHINE_START(PALMTE2, "Palm Tungsten|E2")
>  	.init_irq	= pxa25x_init_irq,
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmte2_init
> +	.init_machine	= palmte2_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
> index 94e9708..ec82491 100644
> --- a/arch/arm/mach-pxa/palmtreo.c
> +++ b/arch/arm/mach-pxa/palmtreo.c
> @@ -452,6 +452,7 @@ MACHINE_START(TREO680, "Palm Treo 680")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = treo680_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -464,5 +465,6 @@ MACHINE_START(CENTRO, "Palm Centro 685")
>  	.handle_irq       = pxa27x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine	= centro_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
> index 4e3e459..6170d76 100644
> --- a/arch/arm/mach-pxa/palmtx.c
> +++ b/arch/arm/mach-pxa/palmtx.c
> @@ -369,5 +369,6 @@ MACHINE_START(PALMTX, "Palm T|X")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmtx_init
> +	.init_machine	= palmtx_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
> index 68e18ba..b2dff9d 100644
> --- a/arch/arm/mach-pxa/palmz72.c
> +++ b/arch/arm/mach-pxa/palmz72.c
> @@ -404,5 +404,6 @@ MACHINE_START(PALMZ72, "Palm Zire72")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= palmz72_init
> +	.init_machine	= palmz72_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
> index 0b825a3..fe90544 100644
> --- a/arch/arm/mach-pxa/pcm027.c
> +++ b/arch/arm/mach-pxa/pcm027.c
> @@ -265,4 +265,5 @@ MACHINE_START(PCM027, "Phytec Messtechnik GmbH phyCORE-PXA270")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= pcm027_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 1c597ad..7e054d4 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -416,7 +416,7 @@ static struct i2c_board_info __initdata poodle_i2c_devices[] = {
>  
>  static void poodle_poweroff(void)
>  {
> -	arm_machine_restart('h', NULL);
> +	pxa_restart('h', NULL);
>  }
>  
>  static void __init poodle_init(void)
> @@ -465,4 +465,5 @@ MACHINE_START(POODLE, "SHARP Poodle")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= poodle_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 6810cdd..697cbcd 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -1092,6 +1092,7 @@ MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1103,6 +1104,7 @@ MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1114,5 +1116,6 @@ MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
>  	.init_irq	= pxa3xx_init_irq,
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
> index b8bcda1..c8497b0 100644
> --- a/arch/arm/mach-pxa/reset.c
> +++ b/arch/arm/mach-pxa/reset.c
> @@ -81,8 +81,11 @@ static void do_hw_reset(void)
>  	OSMR3 = OSCR + 368640;	/* ... in 100 ms */
>  }
>  
> -void arch_reset(char mode, const char *cmd)
> +void pxa_restart(char mode, const char *cmd)
>  {
> +	local_irq_disable();
> +	local_fiq_disable();
> +
>  	clear_reset_status(RESET_STATUS_ALL);
>  
>  	switch (mode) {
> diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
> index fc2c1e0..8787070 100644
> --- a/arch/arm/mach-pxa/saar.c
> +++ b/arch/arm/mach-pxa/saar.c
> @@ -602,4 +602,5 @@ MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
>  	.handle_irq       = pxa3xx_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = saar_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
> index 3e999e3..b6dbaca 100644
> --- a/arch/arm/mach-pxa/saarb.c
> +++ b/arch/arm/mach-pxa/saarb.c
> @@ -111,5 +111,6 @@ MACHINE_START(SAARB, "PXA955 Handheld Platform (aka SAARB)")
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = saarb_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index f5bafcc..d8d089e 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -925,7 +925,7 @@ static inline void spitz_i2c_init(void) {}
>   ******************************************************************************/
>  static void spitz_poweroff(void)
>  {
> -	arm_machine_restart('g', NULL);
> +	pxa_restart('g', NULL);
>  }
>  
>  static void spitz_restart(char mode, const char *cmd)
> @@ -942,7 +942,6 @@ static void __init spitz_init(void)
>  {
>  	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
>  	pm_power_off = spitz_poweroff;
> -	arm_pm_restart = spitz_restart;
>  
>  	PMCR = 0x00;
>  
> @@ -988,6 +987,7 @@ MACHINE_START(SPITZ, "SHARP Spitz")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.init_machine	= spitz_init,
>  	.timer		= &pxa_timer,
> +	.restart	= spitz_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1000,6 +1000,7 @@ MACHINE_START(BORZOI, "SHARP Borzoi")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.init_machine	= spitz_init,
>  	.timer		= &pxa_timer,
> +	.restart	= spitz_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1012,5 +1013,6 @@ MACHINE_START(AKITA, "SHARP Akita")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.init_machine	= spitz_init,
>  	.timer		= &pxa_timer,
> +	.restart	= spitz_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
> index 4c9a48b..80d7f23 100644
> --- a/arch/arm/mach-pxa/stargate2.c
> +++ b/arch/arm/mach-pxa/stargate2.c
> @@ -1005,6 +1005,7 @@ MACHINE_START(INTELMOTE2, "IMOTE 2")
>  	.timer		= &pxa_timer,
>  	.init_machine	= imote2_init,
>  	.atag_offset	= 0x100,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
>  
> @@ -1017,5 +1018,6 @@ MACHINE_START(STARGATE2, "Stargate 2")
>  	.timer = &pxa_timer,
>  	.init_machine = stargate2_init,
>  	.atag_offset = 0x100,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
> index ad47bb9..4fa36a3 100644
> --- a/arch/arm/mach-pxa/tavorevb.c
> +++ b/arch/arm/mach-pxa/tavorevb.c
> @@ -495,4 +495,5 @@ MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
>  	.handle_irq       = pxa3xx_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = tavorevb_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
> index fd56916..8a22879 100644
> --- a/arch/arm/mach-pxa/tavorevb3.c
> +++ b/arch/arm/mach-pxa/tavorevb3.c
> @@ -132,4 +132,5 @@ MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
>  	.handle_irq       = pxa3xx_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine   = evb3_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
> index ef64530..dfe40f8 100644
> --- a/arch/arm/mach-pxa/tosa.c
> +++ b/arch/arm/mach-pxa/tosa.c
> @@ -905,7 +905,7 @@ static struct platform_device *devices[] __initdata = {
>  
>  static void tosa_poweroff(void)
>  {
> -	arm_machine_restart('g', NULL);
> +	pxa_restart('g', NULL);
>  }
>  
>  static void tosa_restart(char mode, const char *cmd)
> @@ -935,7 +935,6 @@ static void __init tosa_init(void)
>  	init_gpio_reset(TOSA_GPIO_ON_RESET, 0, 0);
>  
>  	pm_power_off = tosa_poweroff;
> -	arm_pm_restart = tosa_restart;
>  
>  	PCFR |= PCFR_OPDE;
>  
> @@ -978,4 +977,5 @@ MACHINE_START(TOSA, "SHARP Tosa")
>  	.handle_irq       = pxa25x_handle_irq,
>  	.init_machine   = tosa_init,
>  	.timer          = &pxa_timer,
> +	.restart	= tosa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
> index 35bbf13..55ee85a 100644
> --- a/arch/arm/mach-pxa/trizeps4.c
> +++ b/arch/arm/mach-pxa/trizeps4.c
> @@ -560,6 +560,7 @@ MACHINE_START(TRIZEPS4, "Keith und Koep Trizeps IV module")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
>  MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps IV-WL module")
> @@ -570,4 +571,5 @@ MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps IV-WL module")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 242ddae..afe2b74 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -998,4 +998,5 @@ MACHINE_START(VIPER, "Arcom/Eurotech VIPER SBC")
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer          = &pxa_timer,
>  	.init_machine	= viper_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index a7539a6..d2bd677 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -721,5 +721,6 @@ MACHINE_START(VPAC270, "Voipac PXA270")
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -	.init_machine	= vpac270_init
> +	.init_machine	= vpac270_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
> index 70e1730..4bbe9a3 100644
> --- a/arch/arm/mach-pxa/xcep.c
> +++ b/arch/arm/mach-pxa/xcep.c
> @@ -185,5 +185,6 @@ MACHINE_START(XCEP, "Iskratel XCEP")
>  	.init_irq	= pxa25x_init_irq,
>  	.handle_irq	= pxa25x_handle_irq,
>  	.timer		= &pxa_timer,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index ead32c9..d75f66a 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -725,4 +725,5 @@ MACHINE_START(ZIPIT2, "Zipit Z2")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= z2_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index 498b83b..9db35a7 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -911,5 +911,6 @@ MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= zeus_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
> index 31d4968..4e53c2d 100644
> --- a/arch/arm/mach-pxa/zylonite.c
> +++ b/arch/arm/mach-pxa/zylonite.c
> @@ -429,4 +429,5 @@ MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
>  	.handle_irq	= pxa3xx_handle_irq,
>  	.timer		= &pxa_timer,
>  	.init_machine	= zylonite_init,
> +	.restart	= pxa_restart,
>  MACHINE_END
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
