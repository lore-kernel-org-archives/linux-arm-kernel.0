From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Aug 2017 23:14:48 +0200
Subject: [PATCH v2 4/5] arm64: dts: add RK3399-Q7 (Puma) SoM
In-Reply-To: <20170818193445.47542-5-klaus.goger@theobroma-systems.com>
References: <20170818193445.47542-1-klaus.goger@theobroma-systems.com>
 <20170818193445.47542-5-klaus.goger@theobroma-systems.com>
Message-ID: <2629491.nQPY0c5PWU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. August 2017, 21:34:44 CEST schrieb Klaus Goger:
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
> ---
> 
> Changes in v2:
> ? split SoM parts into it's own dtsi
> - use dashes in phandles

as I was stumbling over this comment and checked the patch for it,
dashes in node-names, underscores in phandles (phandles are the
references defined in front of nodes and used later).

The patch itself is doing things correctly, so it's only a wording issue here :-)

Otherwise looks good, just need Rob looking at the bindings things.
I'll probably find some properties to move around when applying
(to conform to sorting expectations)


Heiko
