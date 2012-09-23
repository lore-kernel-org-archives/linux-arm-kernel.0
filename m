From: olof@lixom.net (Olof Johansson)
Date: Sat, 22 Sep 2012 22:25:20 -0700
Subject: [GIT PULL] Patches surrounding DT development due for ARM-SoC
In-Reply-To: <20120920113356.GA17429@gmail.com>
References: <20120920113356.GA17429@gmail.com>
Message-ID: <CAK-hmcQn4dsb5_JLASZ8fZdBL-3n6jEt6RxbJxyDfyGegAbKTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

In the future, please send pull requests to arm at kernel.org for arm-soc. Or,
if you prefer individual email addresses instead of the alias, please send
them to olof at lixom.net and not my gmail address -- chances are I won't see
them or forget about them, which is what happened here. :-)

Nicely contained and no merge conflicts makes me happy right now. Pulled
into ux500/dt and next/dt.


Thanks!

-Olof

On Thu, Sep 20, 2012 at 4:33 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The following changes since commit
> 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
>
>   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git for-arm-soc-next
>
> for you to fetch changes up to c164fa62b93782165f12c0e8366f7b46507edb4d:
>
>   ARM: ux500: Fix SSP register address format (2012-09-20 12:32:47 +0200)
>
> ----------------------------------------------------------------
> Lee Jones (39):
>       ASoC: Ux500: Move MSP pinctrl setup into the MSP driver
>       ASoC: Ux500: Enable MOP500 driver for Device Tree
>       ASoC: Ux500: Enable ux500 MSP driver for Device Tree
>       ASoC: codecs: Enable AB8500 CODEC for Device Tree
>       ASoC: Ux500: Minor coding layout changes
>       Documentation: Define the MOP500 Audio Machine Driver Device Tree
> bindings
>       Documentation: Define the MSP Driver Device Tree bindings
>       ARM: ux500: Rename db8500.dtsi to dbx5x0.dtsi to encompass the
> u9500, u8540 and u9540
>       ARM: ux500: Clean-up temporary Device Tree enablement helpers
>       ARM: ux500: Pass PMU platform data due for Perf though AUXDATA
>       Documentation: Add the AB8500 CODEC device to the MFD AB8500 doc
>       of/irq: Create stub for of_irq_find_parent when !CONFIG_OF
>       ARM: ux500: Identify the PRCMU as an interrupt controller
>       ARM: ux500: Force AB8500 to use the GIC as its interrupt controller
>       Revert "input: ab8500-ponkey: Create AB8500 domain IRQ mapping"
>       ARM: ux500: Remove unused snowball_of_platform_devs struct
>       ARM: ux500: Match Power-On-Key MFD and DTS compatible strings
>       drivers/rtc/rtc-ab8500.c: Revoke Device Tree enablement
>       ARM: ux500: Add i2c configurations to the Device Tree for DB8500
> based devices
>       ARM: ux500: Add skeleton Device Tree for the HREF reference board
>       ARM: ux500: Add UART support to the HREF Device Tree
>       ARM: ux500: Pass SDI DMA information though AUX_DATA to MMCI
>       ARM: ux500: Clean-up MSP platform code
>       ARM: ux500: Add AB8500 CODEC node to DB8500 Device Tree
>       ARM: ux500: Fork MSP platform registration for step-by-step DT
> enablement
>       ARM: ux500: Pass MSP DMA platform data though AUXDATA
>       ARM: ux500: Stop registering the MOP500 Audio driver from platform
> code
>       ARM: ux500: Remove platform registration of MSP devices
>       ARM: ux500: Rename MSP board file to something more meaningful
>       ARM: ux500: Add nodes for the MSP into Device Tree
>       ARM: ux500: Add all encompassing sound node to the Snowball Device
> Tree
>       ARM: ux500: Stop registering Audio devices for HREF when DT is
> enabled
>       ARM: ux500: Stop registering I2C sub-devices for HREF when DT is
> enabled
>       ARM: ux500: Add all known I2C sub-device nodes to the HREF DT
>       ARM: ux500: Add nodes for the MSP into the HREF Device Tree
>       ARM: ux500: Add all encompassing sound node to the HREF Device Tree
>       ARM: ux500: Remove redundant #gpio-cell properties from Snowball DT
>       ARM: ux500: Apply tc3589x's GPIO/IRQ properties to HREF's DT
>       ARM: ux500: Fix SSP register address format
>
>  Documentation/devicetree/bindings/mfd/ab8500.txt   |   15 +++
>  .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++++++++
>  .../devicetree/bindings/sound/ux500-msp.txt        |   43 +++++++++
>  arch/arm/boot/dts/{db8500.dtsi => dbx5x0.dtsi}     |   71 ++++++++++++--
>  arch/arm/boot/dts/hrefv60plus.dts                  |   95
> ++++++++++++++++++
>  arch/arm/boot/dts/snowball.dts                     |   19 +++-
>  arch/arm/mach-ux500/Makefile                       |    2 +-
>  .../{board-mop500-msp.c => board-mop500-audio.c}   |  102
> +++-----------------
>  arch/arm/mach-ux500/board-mop500-msp.h             |   14 ---
>  arch/arm/mach-ux500/board-mop500-sdi.c             |    4 +-
>  arch/arm/mach-ux500/board-mop500.c                 |   39 ++++----
>  arch/arm/mach-ux500/board-mop500.h                 |   11 +++
>  arch/arm/mach-ux500/cpu-db8500.c                   |   10 +-
>  arch/arm/mach-ux500/include/mach/msp.h             |    2 -
>  drivers/input/misc/ab8500-ponkey.c                 |    4 +-
>  drivers/rtc/rtc-ab8500.c                           |    6 --
>  include/linux/mfd/abx500/ab8500-codec.h            |    6 +-
>  include/linux/of_irq.h                             |    5 +
>  sound/soc/codecs/ab8500-codec.c                    |   81 ++++++++++++++++
>  sound/soc/ux500/mop500.c                           |   47 ++++++++-
>  sound/soc/ux500/ux500_msp_dai.c                    |    6 ++
>  sound/soc/ux500/ux500_msp_i2s.c                    |   89
> +++++++++++++----
>  sound/soc/ux500/ux500_msp_i2s.h                    |    8 +-
>  23 files changed, 538 insertions(+), 180 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/sound/ux500-mop500.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
>  rename arch/arm/boot/dts/{db8500.dtsi => dbx5x0.dtsi} (88%)
>  create mode 100644 arch/arm/boot/dts/hrefv60plus.dts
>  rename arch/arm/mach-ux500/{board-mop500-msp.c => board-mop500-audio.c}
> (66%)
>  delete mode 100644 arch/arm/mach-ux500/board-mop500-msp.h
>
> --
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120922/904e49f6/attachment-0001.html>
