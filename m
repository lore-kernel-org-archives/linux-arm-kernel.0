From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Jan 2015 10:34:40 -0700
Subject: [PATCH v2 09/11] ARM: tegra: Use pwrseq-simple for the wifi in
 Nyan
In-Reply-To: <1421338359-27467-10-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-10-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <54B7FA30.5010301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
> The Nyan boards have a Marvell 88w8897 wifi card connected through SDIO
> that need the reset line to be hold active for several milliseconds.

> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi

> +	sdhci0_pwrseq: sdhci0_pwrseq {
> +		compatible = "mmc,pwrseq-simple";
> +
> +                reset-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
> +                delay = <20>; /* ms */

Some of these new lines are indented with spaces not TABs.
