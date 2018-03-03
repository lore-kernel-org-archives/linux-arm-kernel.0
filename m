From: stefan@agner.ch (Stefan Agner)
Date: Sat, 03 Mar 2018 23:30:32 +0100
Subject: [PATCH 3/5] ARM: dts: vf500: Remove empty reg memory property
In-Reply-To: <1519755447-9666-3-git-send-email-festevam@gmail.com>
References: <1519755447-9666-1-git-send-email-festevam@gmail.com>
 <1519755447-9666-3-git-send-email-festevam@gmail.com>
Message-ID: <84bafc30cee782f72cb5e897bf2be0a7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.02.2018 19:17, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> All the vf500 based boards include the real memory size in their
> dts files, so remove the empty reg memory property.

Nit: This is somewhat confusing, it almost sounds as if you want to
remove the memory node.

How about:
...so remove the zero length reg property.

Otherwise this series looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/vf500.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
> index 1e3b479..bbff011 100644
> --- a/arch/arm/boot/dts/vf500.dtsi
> +++ b/arch/arm/boot/dts/vf500.dtsi
> @@ -47,7 +47,7 @@
>  	#size-cells = <1>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; reg = <0 0>; };
> +	memory { device_type = "memory"; };
>  
>  	cpus {
>  		#address-cells = <1>;
