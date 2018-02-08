From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Feb 2018 14:16:43 -0600
Subject: [PATCH v2 2/6] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
In-Reply-To: <20180203154942.63566-3-icenowy@aosc.io>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-3-icenowy@aosc.io>
Message-ID: <20180208201643.vqj7o5v5rzlwsoch@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 03, 2018 at 11:49:38PM +0800, Icenowy Zheng wrote:
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
> format.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped without_bus_gate description.
> - Switched to SPDX license identifier.
> 
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 676 +++++++++++++++++++++
>  4 files changed, 682 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
