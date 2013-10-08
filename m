From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  7 Oct 2013 21:37:18 -0700
Subject: [PATCH 0/2] additional vexpress-tc2 big endian fixes
Message-ID: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Here are couple more big endian related fixes. We run into these
with vexpress TC2 board, when CONFIG_MCPM and CONFIG_ARM_CCI configs
are enabled. Big endian image fails to boot. With fixes BE TC2
boots and it sees all 5 cores (2xA15, 3xA7).

These were tested with vexpress TC2 on latest linux-linaro
branch (include BE patch series) and it was tested on very 
recent rmk/fixes branch along with BE series on top of it. 

Thanks,
Victor

Victor Kamensky (2):
  ARM: mcpm: fix big endian issue in mcpm startup code
  ARM: cci: driver need big endian fixes in asm code

 arch/arm/common/mcpm_head.S | 2 ++
 drivers/bus/arm-cci.c       | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
1.8.1.4
