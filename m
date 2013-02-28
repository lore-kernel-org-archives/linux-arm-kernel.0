From: b32955@freescale.com (Huang Shijie)
Date: Thu, 28 Feb 2013 16:39:12 +0800
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <512F17B0.5080705@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?02?27? 23:25, Shawn Guo ??:
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> @@ -7,10 +7,12 @@ Required properties:
>    - compatible : should be "fsl,<chip>-gpmi-nand"
>    - reg : should contain registers location and length for gpmi and bch.
>    - reg-names: Should contain the reg names "gpmi-nand" and "bch"
> -  - interrupts : The first is the DMA interrupt number for GPMI.
> -                 The second is the BCH interrupt number.
> -  - interrupt-names : The interrupt names "gpmi-dma", "bch";
> -  - fsl,gpmi-dma-channel : Should contain the dma channel it uses.
> +  - interrupts : BCH interrupt number.
> +  - interrupt-names : Should be "bch".
why split out the bch interrupt? It seems no use to do it.

thanks
Huang Shijie
