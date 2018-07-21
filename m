From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 21 Jul 2018 10:37:49 +0800
Subject: [GIT PULL 4/6] i.MX device tree updates for 4.19
In-Reply-To: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.19

for you to fetch changes up to 33a8d5a595dd0f9b7f801c1cddb26dc05bc33a73:

  ARM: dts: imx7d: remove "operating-points" property for cpu1 (2018-07-21 09:09:58 +0800)

----------------------------------------------------------------
i.MX device tree update for 4.19:
 - Add device tree support for i.MX6SLL SoC.
 - New board support: ConnectCore 6UL System-On-Module and SBC Express;
   ZII SCU2 Mezz, SCU3 ESB, SSMB SPU3 and CFU1 board; i.MX6SLL EVK
   board; Engicam i.CoreM6 1.5 Quad/Dual MIPI; LogicPD MX31Lite board;
   i.MX53 HSC/DDC boards from K+P.
 - Remove fake regulator bus container node and enable USB OTG support
   for i.MX6 wandboard and riotboard.
 - Populate RAVE SP EEPROM, backlight, power button and watchdog devices
   for ZII boards.
 - Add cooling-cells for cpufreq cooling device, and add OPP properties
   for all CPUs.
 - A series from Anson Huang to enable LCD panel and backlight support
   for imx6sll-evk board.
 - Make pfuze100 sw4 regulator always-on for for a few Freescale/NXP
   development boards, because the regulator is critical there and
   cannot be turned off.
 - Add more device support for i.MX5: AIPSTZ, SAHARA Crypto, M4IF,
   Tigerp, PMU, CodaHx4 VPU.
 - Enable PMU secure-reg-access for imx51-babbage, imx51-zii-rdu1 and
   imx53-ppd board.
 - Switch more device tree license to use SPDX identifier.
 - Switch to use OF graph to describe the display for imx7d-nitrogen7.
 - Add chosen/stdout-path for more boards, so that earlycon can be
   enabled more easily on kernel cmdline.
 - Convert GPC to new device tree bindings and add Vivante gpu nodes
   for i.MX6SL SoC.
 - Add more device support for imx6dl-mamoj board: parallel display,
   WiFi and USB.
 - A series from Stefan Agner to update i.MX6 apalis/colibri boards on
   various aspects: SD/MMC card detection, regulators, etc.

----------------------------------------------------------------
Alex Gonzalez (2):
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express

Alexander Kurz (6):
      ARM: dts: imx6qdl-wandboard: remove regulators bus node
      ARM: dts: imx6dl-riotboard: remove regulators bus node
      ARM: dts: imx6qdl-wandboard: enable USB OTG
      ARM: dts: imx6dl-riotboard: fix OTG regulator polarity
      ARM: dts: imx50: fix KPP pin definition typos
      ARM: dts: imx50: remove non-existent USB instances

Andrey Smirnov (13):
      ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
      ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight node
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP power button node
      ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
      ARM: dts: imx: Add ZII SCU2 Mezz board
      ARM: dts: imx: Add ZII SCU3 ESB
      ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
      ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string
      ARM: dts: vf610: Add ZII SSMB SPU3 board
      ARM: dts: vf610: Add ZII CFU1 board
      ARM: dts: vf610-zii-ssmb-spu3: Fix W=1 level warnings

Anson Huang (13):
      ARM: dts: imx: add cooling-cells for cpufreq cooling device
      ARM: dts: imx6sll: declare src module to be compatible to imx51's src
      ARM: dts: imx6sll-evk: enable usdhc3 slot
      ARM: dts: imx6: correct anatop regulators range
      ARM: dts: imx6sx: add ocram_s support
      ARM: dts: imx6sll-evk: enable PWM1 for backlight driver
      ARM: dts: imx6sll-evk: correct lcd regulator GPIO pin
      ARM: dts: imx6sll-evk: enable SEIKO 43WVF1G lcdif panel
      ARM: dts: imx6sl-evk: add missing GPIO iomux setting
      ARM: dts: imx6qdl-sabresd: make pfuze100 sw4 always on
      ARM: dts: imx6sx-sdb-reva: make pfuze100 sw4 always on
      ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
      ARM: dts: imx7d: remove "operating-points" property for cpu1

