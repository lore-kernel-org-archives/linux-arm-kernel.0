From: a0131933@ti.com (Lokesh Vutla)
Date: Mon, 14 Mar 2016 14:43:41 +0530
Subject: [PATCH] ARM: dts: am43xx: fix edma memcpy channel allocation
In-Reply-To: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
References: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
Message-ID: <56E680C5.5000409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 14 March 2016 02:31 PM, Tero Kristo wrote:
> EDMA was allocating DMA channels 32 and 33 for memcpy usage, out of which
> channel 33 is actually used by DES crypto engine. This bad allocation of
> the channel causes a crash in the DES crypto engine, as the channel
> gets configured for memcpy usage instead of hardware <-> memory DMA.
> 
> Fixed by allocating DMA channels 58 and 59 for memcpy usage (I2C0 RX/TX),
> which are not used by anybody.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Suggested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 92068fb..cdd3d78 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -207,7 +207,7 @@
>  			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
>  				   <&edma_tptc2 0>;
>  
> -			ti,edma-memcpy-channels = <32 33>;
> +			ti,edma-memcpy-channels = <58 59>;
>  		};
>  
>  		edma_tptc0: tptc at 49800000 {
> 
