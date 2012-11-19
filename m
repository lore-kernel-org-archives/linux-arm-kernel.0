From: s.peter@mpl.ch (Stefan Peter)
Date: Mon, 19 Nov 2012 11:26:44 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
Message-ID: <cover.1353319919.git.s.peter@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew

This is my try to convert the mplcec4 board to your pinctrl patches. The 
only problem I see is that I get an uart1 using mpp13 and mpp14 which
are used by the mvsdio driver (and mentioned accordingly in the appropriate
entry under /proc/device-tree/ocp at f00....). I did not find a way to get
rid of this uart1 and because the SD card interface does work and no kernel
errors or warnings are issued, it obviosely does no harm. However, I will
rework this patch if you have some input in this respect.

Regards
Stefan Peter

Stefan Peter (1):
  Convert mplcec4 board to pinctrl

 arch/arm/boot/dts/kirkwood-mplcec4.dts |   64 ++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-mplcec4.c |   35 -----------------
 2 files changed, 64 insertions(+), 35 deletions(-)

-- 
1.7.9.5