Bai Ping (2):
      ARM: dts: imx: Add basic dtsi file for imx6sll
      ARM: dts: imx: Add basic dts support for imx6sll EVK board

Daniel Mack (1):
      ARM: dts: imx6: make edt-ft5x06 a wakeup source for imx6 boards

Emmanuel Vadot (1):
      ARM: dts: imx6: RIoTboard Add chosen stdout-path property

Fabio Estevam (18):
      ARM: dts: imx51: Add aipstz nodes
      ARM: dts: imx51: Add sahara crypto support
      ARM: dts: imx6ull: Switch to SPDX identifier
      ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
      ARM: dts: imx6sll: Fix the SPDX notation for header file
      ARM: dts: imx51: Fix USB PHY duplicate unit-address
      ARM: dts: imx: Remove optional 'fsl,sec-era' property
      dt-bindings: freescale: Add bindings for the M4IF module
      ARM: dts: imx51: Add M4IF support
      dt-bindings: freescale: Add bindings for the tigerp module
      ARM: dts: imx51: Add PMU support
      ARM: dts: imx51: Add tigerp support
      ARM: dts: imx53: Add tigerp support
      ARM: dts: imx53: Add a label for the PMU node
      ARM: dts: imx51-zii-rdu1: Disable internal watchdog
      ARM: dts: imx51-babbage: Enable secure-reg-access
      ARM: dts: imx51-zii-rdu1: Enable secure-reg-access
      ARM: dts: imx6ul-pico-hobbit: Do not hardcode the memory size

Gary Bisson (3):
      ARM: dts: imx: Switch Boundary Devices boards to SPDX identifier
      ARM: dts: imx7d-nitrogen7: use OF graph to describe the display
      ARM: dts: imx6sx-nitrogen6sx: remove obsolete display configuration

Jagan Teki (5):
      ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support
      ARM: dts: imx6q-icore-mipi: Add OV5640 Camera sensor
      ARM: dts: imx6qdl-icore: Fix wrong reg_2p5 regulator node name
      ARM: dts: imx6dl-mamoj: Add parallel display support
      ARM: dts: imx6dl-mamoj: Add Wifi support

Leonard Crestez (6):
      ARM: dts: imx6qdl-sabreauto: Add sensors
      ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
      ARM: dts: imx7d-sdb: Restore pwm backlight support
      ARM: dts: imx: Add missing chosen/stdout-path
      ARM: dts: imx6sl: Convert gpc to new bindings
      ARM: dts: imx6sl: Add vivante gpu nodes

Lucas Stach (1):
      ARM: dts: imx6: RDU2: correct touchscreen axis inversion

Lukasz Majewski (1):
      ARM: dts: imx53: Add support for imx53 HSC/DDC boards from K+P

Michael Trimarchi (1):
      ARM: dts: imx6dl-mamoj: Add usb host and device support

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: correct touchscreen axis inversion

Nikita Yushchenko (1):
      ARM: dts: imx51-zii-rdu1: add rave-sp subdevices

Philipp Zabel (1):
      ARM: dts: imx51: add CodaHx4 VPU

Robin Gong (1):
      ARM: dts: imx6sl-evk: make pfuze100 sw4 always on

Sebastian Reichel (3):
      ARM: dts: imx53-ppd: Add fixed-regulator information
      ARM: dts: imx53-ppd: Rename usbphy nodes
      ARM: dts: imx53-ppd: Enable secure-reg-access

