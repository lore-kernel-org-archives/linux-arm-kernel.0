From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 10:07:31 +0100
Subject: [PATCH v3] ARM: dtsi: sun8i-r40: add mali node
In-Reply-To: <20181101085710.15774-1-lothar.felten@gmail.com>
References: <20181101085710.15774-1-lothar.felten@gmail.com>
Message-ID: <20181105090731.vkcdwde5zmkxjzmc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,x

On Thu, Nov 01, 2018 at 09:57:10AM +0100, Lothar Felten wrote:
> This patch adds a node for the mali 400 GPU of the R40/V40 SoC
> 
> Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
> ---
> Changes v2->v3:
> - remove mali clock rates
> - drop hdmi-phy sun50i-a64 compatibility  
> - patch version, change log added
> 
> Changes v1->v2:
> - commit message uppercase ARM prefix
> - wrong patch submitted by mistake
> ---
> 
>  arch/arm/boot/dts/sun8i-r40.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 6f4c9ca5a3ee..136c248cc7d1 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -542,6 +542,28 @@
>  
>  		};
>  
> +		mali: gpu at 1c40000 {
> +			compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";

You should have an r40 compatible here. You can have a look at the
A23-A33 DTSI compatible for an example if you want.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/5662b15f/attachment.sig>
