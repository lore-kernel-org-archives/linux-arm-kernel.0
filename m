From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 15:19:50 -0600
Subject: [PATCH v3 3/7] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
In-Reply-To: <20180223122552.58049-4-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-4-icenowy@aosc.io>
Message-ID: <20180301211950.ust7g4jnlncrvwxp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 08:25:48PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).
> 
> This commit introduces support for the main pin controller on H6.
> 
> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format. The GPIO functions are dropped, as they're impossible to use --
> except a GPIO&IRQ only pin (PB20) which might be the IRQ of ATE.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - SPDX license identifier fix.
> - Dropped most GPIO functionality at PA/PB.
> 
> Changes in v2:
> - Dropped without_bus_gate description.
> - Switched to SPDX license identifier.
> 
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Please add acks when posting new versions.

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 614 +++++++++++++++++++++
>  4 files changed, 620 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
