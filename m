From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:21:20 -0600
Subject: [PATCH 1/9] ARM: dts: add generic DMA DT binding for tegra apbdma
In-Reply-To: <1374639002-16753-2-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-2-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2CC30.5090200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Stripping the Cc list a lot, but adding in the DT binding maintainers)

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> All Tegra device drivers will soon move to generic DMA device tree bindings.
> Add the required properties to the Tegra DT files to support that. The legacy
> property nvidia,dma-request-selector will be removed after all drivers have
> been converted, in order to maintain bisectability.
> 
> Changes:
>  - Add '#dma-cells' for apbdma nodes
>  - And properties 'dmas' and 'dma-names' for apbdma client nodes
>  - update apbdma DT binding doc
> 
> Signed-off-by: Richard Zhao <rizhao@nvidia.com>
> ---
>  .../devicetree/bindings/dma/tegra20-apbdma.txt     |  1 +
>  arch/arm/boot/dts/tegra114.dtsi                    | 27 ++++++++++++++++++++++
>  arch/arm/boot/dts/tegra20.dtsi                     | 27 ++++++++++++++++++++++
>  arch/arm/boot/dts/tegra30.dtsi                     | 25 ++++++++++++++++++++

This patch should be split differently.

Patch 1 in the series should include the binding document change and the
associated DMA driver change, which will support both the old and new
bindings.

Patch 2 should contain the *.dtsi changes.
