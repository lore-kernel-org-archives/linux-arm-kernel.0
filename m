From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Oct 2013 15:00:04 +0300
Subject: [PATCH] ARM: dts: omap3-beagle: Adapt USB OTG to generic PHY
 framework
In-Reply-To: <1381142810-14541-1-git-send-email-rogerq@ti.com>
References: <1381142810-14541-1-git-send-email-rogerq@ti.com>
Message-ID: <526122C4.4090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

Could you please include this one for 3.13?
Without this OTG port will be broken for beagle. Thanks.

cheers,
-roger

On 10/07/2013 01:46 PM, Roger Quadros wrote:
> The generic PHY framewrok expects different properties than the
> old USB PHY framework. Supply those properties.
> 
> Fixes USB OTG port on beagle after the Generic PHY framework was
> merged in greg/usb-next. [1]
> 
> [1] - https://lkml.org/lkml/2013/9/27/581
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 7669c16..fa532aa 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -173,6 +173,8 @@
>  &usb_otg_hs {
>  	interface-type = <0>;
>  	usb-phy = <&usb2_phy>;
> +	phys = <&usb2_phy>;
> +	phy-names = "usb2-phy";
>  	mode = <3>;
>  	power = <50>;
>  };
> 
