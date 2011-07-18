From: leoy@marvell.com (Leo Yan)
Date: Mon, 18 Jul 2011 19:18:06 +0800
Subject: [PATCH 0/2] Add audio sram support
Message-ID: <1310987888-541-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
