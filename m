From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 16:17:44 -0600
Subject: [PATCH v5 1/4] mmc: meson: Document Amlogic Meson MMC DT bindings
In-Reply-To: <1456596108-1406-2-git-send-email-carlo@caione.org>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-2-git-send-email-carlo@caione.org>
Message-ID: <20160303221744.GA1828@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 07:01:45PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../devicetree/bindings/mmc/meson-mmc.txt          | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/meson-mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/meson-mmc.txt b/Documentation/devicetree/bindings/mmc/meson-mmc.txt
> new file mode 100644
> index 0000000..328157e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/meson-mmc.txt
> @@ -0,0 +1,30 @@
> +* Amlogic Meson MMC controller
> +
> +The highspeed MMC host controller on Amlogic SoCs provides an interface
> +for MMC, SD, SDIO and SDHC types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> +as the speed of SD standard 2.0.
> +
> +Required properties:
> + - compatible : "amlogic,meson-mmc"
> + - reg : mmc controller base registers
> + - interrupts : mmc controller interrupt
> + - clocks : phandle to clock provider
> + - pinctrl-names : should contain "sdio_a" or "sdio_b"
> + - pinctrl-0: Should specify pin control groups used for this controller
> +
> +Optional properties:
> + - meson,sd-port : 0 for port A, 1 for port B

This is different than the pinctrl-names? It needs a better description 
including what is the default if absent.

> + - for cd, bus-width and additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> +
> +Examples:
> +	mmc0: mmc at c1108c20 {
> +		pinctrl-names = "sdio_b";
> +		pinctrl-0 = <&mmc0_sd_b_pins>;
> +		compatible = "amlogic,meson-mmc";
> +		reg = <0xc1108c20 0x20>;
> +		interrupts = <0 28 1>;
> +		clocks = <&clkc CLKID_CLK81>;
> +	};
> -- 
> 1.9.1
> 
