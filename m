From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Feb 2014 20:08:50 +0000
Subject: [PATCH 2/3] mfd: axp20x: Add dtsi for axp20x
In-Reply-To: <1391875428-6281-3-git-send-email-carlo@caione.org>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-3-git-send-email-carlo@caione.org>
Message-ID: <20140210200850.GB32042@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 08 Feb 2014, Carlo Caione wrote:

> This patch adds a new dtsi for supporting axp20x.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/axp20x.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 arch/arm/boot/dts/axp20x.dtsi
> 
> diff --git a/arch/arm/boot/dts/axp20x.dtsi b/arch/arm/boot/dts/axp20x.dtsi
> new file mode 100644
> index 0000000..98d4c7c
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp20x.dtsi
> @@ -0,0 +1,9 @@
> +/*
> +* Integrated Power Management Chip AXP209
> +*/
> +
> +&axp {
> +	compatible = "x-powers,axp20x";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +};

I's suggest not doing it this way. Having a .dtsi file for every
device is not the way Device Tree has been designed. This snippet
should be copied directly into device's .dts(i) files.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
