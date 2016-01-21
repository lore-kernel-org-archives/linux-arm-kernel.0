From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 Jan 2016 21:08:26 -0800
Subject: [PATCH] ARM: dts: imx6: enable pl310 "shared attribute override
 enable" bit
In-Reply-To: <1453346938-5625-1-git-send-email-b38611@freescale.com>
References: <1453346938-5625-1-git-send-email-b38611@freescale.com>
Message-ID: <4df58eebc9995bcdb91f2f16b3093ed7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 2016-01-20 19:28, Fugang Duan wrote:
> The default behavior of the L220 or PL310 cache controllers with respect
> to the shareable attribute is to transform "normal memory non-cacheable
> transactions" into "cacheable no allocate" (for reads) or "write through
> no write allocate" (for writes).
> 
> On i.MX6 series platforms, enet/audio/usb/nand DMA buffer have corruption
> without CMA. So set this property "arm,shared-override" in L2 dts node to
> enable "shared attribute override enable" bit.

Do you happen to know if Vybrid could also suffer this too? Some IP's
are the same/similar ones...

Did this manifest in any way?

--
Stefan


> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
>  arch/arm/boot/dts/imx6sl.dtsi  | 1 +
>  arch/arm/boot/dts/imx6sx.dtsi  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 4f6ae92..b4de39a 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -185,6 +185,7 @@
>  			cache-level = <2>;
>  			arm,tag-latency = <4 2 3>;
>  			arm,data-latency = <4 2 3>;
> +			arm,shared-override;
>  		};
>  
>  		pcie: pcie at 0x01000000 {
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index d12b250..3b80b45 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -113,6 +113,7 @@
>  			cache-level = <2>;
>  			arm,tag-latency = <4 2 3>;
>  			arm,data-latency = <4 2 3>;
> +			arm,shared-override;
>  		};
>  
>  		pmu {
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index a5f7602..42f8f3b 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -155,6 +155,7 @@
>  			cache-level = <2>;
>  			arm,tag-latency = <4 2 3>;
>  			arm,data-latency = <4 2 3>;
> +			arm,shared-override;
>  		};
>  
>  		dma_apbh: dma-apbh at 01804000 {
