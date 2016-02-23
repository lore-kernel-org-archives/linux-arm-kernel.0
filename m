From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Feb 2016 14:56:53 -0700
Subject: [PATCH] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <1456260543-18076-1-git-send-email-dev@lynxeye.de>
References: <1456260543-18076-1-git-send-email-dev@lynxeye.de>
Message-ID: <56CCD5A5.9080809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 01:49 PM, Lucas Stach wrote:
> Update pinmux to get rid of invalid uses of the rsvd1 function and
> add correct drive settings for SDIO1, which makes some more SD-cards
> work.

(Adding a variety of missing CCs)

I think this patch looks OK. Looking at the kernel pinctrl driver, I 
think that before this patch, because some of the mux settings were 
deemed invalid by the pinctrl driver, the pinmux settings were not all 
applied, and this change fixes it? Ouch! Luckily U-Boot programmed what 
is hopefully the same table before the kernel booted!

> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts

... (many other fixes; see original email)

> +			sdio1 {
> +				nvidia,pins = "drive_sdio1";
> +				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
> +				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
> +				nvidia,pull-down-strength = <46>;
> +				nvidia,pull-up-strength = <42>;
> +				nvidia,slew-rate-rising = <1>;
> +				nvidia,slew-rate-falling = <1>;
> +			};

I think it would be worth mentioning in the commit description where 
this data came from.
