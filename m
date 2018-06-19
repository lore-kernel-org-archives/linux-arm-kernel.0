From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Jun 2018 21:26:31 +0200
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
Message-ID: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Work around the mindless and backward incompatible change in GAS that
prevents us from using a simple addition to set the Thumb bit in local
symbol references taken using 'adr' instructions (#2)

As a preparatory step, remove badr occurrences in ARM code sequences
contained in Thumb2 kernels.

Ard Biesheuvel (2):
  ARM: avoid badr macro for switching to Thumb-2 mode
  ARM: assembler: prevent ADR from setting the Thumb bit twice

 arch/arm/common/mcpm_head.S      |  5 ++---
 arch/arm/include/asm/assembler.h | 22 +++++++++++++++++++-
 arch/arm/kernel/head-nommu.S     |  7 +++----
 arch/arm/kernel/head.S           | 15 +++++++------
 arch/arm/kernel/sleep.S          |  7 +++----
 5 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.17.1
