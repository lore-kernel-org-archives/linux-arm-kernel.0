From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Mon, 18 Jul 2011 06:12:49 -0700
Subject: [PATCH 0/2] Add audio sram support
In-Reply-To: <1310987888-541-1-git-send-email-leoy@marvell.com>
References: <1310987888-541-1-git-send-email-leoy@marvell.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05D3F4F2FA@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There would be a common sram driver in mainline.
________________________________________
From: Leo Yan [leoy at marvell.com]
Sent: Monday, July 18, 2011 7:18 PM
To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Haojian Zhuang; nicolas.pitre at linaro.org; Russell King
Cc: Leo Yan
Subject: [PATCH 0/2] Add audio sram support

On mmp platform, there have 16KB sram buffer dedicated
to audio island. It can be to dynamically allocated for
versatile pcm devices. So implement the audio sram
allocator for managing it.

Leo Yan (2):
  ARM: mmp: register audio sram device
  ARM: mmp: add audio sram allocator

 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-mmp/Makefile                  |    2 +-
 arch/arm/mach-mmp/audio_sram.c              |  118 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/brownstone.c              |    1 +
 arch/arm/mach-mmp/include/mach/audio_sram.h |   31 +++++++
 arch/arm/mach-mmp/include/mach/mmp2.h       |    6 ++
 arch/arm/mach-mmp/mmp2.c                    |    1 +
 7 files changed, 159 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/audio_sram.c
 create mode 100644 arch/arm/mach-mmp/include/mach/audio_sram.h

--
1.7.4.1
