From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 15:21:48 +0200
Subject: [PATCH v2 0/4] ARM: S3C24XX: cleanup debug macro/earlyprintk
Message-ID: <1856986.kkQFKFg1L2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to simplify the s3c24xx debug macro, removing dependencies
on mach/ includes, static mappings and finally moving it into include/debug.

The one slightly invasive change is the need for the developer to select
the uart type by himself, which gets rid of the debug macro trying to
determine the uart type itself.

But as usage of the debug-uart is not the common case - especially in a
multiplatform scenario - I didn't worry to much.

Based on 3.15-rc1 and tested on a S3C2442 Openmoko Freerunner (GTA02)

changes since v1:
- do not introduce a secondary choice option, instead implement the
  s3c2410 debug uarts as separate options

Heiko Stuebner (4):
  ARM: compressed/head.S: remove s3c24xx special case
  ARM: S3C24XX: trim down debug uart handling
  ARM: S3C24XX: use generic DEBUG_UART_PHY/_VIRT in debug macro
  ARM: S3C24XX: move debug-macro.S into the common space

 arch/arm/Kconfig.debug                           |  54 +++++++++++-
 arch/arm/boot/compressed/head.S                  |   5 --
 arch/arm/include/debug/s3c24xx.S                 |  46 +++++++++++
 arch/arm/mach-s3c24xx/Kconfig                    |  28 -------
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S | 101 -----------------------
 5 files changed, 98 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/include/debug/s3c24xx.S
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/debug-macro.S

-- 
1.9.0
