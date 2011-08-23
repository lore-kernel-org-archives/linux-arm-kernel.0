From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:37 +0100
Subject: [PATCH v2 0/5] Convert DEBUG_LL UART selection to a Kconfig choice
Message-ID: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the series originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/061477.html

Changes since v1 include:

 - Support for imx (thanks Shawn)
 - Improvements to the Kconfig help text (thanks Sascha)

This generated some controversy on the mailing list so I thought it was
in need of a repost anyway. This series is based on the premise that DEBUG_LL
is not an option that should be left enabled in distribution kernels and
instead is an option that should only be enabled when debugging early
failures during boot.

Feedback welcome.

Will


Shawn Guo (1):
  arm/imx: use Kconfig choice for low-level debug UART selection

Will Deacon (4):
  ARM: debug: use kconfig choice for selecting DEBUG_LL UART
  ARM: debug: augment DEBUG_LL Kconfig help to clarify behaviour
  ARM: plat-samsung: use Kconfig choice for debug UART selection
  ARM: realview: use Kconfig choice for debug UART selection

 arch/arm/Kconfig.debug                            |  165 +++++++++++++++++----
 arch/arm/mach-mxs/include/mach/debug-macro.S      |   12 +--
 arch/arm/mach-realview/include/mach/debug-macro.S |   17 +--
 arch/arm/plat-mxc/include/mach/debug-macro.S      |   38 +----
 arch/arm/plat-samsung/Kconfig                     |    7 +
 5 files changed, 152 insertions(+), 87 deletions(-)
