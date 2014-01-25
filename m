From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Jan 2014 00:43:02 +0800
Subject: [PATCH 0/9] ARM: dts: imx: remove the use of pingrp macros
Message-ID: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

In order to solve a pinctrl data efficiency problem, we introduced
pingrp macros [1] in this development cycle as the base of board dts
support.  The whole imx-dt-3.14 pull request has been held by Olof for
a few weeks because he wants to get a general approval from DT folks
on this change.  But unfortunately it appears that you are not fond of
this change.

I just spent the day to create a patch series against imx-dt-3.14 to
remove these pingrp macros.  May I get your nod on this quick
turn-around, so that we do not miss the merge window?

Hi Olof,

I guess we do not have to shut the door for imx-dt-3.14 if you and DT
folks are happy with this patch series, which is a quite straight
forward search&replace change?

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/

Shawn Guo (9):
  ARM: dts: imx6qdl: remove the use of pingrp macros
  ARM: dts: imx6sl: remove the use of pingrp macros
  ARM: dts: imx53: remove the use of pingrp macros
  ARM: dts: imx51: remove the use of pingrp macros
  ARM: dts: imx50: remove the use of pingrp macros
  ARM: dts: imx35: remove the use of pingrp macros
  ARM: dts: imx25: remove the use of pingrp macros
  ARM: dts: imx27: remove the use of pingrp macros
  ARM: dts: vf610: remove the use of pingrp macros

 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   17 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   56 ++-
 arch/arm/boot/dts/imx25-pingrp.h                   |   81 ---
 arch/arm/boot/dts/imx25.dtsi                       |    2 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   26 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   65 ++-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   27 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   26 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   23 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   38 +-
 arch/arm/boot/dts/imx27-pingrp.h                   |  151 ------
 arch/arm/boot/dts/imx27.dtsi                       |    2 +-
 arch/arm/boot/dts/imx35-pingrp.h                   |  104 ----
 arch/arm/boot/dts/imx35.dtsi                       |    1 -
 arch/arm/boot/dts/imx50-evk.dts                    |   28 +-
 arch/arm/boot/dts/imx50-pingrp.h                   |  146 ------
 arch/arm/boot/dts/imx50.dtsi                       |    2 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |   26 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |   64 ++-
 arch/arm/boot/dts/imx51-babbage.dts                |  142 +++++-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   26 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   31 +-
 arch/arm/boot/dts/imx51-pingrp.h                   |  249 ---------
 arch/arm/boot/dts/imx51.dtsi                       |    2 +-
 arch/arm/boot/dts/imx53-ard.dts                    |   18 +-
 arch/arm/boot/dts/imx53-evk.dts                    |   51 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |  128 ++++-
 arch/arm/boot/dts/imx53-pingrp.h                   |  352 -------------
 arch/arm/boot/dts/imx53-qsb.dts                    |   88 +++-
 arch/arm/boot/dts/imx53-smd.dts                    |   77 ++-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   89 +++-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |   21 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   47 +-
 arch/arm/boot/dts/imx53.dtsi                       |    2 +-
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |    5 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |    1 -
 arch/arm/boot/dts/imx6q-arm2.dts                   |   81 ++-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |   44 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   47 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   75 ++-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   53 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   37 +-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   33 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    1 -
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   77 ++-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   88 +++-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   93 +++-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   93 +++-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |    5 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   56 ++-
 arch/arm/boot/dts/imx6qdl-pingrp.h                 |  532 --------------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  139 ++++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   56 ++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   86 +++-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   78 ++-
 arch/arm/boot/dts/imx6sl-evk.dts                   |  120 ++++-
 arch/arm/boot/dts/imx6sl-pingrp.h                  |  148 ------
 arch/arm/boot/dts/imx6sl.dtsi                      |    1 -
 arch/arm/boot/dts/vf610-cosmic.dts                 |   17 +-
 arch/arm/boot/dts/vf610-pingrp.h                   |  127 -----
 arch/arm/boot/dts/vf610-twr.dts                    |   42 +-
 arch/arm/boot/dts/vf610.dtsi                       |    2 +-
 62 files changed, 2163 insertions(+), 2182 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx25-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx27-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx35-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx50-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx51-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx53-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx6qdl-pingrp.h
 delete mode 100644 arch/arm/boot/dts/imx6sl-pingrp.h
 delete mode 100644 arch/arm/boot/dts/vf610-pingrp.h

-- 
1.7.9.5
