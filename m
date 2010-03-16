From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 08:35:36 +0200
Subject: [PATCH 0/3] imx: fix build of assembly code using P2V macros
In-Reply-To: <20100311105637.GE16376@n2100.arm.linux.org.uk>
References: <20100311105637.GE16376@n2100.arm.linux.org.uk>
Message-ID: <cover.1268721010.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes the build of mx1 and mx25 which CONFIG_DEBUG_LL is 
enabled. The first patch makes IMX_IO_ADDRESS compatible with assmebly code, 
and the other two use IMX_IO_ADDRESS to fix debug-macro.S.

Alex Greshgorin (1):
  mx25: fix build when DEBUG_LL is enabled

Baruch Siach (2):
  imx: make IMX_IO_ADDRESS assembly compatible
  mx1: fix build when DEBUG_LL is enabled

 arch/arm/plat-mxc/include/mach/debug-macro.S |    6 +++---
 arch/arm/plat-mxc/include/mach/hardware.h    |   16 ++++++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)
