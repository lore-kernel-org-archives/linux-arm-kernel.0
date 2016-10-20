From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 20 Oct 2016 16:27:10 +0200
Subject: [GIT PULL] STi DT update for v4.10 round 1
Message-ID: <1a44f1ef-906a-798a-a60b-9d8212209aaa@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.10 :


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 

for you to fetch changes up to 97a0b97f9e8197429eee5f87ce14373f73dbd9d3:

  ARM: dts: stih410-clocks: Add PROC_STFE as a critical clock (2016-10-20 16:20:26 +0200)

----------------------------------------------------------------
STi dts update:

Remove deprecated STiH415/416 DTS files
Add DT part associated to following ASoC patchset:
   http://www.spinics.net/lists/alsa-devel/msg54782.html
Enable hdmi audio card on b2120 board
Clean STi sound card field for STiH407 family socs
Add PROC_STFE as a critical clock for STiH410

----------------------------------------------------------------
Arnaud Pouliquen (5):
      ARM: dts: STiH407-family: sti sound card field cleaning
      ARM: dts: STiH407: Add label for sti-hdmi node
      ARM: dts: STiH410: Add label for sti-hdmi node
      ARM: dts: STiHxxx-b2120: Add support of HDMI audio
      ARM: dts: STiH410-B2260: clean unnecessary hdmi node overlay

Patrice Chotard (15):
      ARM: dts: remove STiH416-b2020e.dts
      ARM: dts: remove STiH416-b2020.dts
      ARM: dts: remove STiH416-b2000.dts
      ARM: dts: remove STiH416-clock.dtsi
      ARM: dts: remove STiH416-pinctrl.dtsi
      ARM: dts: remove STiH415-b2020.dts
      ARM: dts: remove STiH415-b2000.dts
      ARM: dts: remove STiH415-clock.dtsi
      ARM: dts: remove STiH415-pinctrl.dtsi
      ARM: dts: remove STiH415.dtsi
      ARM: dts: remove STiH416.dtsi
      ARM: dts: remove STiH41x.dtsi
      ARM: dts: remove STiH41x-b2020.dtsi
      ARM: dts: remove STiH41x-b2000.dtsi
      ARM: dts: remove STiH41x-b2020.dtsi

Peter Griffin (7):
      MAINTAINERS: Remove phy-miphy365x.c entry from STi arch
      MAINTAINERS: Remove phy-stih41x-usb.c entry from STi arch
      ahci: st: Remove STiH416 dt example
      thermal: sti: Remove obsolete platforms from the DT doc.
      reset: sti: Remove obsolete platforms from dt binding doc.
      reset: sti: softreset: Remove obsolete platforms from dt binding doc.
      ARM: dts: stih410-clocks: Add PROC_STFE as a critical clock

 Documentation/devicetree/bindings/ata/ahci-st.txt  |  15 -
 .../devicetree/bindings/reset/st,sti-powerdown.txt |  12 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |   8 +-
 .../devicetree/bindings/thermal/st-thermal.txt     |  28 +-
 MAINTAINERS                                        |   2 -
 arch/arm/boot/dts/Makefile                         |   5 -
 arch/arm/boot/dts/stih407-family.dtsi              |  32 +-
 arch/arm/boot/dts/stih407.dtsi                     |   2 +-
 arch/arm/boot/dts/stih410-b2260.dts                |   6 -
 arch/arm/boot/dts/stih410-clock.dtsi               |   3 +-
 arch/arm/boot/dts/stih410.dtsi                     |   2 +-
 arch/arm/boot/dts/stih415-b2000.dts                |  15 -
 arch/arm/boot/dts/stih415-b2020.dts                |  15 -
 arch/arm/boot/dts/stih415-clock.dtsi               | 533 ---------------
 arch/arm/boot/dts/stih415-pinctrl.dtsi             | 545 ---------------
 arch/arm/boot/dts/stih415.dtsi                     | 234 -------
 arch/arm/boot/dts/stih416-b2000.dts                |  15 -
 arch/arm/boot/dts/stih416-b2020.dts                |  37 -
 arch/arm/boot/dts/stih416-b2020e.dts               |  65 --
 arch/arm/boot/dts/stih416-clock.dtsi               | 756 ---------------------
 arch/arm/boot/dts/stih416-pinctrl.dtsi             | 692 -------------------
 arch/arm/boot/dts/stih416.dtsi                     | 517 --------------
 arch/arm/boot/dts/stih41x-b2000.dtsi               |  96 ---
 arch/arm/boot/dts/stih41x-b2020.dtsi               |  82 ---
 arch/arm/boot/dts/stih41x-b2020x.dtsi              |  32 -
 arch/arm/boot/dts/stih41x.dtsi                     |  47 --
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |  19 +-
 27 files changed, 45 insertions(+), 3770 deletions(-)
 delete mode 100644 arch/arm/boot/dts/stih415-b2000.dts
 delete mode 100644 arch/arm/boot/dts/stih415-b2020.dts
 delete mode 100644 arch/arm/boot/dts/stih415-clock.dtsi
 delete mode 100644 arch/arm/boot/dts/stih415-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stih415.dtsi
 delete mode 100644 arch/arm/boot/dts/stih416-b2000.dts
 delete mode 100644 arch/arm/boot/dts/stih416-b2020.dts
 delete mode 100644 arch/arm/boot/dts/stih416-b2020e.dts
 delete mode 100644 arch/arm/boot/dts/stih416-clock.dtsi
 delete mode 100644 arch/arm/boot/dts/stih416-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stih416.dtsi
 delete mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi
 delete mode 100644 arch/arm/boot/dts/stih41x-b2020.dtsi
 delete mode 100644 arch/arm/boot/dts/stih41x-b2020x.dtsi
 delete mode 100644 arch/arm/boot/dts/stih41x.dtsi
