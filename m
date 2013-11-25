From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Nov 2013 23:07:55 +0100
Subject: [PATCH V2 3/3] ARM: tegra: document use of standard DMA DT
 bindings
In-Reply-To: <1385417161-5542-4-git-send-email-swarren@wwwdotorg.org>
References: <1385417161-5542-1-git-send-email-swarren@wwwdotorg.org>
 <1385417161-5542-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <11843948.6MmkNU7Gku@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 November 2013 15:06:01 Stephen Warren wrote:
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
>         clocks = <&tegra_car 34>;
>         resets = <&tegra_car 34>;
>         reset-names = "dma";
> +       #iommu-cells = <1>;

s/iommu-cells/dma-cells/

	Arnd
