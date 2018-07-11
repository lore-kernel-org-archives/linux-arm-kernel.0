From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 11 Jul 2018 11:59:05 +0530
Subject: [GIT PULL 2/3] DaVinci DT updates for v4.19
In-Reply-To: <20180711062906.22865-1-nsekhar@ti.com>
References: <20180711062906.22865-1-nsekhar@ti.com>
Message-ID: <20180711062906.22865-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.19/dt

for you to fetch changes up to 3117c17301edce7583843bdee513e201bb69c37c:

  ARM: dts: da850: Add power-domains to CPPI 4.1 node (2018-07-10 15:32:41 +0530)

----------------------------------------------------------------
DaVinci Device-Tree updates for v4.19
-------------------------------------

* DA850 now uses clocks from device-tree
* DA850 EVM gains LCD (with backlight) and SATA support
* Lego Mindstorms gains bluetooth support
* DSP reset control support on DA850

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: da850-evm: Enable SATA port
      ARM: dts: da850-evm: Enable LCD and backlight

Bartosz Golaszewski (2):
      ARM: davinci: dts: make psc0 a reset provider
      ARM: davinci: dts: add a reset control to the dsp node

David Lechner (4):
      dt-bindings: timer: new bindings for TI DaVinci timer
      ARM: dts: da850: Add clocks
      ARM: dts: da850: Add power-domains to PWM nodes
      ARM: dts: da850-lego-ev3: Add Bluetooth nodes

Sekhar Nori (1):
      ARM: dts: da850: Add power-domains to CPPI 4.1 node

 .../devicetree/bindings/timer/ti,davinci-timer.txt |  37 +++++
 arch/arm/boot/dts/da850-enbw-cmc.dts               |   4 +
 arch/arm/boot/dts/da850-evm.dts                    |  91 ++++++++++-
 arch/arm/boot/dts/da850-lcdk.dts                   |   9 ++
 arch/arm/boot/dts/da850-lego-ev3.dts               |  86 ++++++++++
 arch/arm/boot/dts/da850.dtsi                       | 176 +++++++++++++++++++++
 6 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
