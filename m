From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 9 Jul 2013 08:04:49 +0200
Subject: [PATCH V2] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
References: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130709060447.GA17499@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 02:44:29PM +0530, Laxman Dewangan wrote:
> Dalmore have the keys mounted on board which are connected
> to different pins of Tegra.
> 
> Add the keys entry in DTS file to enable key functionality.
> This will enable KEY_POWER, KEY_HOME, KEY_VOLUMEUP and
> KEY_VOLUMEDOWN.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Reorder the nodes.
> 
>  arch/arm/boot/dts/tegra114-dalmore.dts |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index cb640eb..259b517 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -883,6 +883,35 @@
>  		};
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		home {
> +			label = "Home";
> +			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <102>; /* KEY_HOME */

I wonder if these should maybe go into a header file as well so that
symbolic names can be used. That'll make the value self-descriptive and
allow the comment to be dropped.

> +		volume_down {
> +			label = "VolumeDown";
> +			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
> +			linux,code = <114>; /* KEY_VOLUMEDOWN */
> +		};
> +
> +		volume_up {
> +			label = "VolumeUp";
> +			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <115>; /* KEY_VOLUMEUP */
> +		};
> +	};

Nit: Perhaps the labels should be "Volume Down" and "Volume Up" here?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/75068339/attachment.sig>
