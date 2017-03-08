From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed,  8 Mar 2017 12:46:36 -0500
Subject: [PATCH 0/2] [kernel] ARM: lpc32xx: migrate CLCD config to device tree
Message-ID: <20170308174638.25578-1-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Migrate the CLCD configurations to the device tree and
remove custom functions from board files.

This change depends on the following change:
"video: ARM CLCD: fix dma allocation size"
https://www.spinics.net/lists/arm-kernel/msg567178.html

Note:
* We tested a similar change on a custom LPC32xx board with a 480x272 LCD.
* We did not test this change on hardware;
  we do not have access to a PHY3250 board with the 240x320 LCD.

Liam Beguin (2):
  ARM: dts: lpc32xx: phy3250: add clcd configuration
  ARM: lpc32xx: drop CLCD configuration

 arch/arm/boot/dts/lpc3250-phy3250.dts | 35 ++++++++++++++++++
 arch/arm/mach-lpc32xx/phy3250.c       | 70 -----------------------------------
 2 files changed, 35 insertions(+), 70 deletions(-)

-- 
2.11.0
