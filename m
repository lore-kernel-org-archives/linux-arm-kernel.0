From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 7 Mar 2018 10:57:21 +0000
Subject: [PATCH v2 0/6] Add mmc support for STM32F7 boards
In-Reply-To: <f006750d-1fa9-4bbf-8f4d-32abee21cadd@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
 <20180307083538.vicxhbu72jex7zi6@dell>
 <f006750d-1fa9-4bbf-8f4d-32abee21cadd@st.com>
Message-ID: <20180307105721.yxrun3xztrgun4me@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Mar 2018, Patrice CHOTARD wrote:

> Hi Lee
> 
> On 03/07/2018 09:35 AM, Lee Jones wrote:
> > On Mon, 05 Mar 2018, Alexandre Torgue wrote:
> > 
> >> Hi Patrice,
> >>
> >> On 03/01/2018 11:53 AM, patrice.chotard at st.com wrote:
> >>> From: Patrice Chotard <patrice.chotard@st.com>
> >>>
> >>> This series adds :
> >>>    _ SDIO pins definition for STM32F7 SoCs family
> >>>    _ add sdio1 DT entry for STM32F746 Discovery board
> >>>    _ add sdio1 DT entry for STM32F746 Evaluation board
> >>>    _ add sdio1 DT entry for STM32F769 Discovery board
> >>>    _ add SDMMC2 entry in stm32f7-rcc.h
> >>>    _ replace sdio2 hard coded value in stm32f746.dtsi
> >>>
> >>> v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a
> >>>         and update board dts files accordingly.
> >>>
> >>>
> >>> Patrice Chotard (6):
> >>>     ARM: dts: stm32: Add sdio pins definition for stm32f7
> >>>     ARM: dts: stm32: Enable sdio1 for stm32f746-disco
> >>>     ARM: dts: stm32: Enable sdio1 for stm32f746-eval
> >>>     ARM: dts: stm32: Enable sdio1 for stm32f769-disco
> >>>     dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
> >>>     ARM: dts: stm32: Fix sdio2 rcc hard coded value
> >>>
> >>>    arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
> >>>    arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
> >>>    arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
> >>>    arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
> >>>    arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
> >>>    include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
> >>>    6 files changed, 119 insertions(+), 1 deletion(-)
> >>>
> >> Series applied on stm32-next.
> > 
> > Even the MFD patch?
> > 
> 
> Yes, the MFD part has been taken by Alex.

You should really wait for all of the appropriate Acks.  This helps to
avoid possible merge conflicts when Linus starts pulling branches
during the merge-window.

As it happens, I do not think Alex's tree and MFD will conflict this
time, but it's something to bear in mind in the future.

Please add my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

... to the patch.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
