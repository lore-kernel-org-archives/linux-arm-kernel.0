From: george.cherian@ti.com (George Cherian)
Date: Mon, 28 Apr 2014 19:55:51 +0530
Subject: [PATCH] ARM: dts: am33xx: fix DMA support for the second USB
 interface
In-Reply-To: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com>
References: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <535E64EF.2020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2014 2:07 PM, yegorslists at googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch creates unique DMA channels for the second USB
> interface, otherwise the second USB interface is not usable
> at all.
MUSB_DMA_NUM_CHANNELS is 15, so if you pass  any dma-names > 15 (> 
rx15/tx15),
the dma_controller_create in musb_core.c fails and it falls back to PIO 
mode.

>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi |   12 ++++++------
>   1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 07f283c..e04cbbc 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -548,12 +548,12 @@
>   					&cppi41dma 26 1 &cppi41dma 27 1
>   					&cppi41dma 28 1 &cppi41dma 29 1>;
>   				dma-names =
> -					"rx1", "rx2", "rx3", "rx4", "rx5", "rx6", "rx7",
> -					"rx8", "rx9", "rx10", "rx11", "rx12", "rx13",
> -					"rx14", "rx15",
> -					"tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
> -					"tx8", "tx9", "tx10", "tx11", "tx12", "tx13",
> -					"tx14", "tx15";
> +					"rx16", "rx17", "rx18", "rx19", "rx20", "rx21", "rx22",
> +					"rx23", "rx24", "rx25", "rx26", "rx27", "rx28",
> +					"rx29", "rx30",
> +					"tx16", "tx17", "tx18", "tx19", "tx20", "tx21", "tx22",
> +					"tx23", "tx24", "tx25", "tx26", "tx27", "tx28",
> +					"tx29", "tx30";
>   			};
>   
>   			cppi41dma: dma-controller at 47402000 {


-- 
-George
