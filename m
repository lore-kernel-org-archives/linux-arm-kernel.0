From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 19:38:29 +0000
Subject: [PATCH v2 01/12] ARM: dts: add generic DMA device tree binding
 for mxs-dma
In-Reply-To: <1362486244-24593-2-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
 <1362486244-24593-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201303051938.29660.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Shawn Guo wrote:
>                                  <&clks 150>, <&clks 149>;
>                         clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
>                                       "gpmi_bch_apb", "per1_bch";
> +                       dmas = <&dma_apbh 0>;
> +                       dma-names = "gpmi";
>                         fsl,gpmi-dma-channel = <0>;
>                         status = "disabled";

Looks like a small bug:

In patch "[PATCH v2 07/12] mtd: gpmi: move to use generic DMA helper" you require the
dma-names property for this device to be "rx-tx", not "gpmi".

	Arnd
