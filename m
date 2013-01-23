From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 23 Jan 2013 06:32:12 +0000
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add GPMC node
In-Reply-To: <8738xu9rni.fsf@dell.be.48ers.dk>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
 <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
 <8738xu9rni.fsf@dell.be.48ers.dk>
Message-ID: <518397C60809E147AF5323E0420B992E3EA62B27@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 02:31:53, Peter Korsgaard wrote:
> >>>>> "Philip" == Philip Avinash <avinashphilip@ti.com> writes:
> 
>  Philip> From: "Philip, Avinash" <avinashphilip@ti.com>
>  Philip> Add GPMC data node to AM33XX device tree file.
> 
>  Philip> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
>  Philip> ---
>  Philip>  arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
>  Philip>  1 file changed, 12 insertions(+)
> 
>  Philip> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> index eaef5e7..f4209d8 100644
>  Philip> --- a/arch/arm/boot/dts/am33xx.dtsi
>  Philip> +++ b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> @@ -393,5 +393,17 @@
>  Philip>  			ti,hwmods = "elm";
>  Philip>  			status = "disabled";
>  Philip>  		};
>  Philip> +
>  Philip> +		gpmc: gpmc at 50000000 {
>  Philip> +			compatible = "ti,am3352-gpmc";
>  Philip> +			ti,hwmods = "gpmc";
>  Philip> +			reg = <0x50000000 0x2000>;
>  Philip> +			interrupts = <100>;
>  Philip> +			num-cs = <8>;
> 
> Next to Jan's comment about am335x having 7 cs signals, I just realized
> the difference in compatible string between the gpmc and elm. The gpmc
> refers to a real device (which is afaik how it should be done), but the
> elm compatible is simply ti,am33xx-elm.
> 
> Presumably it should have been ti,am3352-elm in the binding instead?

I thought of following the file name convention. I will correct to "ti,am3352-elm"

> 
> Other than that it looks fine.
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> 
