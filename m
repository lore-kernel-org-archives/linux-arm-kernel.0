From: johan@kernel.org (Johan Hovold)
Date: Tue,  4 Jul 2017 15:25:40 +0200
Subject: [PATCH 0/2] ARM: add missing includes to header files
Message-ID: <20170704132542.27644-1-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two missing include directives to two header files to avoid
compile breakage when the required symbols have not already been
defined.

The missing SCU include broke compilation of the (not-yet-merged)
suspend support for am335x when !CONFIG_HAVE_ARM_SCU for example:

	https://lkml.kernel.org/r/20170704131441.GH27842 at localhost

Johan


Johan Hovold (2):
  ARM: scu: add missing errno include
  ARM: pm: add missing types include

 arch/arm/include/asm/smp_scu.h | 1 +
 arch/arm/include/asm/suspend.h | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.13.2
