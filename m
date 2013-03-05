From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 5 Mar 2013 17:12:21 -0600
Subject: [PATCH 2/2] Arm: socfpga: pl330: Add #dma-cells for generic dma
 binding support
In-Reply-To: <1362375268-29405-2-git-send-email-padma.v@samsung.com>
References: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
 <1362375268-29405-2-git-send-email-padma.v@samsung.com>
Message-ID: <1362525141.8920.8.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-04 at 11:04 +0530, Padmavathi Venna wrote:
> This patch adds #dma-cells property to PL330 DMA controller nodes for
> supporting generic dma dt bindings on SOCFPGA platform. #dma-channels
> and #dma-requests are not required now but added in advance.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
> 
> Based on Torvalds tree
> 
>  arch/arm/boot/dts/socfpga.dtsi |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 936d230..7e8769b 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -75,6 +75,9 @@
>  				compatible = "arm,pl330", "arm,primecell";
>  				reg = <0xffe01000 0x1000>;
>  				interrupts = <0 180 4>;
> +				#dma-cells = <1>;
> +				#dma-channels = <8>;
> +				#dma-requests = <32>;

Acked-by: Dinh Nguyen <dinguyen@altera.com?

Thanks..
Dinh
>  			};
>  		};
>  
