From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:18:08 +0100
Subject: [PATCH 0/2] ARM: tegra: enable SMP boot with TF
References: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
Message-ID: <cover.1541884486.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables starting up all cores on Tegra3 with Trusted
Foundations firmware. This is Tegra-specific part and depends on
"ARM: enable cache via Trusted Foundations firmware" patchset sent
earlier.

Micha? Miros?aw (2):
  ARM: tegra: enable cache via TF
  ARM: tegra: avoid touching Secure registers in reset handler

 arch/arm/firmware/trusted_foundations.c    |  6 +++--
 arch/arm/include/asm/trusted_foundations.h |  6 +++--
 arch/arm/mach-tegra/reset-handler.S        | 27 +++++++++++++++++++++-
 arch/arm/mach-tegra/reset.c                |  5 +++-
 arch/arm/mach-tegra/reset.h                |  5 ++--
 arch/arm/mach-tegra/tegra.c                |  6 +++--
 6 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.19.1
