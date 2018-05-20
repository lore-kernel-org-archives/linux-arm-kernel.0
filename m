From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 20 May 2018 13:15:37 +0300
Subject: [PATCH v1 0/5] Initial support of Trusted Foundations on Tegra30
Message-ID: <20180520101542.12206-1-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches brings initial support of Trusted Foundations to
Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
to easily replace the proprietary bootloader. Support is initial because
this series implements only a proper CPU boot-up (main + secondary cores)
and a basic L2 cache maintenance that is done using the TF firmware.
Suspend-resume support is missing yet as I couldn't get it to work
(CPU hangs on resume from suspend after awhile and seems that is related
to inappropriately done cache maintenance during of suspend-resume using
the firmware), it is work-in-progress for now.

This patchset is partially based on the work done by Micha? Miros?aw [0].

Please review, thanks.

[0] https://www.spinics.net/lists/linux-tegra/msg30368.html

Dmitry Osipenko (5):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Setup L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode

 arch/arm/firmware/trusted_foundations.c    | 28 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h |  7 ++++++
 arch/arm/mach-tegra/reset-handler.S        | 28 +++++++++++++++-------
 arch/arm/mach-tegra/reset.c                |  5 +++-
 arch/arm/mach-tegra/reset.h                |  4 +++-
 arch/arm/mach-tegra/tegra.c                | 15 ++++++++++++
 6 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.17.0
