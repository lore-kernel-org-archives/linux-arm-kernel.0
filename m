From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 15:03:34 +0100
Subject: [PATCH 1/4] ARM: tegra: add I2C controllers to Tegra124 DT
In-Reply-To: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131206140333.GE30960@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:26:53PM -0700, Stephen Warren wrote:
[...]
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
[...]
> @@ -176,6 +176,96 @@
>  		status = "disabled";
>  	};
>  
> +	i2c at 7000c000 {
> +		compatible = "nvidia,tegra114-i2c";

Aren't we supposed to always list the most specific compatible as well,
just in case we ever need to implement a specific quirk in the future?

So this would become:

		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";

Other than that, this is identical to a local patch that I have (minus
the reset* and dma* properties).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/2f9dd0bd/attachment.sig>
