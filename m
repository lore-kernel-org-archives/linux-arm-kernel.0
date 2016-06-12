From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 12 Jun 2016 13:21:20 +0200
Subject: [GIT PULL] ARM: at91: dt for 4.8 #1
Message-ID: <20160612112120.GA25664@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

First DT changes for 4.8 with the addition of a new board and a cleanup
of unused clock definitions.

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-dt

for you to fetch changes up to 64c0703e269d442f0406b34e64e23744151ea276:

  ARM: dts: at91: calao: remove leftovers clock definition (2016-06-10 16:59:30 +0200)

----------------------------------------------------------------
DT Changes for 4.8:
 - New board: Olimex SAM9-L9260
 - Fix crystal definitions for Denx ma5d4
 - Remove leftover clock definitions
 - Add stdout-path for usb_a9260/a9g20

----------------------------------------------------------------
Alexandre Belloni (10):
      ARM: dts: at91: usb_a9g20: use stdout-path
      ARM: dts: at91: ma5d4: properly define crystals frequencies
      ARM: dts: at91: animeo_ip: remove leftovers clock definition
      ARM: dts: at91: at91-ariag25: remove leftovers clock definition
      ARM: dts: at91: at91-cosino: remove leftovers clock definition
      ARM: dts: at91: at91-foxg20: remove leftovers clock definition
      ARM: dts: at91: ge863-pro3: remove leftovers clock definition
      ARM: dts: at91: mpa1600: remove leftovers clock definition
      ARM: dts: at91: pm9g45: remove leftovers clock definition
      ARM: dts: at91: calao: remove leftovers clock definition

Raashid Muhammed (2):
      ARM: dts: at91: at91sam9260: Remove leading zeros in OHCI node.
      ARM: dts: at91: Add DT support for Olimex SAM9-L9260 board.

 Documentation/devicetree/bindings/arm/olimex.txt |   8 +-
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/aks-cdu.dts                    |   2 +-
 arch/arm/boot/dts/animeo_ip.dts                  |  11 +--
 arch/arm/boot/dts/at91-ariag25.dts               |   9 --
 arch/arm/boot/dts/at91-cosino.dtsi               |   9 --
 arch/arm/boot/dts/at91-foxg20.dts                |  11 +--
 arch/arm/boot/dts/at91-kizbox.dts                |   2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts             |  11 +--
 arch/arm/boot/dts/at91-sam9_l9260.dts            | 115 +++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi        |   7 +-
 arch/arm/boot/dts/at91sam9260.dtsi               |   2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi      |   2 +-
 arch/arm/boot/dts/ethernut5.dts                  |   2 +-
 arch/arm/boot/dts/evk-pro3.dts                   |   2 +-
 arch/arm/boot/dts/ge863-pro3.dtsi                |   9 --
 arch/arm/boot/dts/mpa1600.dts                    |   9 --
 arch/arm/boot/dts/pm9g45.dts                     |   9 --
 arch/arm/boot/dts/tny_a9260_common.dtsi          |   9 --
 arch/arm/boot/dts/tny_a9263.dts                  |   9 --
 arch/arm/boot/dts/usb_a9260_common.dtsi          |  11 +--
 arch/arm/boot/dts/usb_a9263.dts                  |   9 --
 arch/arm/boot/dts/usb_a9g20_common.dtsi          |   3 +-
 23 files changed, 139 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9_l9260.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/2e4686cd/attachment.sig>
