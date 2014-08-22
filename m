From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 22 Aug 2014 23:30:27 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Explicitly set dr_mode on peach-pit
 and peach-pi
In-Reply-To: <1408741021-17759-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1408741021-17759-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1408741021-17759-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <53F7B673.9030400@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 22.08.2014 22:57, schrieb Sjoerd Simons:
> In case the optional dr_mode property isn't set in the dwc3 nodes the
> the controller will go into OTG mode iff both USB host and USB gadget
> functionality are enabled in the kernel configuration. Unfortunately this
> results in USB not working on exynos5420-peach-pit and
> exynos5800-peach-pi with such a kernel configuration unless manually
> change the mode. To resolve that explicitely configure the dual role
> mode as host
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 8 ++++++++
>  arch/arm/boot/dts/exynos5420.dtsi          | 4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 8 ++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 228a6b1..6c22610 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -427,10 +427,18 @@
>  	status = "okay";
>  };
>  
> +&usbdrd_dwc3_0 {
> +	dr_mode = "host";
> +};
> +
>  &usbdrd_phy0 {
>  	vbus-supply = <&usb300_vbus_reg>;
>  };
>  
> +&usbdrd_dwc3_1 {
> +	dr_mode = "host";
> +};

The sort order should be alphabetical here, which means dwc before phy.

> +
>  &usbdrd_phy1 {
>  	vbus-supply = <&usb301_vbus_reg>;
>  };
[...]
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index f3ee48b..166b352 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -425,10 +425,18 @@
>  	status = "okay";
>  };
>  
> +&usbdrd_dwc3_0 {
> +	dr_mode = "host";
> +};
> +
>  &usbdrd_phy0 {
>  	vbus-supply = <&usb300_vbus_reg>;
>  };
>  
> +&usbdrd_dwc3_1 {
> +	dr_mode = "host";
> +};

Dito.

> +
>  &usbdrd_phy1 {
>  	vbus-supply = <&usb301_vbus_reg>;
>  };

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