Stefan Agner (11):
      ARM: dts: imx6qdl-colibri: mux SD/MMC card detect explicitly
      ARM: dts: imx6qdl-colibri: move card detect to module device tree
      ARM: dts: imx6qdl-colibri: use pull-down on wake-up pin
      ARM: dts: imx6q-apalis: add chosen node
      ARM: dts: imx6q-apalis-eval: add carrier board 3.3V supply
      ARM: dts: imx6qdl-apalis/-colibri: prevent 1.8V modes
      ARM: dts: imx6qdl-apalis/-colibri: disable read-only switch
      ARM: dts: imx6qdl-apalis/-colibri: remove 1.8V regulator
      ARM: dts: imx6qdl-apalis/-colibri: fix on-module regulators
      ARM: dts: imx6qdl-apalis/-colibri: assign VDDD to SGTL5000
      ARM: dts: imx6qdl-apalis/-colibri: remove unused pinctrl groups

S?bastien Szymanski (1):
      ARM: dts: imx6ull: add operating points

Viresh Kumar (2):
      ARM: dts: ls1021a: Add missing cooling device properties for CPUs
      ARM: dts: imx: Add missing OPP properties for CPUs

Vladimir Zapolskiy (2):
      ARM: dts: imx31: add device tree description of basic controllers
      ARM: dts: imx31: add LogicPD MX31Lite board description

 .../devicetree/bindings/arm/freescale/m4if.txt     |  12 +
 .../devicetree/bindings/arm/freescale/tigerp.txt   |  12 +
 Documentation/devicetree/bindings/arm/fsl.txt      |   4 +
 arch/arm/boot/dts/Makefile                         |  17 +-
 arch/arm/boot/dts/imx31-lite.dts                   | 177 +++++
 arch/arm/boot/dts/imx31.dtsi                       | 223 ++++++
 arch/arm/boot/dts/imx50-evk.dts                    |   8 -
 arch/arm/boot/dts/imx50-pinfunc.h                  |   4 +-
 arch/arm/boot/dts/imx50.dtsi                       |  18 -
 arch/arm/boot/dts/imx51-babbage.dts                |  29 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  21 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  75 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts          | 448 +++++++++++
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts           | 467 +++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |  61 +-
 arch/arm/boot/dts/imx53-kp-ddc.dts                 | 146 ++++
 arch/arm/boot/dts/imx53-kp-hsc.dts                 |  52 ++
 arch/arm/boot/dts/imx53-kp.dtsi                    | 189 +++++
 arch/arm/boot/dts/imx53-ppd.dts                    |  40 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   9 +-
 arch/arm/boot/dts/imx53.dtsi                       |   7 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   3 -
 arch/arm/boot/dts/imx6dl-icore-mipi.dts            |  25 +
 arch/arm/boot/dts/imx6dl-mamoj.dts                 | 265 +++++++
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  38 +-
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |  38 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  54 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |  24 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |  16 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |   4 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   4 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  66 ++
 arch/arm/boot/dts/imx6q-icore-mipi.dts             |   8 +
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  38 +-
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts         |  38 +-
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |  38 +-
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     |   1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  88 ++-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  75 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |  78 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  49 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |  39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  39 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  25 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   1 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  59 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |  30 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   1 -
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts         |  39 +-
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts        |  39 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |  13 +
 arch/arm/boot/dts/imx6sl.dtsi                      |  64 +-
 arch/arm/boot/dts/imx6sll-evk.dts                  | 463 +++++++++++
 arch/arm/boot/dts/imx6sll-pinfunc.h                | 880 +++++++++++++++++++++
 arch/arm/boot/dts/imx6sll.dtsi                     | 780 ++++++++++++++++++
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           | 109 +--
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |   1 +
 arch/arm/boot/dts/imx6sx.dtsi                      |  16 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts    | 200 +++++
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi          | 201 +++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |   3 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   1 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |  14 -
 arch/arm/boot/dts/imx6ull.dtsi                     |  62 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |  87 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |  33 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   1 +
 arch/arm/boot/dts/imx7s.dtsi                       |   1 -
 arch/arm/boot/dts/ls1021a.dtsi                     |   1 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts               | 305 +++++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts          | 341 ++++++++
 73 files changed, 5967 insertions(+), 928 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/m4if.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/tigerp.txt
 create mode 100644 arch/arm/boot/dts/imx31-lite.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu3-esb.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp-ddc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp-hsc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6sll-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6sll.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-zii-cfu1.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
