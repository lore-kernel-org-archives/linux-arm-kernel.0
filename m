From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Mar 2016 09:47:29 +0100
Subject: [PATCH] arm64: tegra210-smaug: Add gpio-key nodes
In-Reply-To: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
References: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
Message-ID: <20160304084729.GB4038@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:54:25PM -0500, Rhyland Klein wrote:
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
[...]
> +		lid {
> +			label = "Lid";
> +			gpios = <&gpio TEGRA_GPIO(B, 4) GPIO_ACTIVE_LOW>;
> +			linux,input-type = <5>; /* EV_SW */
> +			linux,code = <0>; /* SW_LID */
> +			gpio-key,wakeup;
> +		};
> +
> +		tablet_mode {
> +			label = "Tablet Mode";
> +			gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <5>; /* EV_SW */
> +			linux,code = <1>; /* SW_TABLET_MODE */
> +			gpio-key,wakeup;
> +		};

Is there a way to trigger these on a DVT device? Power and volume
controls work fine, but I haven't found a way to test these two.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/1b26017c/attachment.sig>
