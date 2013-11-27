From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 27 Nov 2013 14:27:19 +0530
Subject: [PATCH v3 9/9] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <1385403367-18144-10-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
 <1385403367-18144-10-git-send-email-matt.porter@linaro.org>
Message-ID: <5295B3EF.8010602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 25 November 2013 11:46 PM, Matt Porter wrote:
> Adds USB OTG/PHY and clock support to BCM281xx and enables
> UDC support on the bcm11351-brt and bcm28155-ap boards.
> 
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351-brt.dts |  6 ++++++
>  arch/arm/boot/dts/bcm11351.dtsi    | 18 ++++++++++++++++++
>  arch/arm/boot/dts/bcm28155-ap.dts  |  8 ++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
> index 23cd16d..396b704 100644
> --- a/arch/arm/boot/dts/bcm11351-brt.dts
> +++ b/arch/arm/boot/dts/bcm11351-brt.dts
> @@ -44,5 +44,11 @@
>  		status = "okay";
>  	};
>  
> +	usbotg: usb at 3f120000 {
> +		status = "okay";
> +	};

using &usbotg could have been better. I mean if you have something like
&usbotg, you realise that the node has been created somewhere and we are just
referencing it here to add more properties.

Thanks
Kishon
