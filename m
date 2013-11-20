From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 09:45:17 -0700
Subject: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
In-Reply-To: <201311201637.36733.arnd@arndb.de>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <201311201637.36733.arnd@arndb.de>
Message-ID: <528CE71D.5090300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 08:37 AM, Arnd Bergmann wrote:
> On Friday 15 November 2013, Stephen Warren wrote:
>> This series implements a common reset framework driver for Tegra, and
>> updates all relevant Tegra drivers to use it. It also removes the custom
>> DMA bindings and replaced them with the standard DMA DT bindings.
> 
> The series is rather long, so I may have missed it, but I think you need one
> more patch to the apbdma binding to document the use of #dma-cells, what
> value it has, and what the format of the dma specifiers in slave drivers
> needs to be.

Yes, you're right. I will fold the following into "ARM: tegra: document
use of standard DMA DT bindings":

> diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> index 0b1e577ab9d3..0b0f9498e265 100644
> --- a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> +++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> @@ -11,6 +11,10 @@ Required properties:
>    See ../reset/reset.txt for details.
>  - reset-names : Must include the following entries:
>    - dma
> +- #iommu-cells : Must be <1>. This dictates the length of DMA specifiers in
> +  client nodes' dmas properties. The specifier represents the DMA request
> +  select value for the peripheral. For more details, consult the Tegra TRM's
> +  documentation of the APB DMA channel control register REQ_SEL field.
>  
>  Examples:
>  
> @@ -36,4 +40,5 @@ apbdma: dma at 6000a000 {
>  	clocks = <&tegra_car 34>;
>  	resets = <&tegra_car 34>;
>  	reset-names = "dma";
> +	#iommu-cells = <1>;
>  };
