From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 14 Aug 2013 18:23:04 +0100
Subject: [PATCH Resend 0/3] trivial fixes relating to !CONFIG_OF
Message-ID: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains 3 trivial fixes picked up along the path of building
kernels without CONFIG_OF enabled. They're things likely to break randconfig
builds, etc, if not fixed up.

[I'm resending these including the clocksource maintainers as suggested by
Daniel Lezcano]

Jonathan Austin (3):
  PSCI: add missing dependency on CONFIG_OF for PSCI.
  clocksource: Add missing dependency on CONFIG_OF for ARM_ARCH_TIMER
  ARM: arch_timer: Add missing include for of_* functions

 arch/arm/Kconfig                     |    1 +
 drivers/clocksource/Kconfig          |    3 ++-
 drivers/clocksource/arm_arch_timer.c |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.7.9.5
