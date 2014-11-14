From: carlo@caione.org (Carlo Caione)
Date: Fri, 14 Nov 2014 17:25:50 +0100
Subject: [PATCH RESEND 0/3] ARM: Meson6: enable SMP
Message-ID: <1415982353-9293-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
pieces to boot the secondary CPU.

---

This is a resend of a patchset already submitted a while ago 
http://www.spinics.net/lists/arm-kernel/msg366787.html

Carlo Caione (3):
  ARM: Meson6: docs: document bindings
  ARM: Meson6: Add SMP support for Amlogic Meson6
  ARM: Meson6: enable SMP in DTS/DTSI

 .../bindings/arm/meson/amlogic,meson6-cpuconfig    | 16 +++++
 .../bindings/arm/meson/amlogic,meson6-smp          | 26 +++++++
 arch/arm/boot/dts/meson.dtsi                       |  5 ++
 arch/arm/boot/dts/meson6.dtsi                      |  6 ++
 arch/arm/mach-meson/Kconfig                        |  1 +
 arch/arm/mach-meson/Makefile                       |  1 +
 arch/arm/mach-meson/headsmp.S                      |  7 ++
 arch/arm/mach-meson/platsmp.c                      | 80 ++++++++++++++++++++++
 8 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig
 create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp
 create mode 100644 arch/arm/mach-meson/headsmp.S
 create mode 100644 arch/arm/mach-meson/platsmp.c

-- 
1.9.1
