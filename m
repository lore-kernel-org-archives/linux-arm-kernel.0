From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 20 May 2014 15:59:41 +0200
Subject: [PATCH v3 00/11] ARM: STi: Add Clock driver support STiH415 &
 STiH416
In-Reply-To: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <537B5FCD.8040704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the series:

Acked-by: Maxime Coquelin <maixme.coquelin@st.com>

Thanks,
Maxime

On 05/20/2014 03:22 PM, Gabriel FERNANDEZ wrote:
> Changes in v2:
>   - cosmetic changes (lower case of clock nodes and names)
>
> Changes in v2:
>   - move stih415-clks.h & stih416-clks.h to include/dt-bindings/clock/
>   - add clk_ignore_unused to bootargs. Interconnect clocks are not yet
>     managed at the init, then we have to start the kernel with
>     clk_ignore_unused.
>
> The goal of this series is to add DT definition for STiH415
> and STiH416 SoCs on B2000 and B2020 boards.
>
> Gabriel Fernandez (11):
>    ARM: STi: DT: STiH41x: Rename CLK_SYSIN into clk_sysin
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen A0/1/10/11/12
>    ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0 fixed clock
>    ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
>      fixed clocks
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen B/C/D/E/F
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen A9/DDR/GPU
>    ARM: STi: DT: STiH415: 415 DT Entry for clockgen A0/1/10/11/12
>    ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock
>    ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
>      fixed clocks
>    ARM: STi: DT: STiH415: 415 DT Entry for clockgen A9
>    ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs
>
>   arch/arm/boot/dts/stih415-clock.dtsi     | 519 +++++++++++++++++++++-
>   arch/arm/boot/dts/stih415.dtsi           |  18 +-
>   arch/arm/boot/dts/stih416-clock.dtsi     | 735 ++++++++++++++++++++++++++++++-
>   arch/arm/boot/dts/stih416.dtsi           |  18 +-
>   arch/arm/boot/dts/stih41x-b2000.dtsi     |   2 +-
>   arch/arm/boot/dts/stih41x-b2020.dtsi     |   2 +-
>   include/dt-bindings/clock/stih415-clks.h |  15 +
>   include/dt-bindings/clock/stih416-clks.h |  15 +
>   8 files changed, 1268 insertions(+), 56 deletions(-)
>   create mode 100644 include/dt-bindings/clock/stih415-clks.h
>   create mode 100644 include/dt-bindings/clock/stih416-clks.h
>
