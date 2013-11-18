From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 18 Nov 2013 19:11:24 +0100
Subject: [PATCH v4 0/4] Add support for the Allwinner A31 Reset Controllers
In-Reply-To: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1384798284.4348.33.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Freitag, den 15.11.2013, 19:19 +0100 schrieb Maxime Ripard:
> Hi everyone,
> 
> This patchset adds support for the reset controllers found in the Allwinner A31
> SoCs. Since these controllers are pretty simple, basically just a few MMIO
> registers, with a single bit controlling the reset state of the other devices
> it asserts in reset, the driver is quite simple as well.
> 
> However, one of the IPs asserted in reset by these controllers are the timers,
> the only thing standing out is that it requires to be registered before the
> timers are initialized.
> 
> Thanks,
> Maxime

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> Changes from v3:
>   - Added some locking
>   - Added back the sun6i compatible and the request_mem_region
> 
> Changes from v2:
>   - Changed the commit logs to be a bit more generic
>   - Fixed a stupid breakage in the Makefile
> 
> Changes from v1:
>   - Don't call request_mem_region, since some of these controllers will share
>     registers with clock drivers
>   - Switched to a more generic allwinner,sun4i-clock-reset compatible, since a
>     lot of these controllers are found in other SoCs than the A31
>   - Switched to a "real" driver using the device model for all these reset
>     controllers but the one that needs to be initialised early.
>   - Fixed a typo in one of the DT bindings that was leading to a compilation
>     breakage
> 
> Maxime Ripard (4):
>   reset: Add Allwinner SoCs Reset Controller Driver
>   ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER
>   ARM: sunxi: Register the A31 reset IP in init_time
>   ARM: sun6i: Add the reset controller to the DTSI
> 
>  arch/arm/boot/dts/sun6i-a31.dtsi |  24 ++++++
>  arch/arm/mach-sunxi/Kconfig      |   1 +
>  arch/arm/mach-sunxi/sunxi.c      |  10 ++-
>  drivers/reset/Makefile           |   1 +
>  drivers/reset/reset-sunxi.c      | 175 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 210 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/reset/reset-sunxi.c

regards
Philipp
