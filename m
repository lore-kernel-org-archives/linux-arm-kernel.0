From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 Sep 2014 11:06:01 +0800
Subject: [PATCH v2 0/3] ARM: sun8i: Add DMA controller support
In-Reply-To: <1411010680-4481-1-git-send-email-wens@csie.org>
References: <1411010680-4481-1-git-send-email-wens@csie.org>
Message-ID: <CAGb2v65ZkBvqSjwR0bVUu0-=5-pOmydp51K6GeMnxOa4vOtCRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 11:24 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v2 of my sun8i DMA controller support series. This series
> adds support for the DMA controller found in the Allwinner A23 SoC.
> It is the same hardware as found in the A31 (sun6i) SoC. In addition
> to reduced physical channels and endpoints, the controller in the A23
> requires an undocumented register to be toggled. That seems to allow
> memory bus access.
>
> This series is based on my earlier "clk: sun6i: Unify AHB1 clock and
> fix rate calculation" series, which removes the clock muxing calls from
> the sun6i-dma driver. The default PLL6 pre-divider for AHB1 on the A23
> results in an exceedingly high clock rate for AHB1, and the system hangs.
> Also, on the A23, the dma controller happily works even when AHB1 is
> clocked from AXI.
>
>
> Patch 1 changes the channel count macros into runtime data binded to
> the DT compatible strings. It also gets rid of some hardcoded values
> in the interrupt handler.
>
> Patch 2 adds the channel number data for the A23 (sun8i), as well as
> the undocumented register quirk.

Hi, Vinod,

Any chance we can get patches 1 & 2 merged? You've already merged the
prerequisite patch "dmaengine: sun6i: Remove obsolete clk muxing code"
a few days ago, and patch 3 is already in arm-soc.

Thanks!
ChenYu

> Patch 3 adds the dma controller node, and related dma resources, to the
> DT.
>
> Changes since v1:
>
>   - Added Maxime's Acked-by for patch 1
>   - Added macros for sun8i specific dma gating registers, and updated
>     comment to reflect its usage.
>
>
> Cheers
> ChenYu
>
>
> Chen-Yu Tsai (3):
>   dmaengine: sun6i: support parameterized compatible strings
>   dmaengine: sun6i: Add support for Allwinner A23 (sun8i) variant
>   ARM: dts: sun8i: Add DMA controller node
>
>  .../devicetree/bindings/dma/sun6i-dma.txt          |   2 +-
>  arch/arm/boot/dts/sun8i-a23.dtsi                   |  19 ++++
>  drivers/dma/Kconfig                                |   4 +-
>  drivers/dma/sun6i-dma.c                            | 123 +++++++++++++++------
>  4 files changed, 110 insertions(+), 38 deletions(-)
>
> --
> 2.1.0
>
