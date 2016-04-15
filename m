From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 17:44:47 +0530
Subject: [GIT PULL 2/3] DaVinci SoC updates for v4.7
In-Reply-To: <1460722488-5921-1-git-send-email-nsekhar@ti.com>
References: <1460722488-5921-1-git-send-email-nsekhar@ti.com>
Message-ID: <1460722488-5921-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9a7f2fc8408fdc0e3b417f670c17ed70d5d1c114:

  ARM: davinci: use IRQCHIP_DECLARE for cp_intc (2016-04-14 12:09:50 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/soc

for you to fetch changes up to 8a9d088f66f84d7317b4adc64d3d3114f1ee8583:

  ARM: davinci: clk: add set_parent callback for mux clocks (2016-04-14 15:31:48 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v4.7. These are
preparatory patches to support a USB PHY
driver for USB on DA850 SoC. This should
eventually lead to USB working again on
this device.

----------------------------------------------------------------
David Lechner (2):
      ARM: davinci: da8xx: move usb code to new file
      ARM: davinci: clk: add set_parent callback for mux clocks

 arch/arm/mach-davinci/Makefile    |   4 +-
 arch/arm/mach-davinci/clock.c     |  19 ++++++-
 arch/arm/mach-davinci/clock.h     |   1 +
 arch/arm/mach-davinci/usb-da8xx.c | 107 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/usb.c       |  73 --------------------------
 5 files changed, 128 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm/mach-davinci/usb-da8xx.c
