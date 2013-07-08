From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon,  8 Jul 2013 09:15:01 +0100
Subject: [PATCH v1 0/4] ARM: STi fixes and ethernet support
Message-ID: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch series fixes 2 configuration issues and adds ethernet support to
STiH415, STiH416 based B2000, B2020 boards.
With this patchset B2000 and B2020 can have basic ethernet support in
MII and RGMII modes.

Thanks,
srini

Srinivas Kandagatla (4):
  ARM: dts: STi: Fix pinconf setup for STiH416 serial2
  ARM: STi: Set correct ARM ERRATAs.
  ARM: STi: Add STiH415 ethernet support.
  ARM: STi: Add STiH416 ethernet support.

 arch/arm/boot/dts/stih415-pinctrl.dtsi |   82 ++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         |   34 +++++++
 arch/arm/boot/dts/stih416-pinctrl.dtsi |   92 +++++++++++++++++-
 arch/arm/boot/dts/stih416.dtsi         |   38 +++++++-
 arch/arm/boot/dts/stih41x-b2000.dtsi   |   21 ++++
 arch/arm/boot/dts/stih41x-b2020.dtsi   |   14 +++
 arch/arm/mach-sti/Kconfig              |    3 +-
 arch/arm/mach-sti/Makefile             |    2 +-
 arch/arm/mach-sti/board-dt.c           |    2 +
 arch/arm/mach-sti/stih41x.c            |  166 ++++++++++++++++++++++++++++++++
 arch/arm/mach-sti/stih41x.h            |    4 +
 11 files changed, 454 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-sti/stih41x.c
 create mode 100644 arch/arm/mach-sti/stih41x.h

-- 
1.7.6.5
