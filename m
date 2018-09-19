From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 19 Sep 2018 18:20:44 +0200
Subject: [PATCH v2 0/7] Introduce STMFX I2C Multi-Function eXpander
In-Reply-To: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <88843a86-3a2f-e354-21a1-c12627f54dc6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 09/19/2018 03:27 PM, Amelie Delaunay wrote:
> This series adds support for STMicroelectronics Multi-Function eXpander
> (STMFX), used on some STM32 discovery and evaluation boards.
> 
> STMFX is an STM32L152 slave controller whose firmware embeds the following
> features:
> - I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
> - resistive touchscreen controller,
> - IDD measurement.
> 
> I2C stuff and chip initialization is based on an MFD parent driver, which
> registers a pinctrl MFD child.
> 
> ---

As soon as bindings will be accepted, I'll have a look on DT patches in 
order to merge them in stm32-next branch.

regards
Alex

> Changes in v2:
> - move to MFD parent driver for i2c stuff and chip initialization
> - improve regmap configuration
> - take advantage of the use of gpio-ranges
> 
> 
> Amelie Delaunay (7):
>    dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
>    mfd: Add ST Multi-Function eXpander (STMFX) core driver
>    dt-bindings: pinctrl: document the STMFX pinctrl bindings
>    pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
>    ARM: dts: stm32: add STMFX support on stm32746g-eval
>    ARM: dts: stm32: add joystick support on stm32746g-eval
>    ARM: dts: stm32: add orange and blue leds on stm32746g-eval
> 
>   Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
>   .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
>   arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
>   drivers/mfd/Kconfig                                |  14 +
>   drivers/mfd/Makefile                               |   2 +-
>   drivers/mfd/stmfx.c                                | 626 ++++++++++++++++
>   drivers/pinctrl/Kconfig                            |  12 +
>   drivers/pinctrl/Makefile                           |   1 +
>   drivers/pinctrl/pinctrl-stmfx.c                    | 821 +++++++++++++++++++++
>   include/linux/mfd/stmfx.h                          |  27 +
>   10 files changed, 1712 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
>   create mode 100644 drivers/mfd/stmfx.c
>   create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
>   create mode 100644 include/linux/mfd/stmfx.h
> 
