From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Apr 2013 11:08:03 +0800
Subject: [GIT PULL 4/4] ARM: imx: device tree changes for 3.10
In-Reply-To: <1365520775-28478-4-git-send-email-shawn.guo@linaro.org>
References: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
 <1365520775-28478-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130416030801.GA3293@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

On Tue, Apr 09, 2013 at 11:19:35PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> It's based on imx-cleanup-3.10 and Stephen Warren's "[GIT PULL] dt:
> run C pre-processor on *.dts, create some standard headers" to resolve
> dependency and conflicts.
> 
> Shawn
> 
> The following changes since commit 8b9ad9f67d094efd2c2765d82cc1866bee9052c2:
> 
>   Merge remote-tracking branch 'swarren/for-3.10/dtc-cpp-chroot-std-headers' into imx/dt (2013-04-09 22:52:42 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.10
> 
> for you to fetch changes up to 4b23185ff5e1c2ada2845002a034e8840ab98b63:
> 
>   ARM: dts: imx6dl-wandboard: Add USB Host support (2013-04-09 22:53:40 +0800)
> 
> ----------------------------------------------------------------
> The imx device tree changes for 3.10:
> 
> * The huge diff stat is introduced by the pinctrl changes.  With DTC
>   macro support ready, we're moving those huge mount of data about pins
>   out of pinctrl driver.
> * Device tree source updates for GPI, LDB, SRC, cpufreq-cpu0.
> * Initial imx6dl device tree support
> * Board level DTS changes for some imx27 and imx51 platforms.
> 
> ----------------------------------------------------------------
> Alexander Shiyan (2):
>       ARM: dts: Add NFC support for i.MX27 Phytec PCM038 module
>       ARM: dts: Add missing imx27-phytec-phycore dtb target
> 
> Dirk Behme (1):
>       ARM: dts: imx6q: add PMU
> 
> Fabio Estevam (3):
>       ARM: mx27: Replace clk_register_clkdev with clock DT lookup
>       ARM: dts: Add initial support for Wandboard Dual-Lite
>       ARM: dts: imx6dl-wandboard: Add USB Host support
> 
> Gwenhael Goavec-Merou (5):
>       ARM: imx: Add support for the Armadeus Systems APF51Dev docking board
>       ARM: imx51: Add pinctrl for ecspi2
>       ARM: imx51: Add a second pinctrl group for i2c2
>       ARM: imx: apf51dev: add ecspi1, ecspi2 and i2c2 support
>       ARM: imx: Add support for the Armadeus Systems APF27Dev docking board
> 
> Marek Vasut (1):
>       ARM: dts: imx53: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
> 
> Markus Pargmann (3):
>       ARM: imx27 DT init cpufreq-cpu0 device
>       ARM: imx5 DT init cpufreq-cpu0 device
>       ARM: dts: imx51 cpu node
> 
> Pavel Machek (1):
>       ARM: dts: MicroSys sbc6x support (i.MX6)
> 
> Peter Chen (1):
>       ARM: dts: imx6q-sabresd: Add USB support
> 
> Philipp Zabel (6):
>       ARM i.MX5: Move IPU clock lookups into device tree
>       ARM i.MX53: Add IOMUXC GPR to device tree
>       ARM i.MX53: Add LDB device to device tree
>       ARM i.MX6q: Link system reset controller (SRC) to IPU in DT
>       ARM i.MX5: Add system reset controller (SRC) to i.MX51 and i.MX53 device tree
>       ARM i.MX5: Add System Reset Controller (SRC) support for i.MX51 and i.MX53
> 
> Sascha Hauer (8):
>       ARM: i.MX: Add GPT devicetree Documentation
>       ARM: i.MX27: Add GPT devicetree nodes
>       ARM: i.MX31: Add GPT devicetree node
>       ARM: i.MX51: Add GPT devicetree node
>       ARM: i.MX53: Add GPT devicetree node
>       ARM: i.MX6: Add clocks to GPT devicetree node
>       ARM: i.MX27: Add clocks to GPT devicetree nodes
>       ARM: i.MX51: Add PATA support
> 
> Sean Cross (3):
>       ARM: dts: imx6q: Add pinctrl for ecspi3
>       ARM: dts: imx6q: Add pinctrl for i2c2 and i2c3
>       ARM: dts: imx6q: Add pinctrl for audmix on AUD3
> 
> Shawn Guo (7):
>       ARM: imx: use #include for all device trees
>       pinctrl: imx: move hard-coding data into device tree
>       pinctrl: add pinctrl driver for imx6dl
>       pinctrl: add pinctrl driver for imx6sl
>       ARM: dts: imx: make sabreauto and sabresd common
>       ARM: dts: imx: add initial imx6dl-sabresd support
>       ARM: dts: imx: add initial imx6dl-sabreauto support
> 
> Steffen Trumtrar (1):
>       ARM i.MX6q: Add LDB device to device tree
> 
>  .../devicetree/bindings/clock/imx27-clock.txt      |  117 +
>  .../bindings/pinctrl/fsl,imx-pinctrl.txt           |    6 +-
>  .../bindings/pinctrl/fsl,imx35-pinctrl.txt         |  955 +-------
>  .../bindings/pinctrl/fsl,imx51-pinctrl.txt         |  759 +------
>  .../bindings/pinctrl/fsl,imx53-pinctrl.txt         | 1174 +---------
>  .../bindings/pinctrl/fsl,imx6dl-pinctrl.txt        |   38 +
>  .../bindings/pinctrl/fsl,imx6q-pinctrl.txt         | 1596 +-------------
>  .../bindings/pinctrl/fsl,imx6sl-pinctrl.txt        |   39 +
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       |   18 +
>  arch/arm/boot/dts/Makefile                         |    9 +-
>  arch/arm/boot/dts/imx25-karo-tx25.dts              |    2 +-
>  arch/arm/boot/dts/imx25-pdk.dts                    |    2 +-
>  arch/arm/boot/dts/imx25.dtsi                       |    2 +-
>  arch/arm/boot/dts/imx27-apf27.dts                  |    2 +-
>  arch/arm/boot/dts/imx27-apf27dev.dts               |   60 +
>  arch/arm/boot/dts/imx27-pdk.dts                    |    2 +-
>  arch/arm/boot/dts/imx27-phytec-phycore.dts         |    8 +-
>  arch/arm/boot/dts/imx27.dtsi                       |   82 +-
>  arch/arm/boot/dts/imx31-bug.dts                    |    2 +-
>  arch/arm/boot/dts/imx31.dtsi                       |   18 +-
>  arch/arm/boot/dts/imx35-pinfunc.h                  |  970 +++++++++
>  arch/arm/boot/dts/imx51-apf51.dts                  |    2 +-
>  arch/arm/boot/dts/imx51-apf51dev.dts               |   97 +
>  arch/arm/boot/dts/imx51-babbage.dts                |   16 +-
>  arch/arm/boot/dts/imx51-pinfunc.h                  |  773 +++++++
>  arch/arm/boot/dts/imx51.dtsi                       |  343 +--
>  arch/arm/boot/dts/imx53-ard.dts                    |   70 +-
>  arch/arm/boot/dts/imx53-evk.dts                    |   18 +-
>  arch/arm/boot/dts/imx53-mba53.dts                  |   82 +-
>  arch/arm/boot/dts/imx53-pinfunc.h                  | 1189 ++++++++++
>  arch/arm/boot/dts/imx53-qsb.dts                    |   22 +-
>  arch/arm/boot/dts/imx53-smd.dts                    |   16 +-
>  arch/arm/boot/dts/imx53-tqma53.dtsi                |   32 +-
>  arch/arm/boot/dts/imx53.dtsi                       |  256 ++-
>  arch/arm/boot/dts/imx6dl-pinfunc.h                 | 1085 +++++++++
>  arch/arm/boot/dts/imx6dl-sabreauto.dts             |   31 +
>  arch/arm/boot/dts/imx6dl-sabresd.dts               |   35 +
>  arch/arm/boot/dts/imx6dl-wandboard.dts             |   44 +
>  arch/arm/boot/dts/imx6dl.dtsi                      |  125 +-
>  arch/arm/boot/dts/imx6q-arm2.dts                   |    8 +-
>  arch/arm/boot/dts/imx6q-pinfunc.h                  | 1041 +++++++++
>  arch/arm/boot/dts/imx6q-sabreauto.dts              |   33 +-
>  arch/arm/boot/dts/imx6q-sabrelite.dts              |   18 +-
>  arch/arm/boot/dts/imx6q-sabresd.dts                |   67 +-
>  arch/arm/boot/dts/imx6q-sbc6x.dts                  |   44 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  280 ++-
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   38 +
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   87 +
>  arch/arm/boot/dts/imx6qdl.dtsi                     |   33 +-
>  arch/arm/boot/dts/imx6sl-pinfunc.h                 | 1077 +++++++++
>  arch/arm/mach-imx/Kconfig                          |    2 +
>  arch/arm/mach-imx/clk-imx27.c                      |   11 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c                |    9 +-
>  arch/arm/mach-imx/imx27-dt.c                       |   22 +-
>  arch/arm/mach-imx/imx51-dt.c                       |    3 +
>  arch/arm/mach-imx/mm-imx5.c                        |    2 +
>  arch/arm/mach-imx/src.c                            |    4 +-
>  drivers/pinctrl/Kconfig                            |   12 +-
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-imx.c                      |  126 +-
>  drivers/pinctrl/pinctrl-imx.h                      |   29 +-
>  drivers/pinctrl/pinctrl-imx35.c                    | 2088 +++++++-----------
>  drivers/pinctrl/pinctrl-imx51.c                    | 1532 +++++--------
>  drivers/pinctrl/pinctrl-imx53.c                    | 1597 ++------------
>  drivers/pinctrl/pinctrl-imx6dl.c                   |  497 +++++
>  drivers/pinctrl/pinctrl-imx6q.c                    | 2301 ++------------------
>  drivers/pinctrl/pinctrl-imx6sl.c                   |  403 ++++
>  67 files changed, 10490 insertions(+), 10972 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6dl-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sl-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>  create mode 100644 arch/arm/boot/dts/imx27-apf27dev.dts
>  create mode 100644 arch/arm/boot/dts/imx35-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx51-apf51dev.dts
>  create mode 100644 arch/arm/boot/dts/imx51-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx53-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx6dl-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabresd.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-wandboard.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx6q-sbc6x.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6qdl-sabresd.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6sl-pinfunc.h
>  create mode 100644 drivers/pinctrl/pinctrl-imx6dl.c
>  create mode 100644 drivers/pinctrl/pinctrl-imx6sl.c
> 
