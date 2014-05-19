From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 May 2014 16:47:39 +0300
Subject: [PATCH v2 0/4] clk: Add clock driver for DRA7 ATL (Audio Tracking
 Logic)
In-Reply-To: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
References: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <537A0B7B.9030704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 01:20 PM, Peter Ujfalusi wrote:
> Hi,
>
> Changes since v1:
> - ATL binding documentation and driver has been separated.
>
> Audio Tracking Logic is designed to be used by HD Radio applications to
> synchronize the audio output clocks to the baseband clock. ATL can be also
> used to track errors between two reference clocks (BWS, AWS) and generate a modulated
> clock output which averages to some desired frequency.
> In essence ATL is generating a clock to be used by an audio codec and also
> to be used by the SoC as MCLK.
>
> The series will correct atl related clock names, adds binding documentation and
> corresponding driver for the ATL and integrates the ATL clock into the clock
> tree.
>
> V1 of the ATL series:
> https://lkml.org/lkml/2014/4/2/238
>
> Regards,
> Peter

Thanks, series queued for 3.16/ti-clk-drv.

-Tero

> ---
> Peter Ujfalusi (4):
>    ARM: dts: dra7xx-clocks: Correct name for atl clkin3 clock
>    dt:/bindings: DRA7 ATL (Audio Tracking Logic) clock bindings
>    clk: ti: Driver for DRA7 ATL (Audio Tracking Logic)
>    ARM: DTS: dra7/dra7xx-clocks: ATL related changes
>
>   .../devicetree/bindings/clock/ti/dra7-atl.txt      |  97 +++++++
>   arch/arm/boot/dts/dra7.dtsi                        |  11 +
>   arch/arm/boot/dts/dra7xx-clocks.dtsi               |  38 +--
>   drivers/clk/ti/Makefile                            |   3 +-
>   drivers/clk/ti/clk-7xx.c                           |   2 +-
>   drivers/clk/ti/clk-dra7-atl.c                      | 313 +++++++++++++++++++++
>   include/dt-bindings/clk/ti-dra7-atl.h              |  40 +++
>   7 files changed, 483 insertions(+), 21 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
>   create mode 100644 drivers/clk/ti/clk-dra7-atl.c
>   create mode 100644 include/dt-bindings/clk/ti-dra7-atl.h
>
