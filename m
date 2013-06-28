From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Jun 2013 12:34:06 +0300
Subject: [PATCH V2 2/3] ARM: dts: Add DP PHY node to exynos5250.dtsi
In-Reply-To: <002001ce73cf$721b9d80$5652d880$@samsung.com>
References: <002001ce73cf$721b9d80$5652d880$@samsung.com>
Message-ID: <20130628093406.GC11297@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 04:16:44PM +0900, Jingoo Han wrote:
> Add PHY provider node for the DP PHY.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 41cd625..f7bac75 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -614,6 +614,12 @@
>  		interrupts = <0 94 0>;
>  	};
>  
> +	dp_phy: video-phy at 10040720 {
> +		compatible = "samsung,exynos5250-dp-video-phy";
> +		reg = <0x10040720 4>;
> +		#phy-cells = <0>;
> +	};
> +
>  	dp-controller {
>  		compatible = "samsung,exynos5-dp";
>  		reg = <0x145b0000 0x1000>;
> @@ -623,11 +629,8 @@
>  		clock-names = "dp";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -
> -		dptx-phy {
> -			reg = <0x10040720>;
> -			samsung,enable-mask = <1>;
> -		};
> +		phys = <&dp_phy 0>;

phy-cells being 0, means that this would become:

		phys = <&dp_phy>;

> +		phy-names = "dp";

for the label, I would use something more descriptive such as
'display-port'.

other than that:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/fbda190c/attachment.sig>
