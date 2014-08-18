From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 18 Aug 2014 16:05:15 -0700
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
Message-ID: <CAL1qeaFS6k+ZbX=viBOvt+5Ryqk2j_TxckbH_sOxSx8CiA43qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> WiFi does not work yet, it needs at least some PMIC changes to enable
> the 32k clock.

In addition to getting the PMIC to generate the 32k clock at 1.8V
(instead of the 5V it's operating at now), you'll also need...

> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts

> +                       sdmmc1_clk_pz0 {
> +                               nvidia,pins = "sdmmc1_clk_pz0";
> +                               nvidia,function = "sdmmc1";
> +                               nvidia,enable-input = <TEGRA_PIN_DISABLE>;

... to turn on the input enable for the SD clock pin on the SDIO
interface.  Unfortunately that still isn't sufficient to get WiFi
working as SDIO commands are still timing out.  But the mwifiex card
is at least attempting to probe now.

> +                               nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> +                               nvidia,tristate = <TEGRA_PIN_DISABLE>;
> +                       };
