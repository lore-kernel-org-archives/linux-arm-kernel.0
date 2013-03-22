From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Mar 2013 11:29:30 +0100
Subject: [PATCH V4 8/9] ARM: tegra: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-9-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-9-git-send-email-achew@nvidia.com>
Message-ID: <20130322102930.GA4567@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:59:32AM -0700, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-medcom-wide.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
> index a2d6d65..bf7fdd7 100644
> --- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
> +++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
> @@ -26,12 +26,18 @@
>  		};
>  	};
>  
> +	bl_en: fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl-en-supply";
> +	};

This should go into the top-level regulators node which this DTS
inherits from tegra20-tamonten.dtsi.

I think it'd be nice to rename it to something like backlight_reg for
consistency with other regulators in that node.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/b3014e2c/attachment.sig>
