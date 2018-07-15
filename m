From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 15 Jul 2018 19:53:45 +0530
Subject: [PATCH v4 0/5] Add clock driver for Actions S700 SoC
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Message-ID: <20180715142345.GB9980@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

On Sun, Jul 15, 2018 at 02:31:40PM +0200, Saravanan Sekar wrote:
> Changelog v4:
> - dt-bindings use absolute numbering for clocks
> - Patch re-oredering
> 
> Changelog v3:
> - Splitted uart clock DTS changes into separate patch
> - Splitted REGMAP Kconfig selection into separate patch
> - General naming convention as "Actions Semi" in dt-binding documentation
> - Patch re-oredering
> - Cleanup and fixed review findings
> 
> Changelog v2:
> Fixed 0 day compilation warning
> Modified existing dts Actions S900 clock bindings common to Actions
> Soc family
> 

Usually Changelog comes at the end of cover letter.

> This patchset adds clock support for Actions Semi OWL series S700 SoC
> with relevant clock bindings and device tree info. 
> 

Nit: Since we agreed to use the family name as Owl everywhere, the above
instance should be changed accordingly.

> Changed the UART clock using CMU instance and changes are tested in
> cubieboard7
> 
> Thanks and regards,
> Saravanan,
> Parthiban
> 
> *** BLURB HERE ***

Please remove the above line.

Thanks,
Mani

> 
> Saravanan Sekar (5):
>   clk: actions: Add REGMAP as dependency
>   dt-bindings: clock: Add S700 support for Actions Semi Soc's
>   clk: actions: Add S700 SoC clock support
>   arm64: dts: actions: Enable clock controller for S700
>   arm64: dts: actions: Set UART clock reference from CMU
> 
>  ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
>  .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
>  arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
>  drivers/clk/actions/Kconfig                   |  14 +
>  drivers/clk/actions/Makefile                  |   1 +
>  drivers/clk/actions/owl-s700.c                | 610 ++++++++++++++++++
>  include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
>  7 files changed, 769 insertions(+), 16 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
>  create mode 100644 drivers/clk/actions/owl-s700.c
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> 
> -- 
> 2.18.0
> 
