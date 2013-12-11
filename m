From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 15:44:47 +0100
Subject: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201312111544.47519.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Zhangfei Gao wrote:
> +PCTRL: Peripheral misc control register
> +
> +Required Properties:
> +- compatible: "hisilicon,pctrl"
> +- reg: Address and size of pctrl.
> +
> +Example:
> +
> +       /* for Hi3620 */
> +       pctrl: pctrl at fca09000 {
> +               compatible = "hisilicon,pctrl";
> +               reg = <0xfca09000 0x1000>;
> +       };

It seems you are missing the clock specific parts of the binding:
You should document the required value of #clock-cells as well as
the possible values for the clock specifier.

	Arnd
