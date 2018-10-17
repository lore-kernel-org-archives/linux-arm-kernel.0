From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 17 Oct 2018 08:57:46 +0530
Subject: [PATCH 0/4] Add clock support for Hi3670 SoC
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181017032746.GB2888@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> the HiSi common clock code. While adding clock support, let's remove the
> fixed clock for UART and source SoC clock on HiKey970 board.
> 
> This patchset has been verified on HiKey970 board.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: clk: hisilicon: Add bindings for Hi3670 clk
>   arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>   arm64: dts: hisilicon: Source SoC clock for UART6

Hi Wei,

Since the clk patches are merged, can you please take the DTS patches
through HiSi tree? I will post the pinctrl/gpio patches soon which will
depend on clk bits.

Thanks,
Mani

>   clk: hisilicon: Add clock driver for Hi3670 SoC
> 
>  .../bindings/clock/hi3670-clock.txt           |   43 +
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   48 +-
>  drivers/clk/hisilicon/Kconfig                 |    7 +
>  drivers/clk/hisilicon/Makefile                |    1 +
>  drivers/clk/hisilicon/clk-hi3670.c            | 1016 +++++++++++++++++
>  include/dt-bindings/clock/hi3670-clock.h      |  348 ++++++
>  6 files changed, 1458 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
>  create mode 100644 drivers/clk/hisilicon/clk-hi3670.c
>  create mode 100644 include/dt-bindings/clock/hi3670-clock.h
> 
> -- 
> 2.17.1
> 
