From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 16 Oct 2013 16:54:36 +0200
Subject: [PATCH v5 0/4] Add I2C support to ST SoCs
In-Reply-To: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <525EA8AC.4010607@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 10/14/2013 02:46 PM, Maxime COQUELIN wrote:
> The goal of this series is to add I2C support to ST SoCs.
> The DT definition is added for STiH415 and STiH416 SoCs on
> B2000 and B2020 boards.
>
> The series has been tested working on STiH416-B2020 board.
> It applies on top of v3.12-rc5.
>
> Changes since v4:
>    - Fixed IRQ flags to level high triggering as reported by Stephen Gallimore
>    - Revert back to generic DT properties for Anti-glitch filtering. Their DT
>      binding documentation will be updated when i2c DT binding docuementation
>      will be created (In Wolfram's ToDo list)
Do you agree with this approach?

Did you had time to review the driver?

Regards,
Maxime

> ...
>
> Maxime Coquelin (4):
>    i2c: busses: i2c-st: Add ST I2C controller
>    ARM: STi: Supply I2C configuration to STiH416 SoC
>    ARM: STi: Supply I2C configuration to STiH415 SoC
>    ARM: STi: Add I2C config to B2000 and B2020 boards
>
>   Documentation/devicetree/bindings/i2c/i2c-st.txt |   38 +
>   arch/arm/boot/dts/stih415-pinctrl.dtsi           |   36 +
>   arch/arm/boot/dts/stih415.dtsi                   |   53 ++
>   arch/arm/boot/dts/stih416-pinctrl.dtsi           |   35 +
>   arch/arm/boot/dts/stih416.dtsi                   |   53 ++
>   arch/arm/boot/dts/stih41x-b2000.dtsi             |    9 +
>   arch/arm/boot/dts/stih41x-b2020.dtsi             |   22 +
>   drivers/i2c/busses/Kconfig                       |   10 +
>   drivers/i2c/busses/Makefile                      |    1 +
>   drivers/i2c/busses/i2c-st.c                      |  867 ++++++++++++++++++++++
>   10 files changed, 1124 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
>   create mode 100644 drivers/i2c/busses/i2c-st.c
>
