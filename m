From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 01 Jul 2017 00:13:25 +0200
Subject: [PATCH 4/4] arm64: dts: add RK3399-Q7 (Puma) SoM
In-Reply-To: <20170626191854.58253-5-klaus.goger@theobroma-systems.com>
References: <20170626191854.58253-1-klaus.goger@theobroma-systems.com>
 <20170626191854.58253-5-klaus.goger@theobroma-systems.com>
Message-ID: <1912092.hfJnF4sPpq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Klaus,

Am Montag, 26. Juni 2017, 21:18:54 CEST schrieb Klaus Goger:
> The RK3399-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
> connector) system-on-module from Theobroma Systems, featuring the
> Rockchip RK3399.
> 
> It provides the following feature set:
>  * up to 4GB DDR3
>  * on-module SPI-NOR flash
>  * on-module eMMC (with 8-bit 1.8V interface)
>  * SD card (on a baseboad) via edge connector
>  * Gigabit Ethernet with on-module Micrel KSZ9031 GbE PHY
>  * HDMI/eDP/2x MIPI-DSI
>  * 2x MIPI-CSI
>  * USB
>    - 1x USB 3.0 dual-role (direct connection)
>    - 2x USB 3.0 host + 1x USB 2.0 (on-module USB 3.0 hub)
>  * on-module STM32 Cortex-M0 companion controller, implementing:
>    - low-power RTC functionality (ISL1208 emulation)
>    - fan controller (AMC6821 emulation)
>    - USB<->CAN bridge controller
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/Makefile        |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dts | 650 +++++++++++++++++++++++++++

One thing I forgot to address was the SOM'nes of the puma board. People
might want to use that with different base-boards so you might want to
split this up into a rk3399-puma-som.dtsi and for example rk3399-puma-haikou.dts
for the Puma + Haikou Q7 combination.

Examples for such a split may be the rk3288-phycore, rk3288-rock2 and
rk3288-firefly-reload.


Heiko
