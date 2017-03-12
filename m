From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 12 Mar 2017 12:26:23 +0100
Subject: [GIT PULL] Gemini device tree base
Message-ID: <CACRpkdb1XPpY02_40P2cu941eaMbdMSLQgFJb_v3JRB9yfBSTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this complements the previous pull request patching the Gemini
machine into a device tree platform by providing the corresponding
device tree changes.

The watchdog bindings are included since (I think) the watchdog
maintainer simply missed them when merging the driver in the last
merge window. No big deal, but if you prefer that I take them out
and ask the watchdog maintainer to merge them separately we
can do that, it just seems bureaucratic.

Please pull this in as you find best.

Yours,
Linus Walleij

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-base

for you to fetch changes up to 6ae4d211ab066ad3b808a2b7f0851837c44f495d:

  ARM: dts: add watchdog to the Gemini (2017-03-12 12:18:29 +0100)

----------------------------------------------------------------
Base patches for Gemini device trees:

- Bindings for the platform.

- Device trees for everything that was available as board
  files previously.

- New device tree for my target system SQ201.

- Device tree bindings for the watchdog. The driver was merged
  to the watchdog subsystem so this was probably just missed
  by the maintainer, and it is ACKed by Rob Herring.

----------------------------------------------------------------
Linus Walleij (8):
      ARM: dts: add top-level DT bindings for Cortina Gemini
      ARM: dts: add device tree for Gemini SoC and SQ201
      ARM: dts: add a devicetree for Raidsonic NAS IB-4220-B
      ARM: dts: add a devicetree for Teltonika RUT1xx
      ARM: dts: add a devicetree for Wiliboard WBD-111
      ARM: dts: add a devicetree for Wiliboard WBD-222
      watchdog: add DT bindings for Cortina Gemini
      ARM: dts: add watchdog to the Gemini

 Documentation/devicetree/bindings/arm/gemini.txt   |  86 ++++++++++++++++
 .../bindings/watchdog/cortina,gemini-watchdog.txt  |  17 ++++
 arch/arm/boot/dts/Makefile                         |   6 ++
 arch/arm/boot/dts/gemini-nas4220b.dts              | 102 +++++++++++++++++++
 arch/arm/boot/dts/gemini-rut1xx.dts                |  65 +++++++++++++
 arch/arm/boot/dts/gemini-sq201.dts                 |  96 ++++++++++++++++++
 arch/arm/boot/dts/gemini-wbd111.dts                | 102 +++++++++++++++++++
 arch/arm/boot/dts/gemini-wbd222.dts                | 102 +++++++++++++++++++
 arch/arm/boot/dts/gemini.dtsi                      | 108 +++++++++++++++++++++
 9 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt
 create mode 100644
Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 create mode 100644 arch/arm/boot/dts/gemini-nas4220b.dts
 create mode 100644 arch/arm/boot/dts/gemini-rut1xx.dts
 create mode 100644 arch/arm/boot/dts/gemini-sq201.dts
 create mode 100644 arch/arm/boot/dts/gemini-wbd111.dts
 create mode 100644 arch/arm/boot/dts/gemini-wbd222.dts
 create mode 100644 arch/arm/boot/dts/gemini.dtsi
