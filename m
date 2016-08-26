From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Aug 2016 18:15:39 +0100
Subject: [RFC PATCH 0/3] arm64: cpufeatures: constify and expose CTR_EL0
 directly
Message-ID: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a proposal to rework the cpufeatures framework to allow direct access
to certain arm64_ftr_reg structure without complicating the code in general.

As prepatory steps, the code is constified, and the arm64_ftr_regs array
reworked slightly, which harden the code and should also optimize the
bsearch somewhat.

Ard Biesheuvel (3):
  arm64: cpufeature: constify arm64_ftr bits structures
  arm64: cpufeature: constify arm64_ftr_regs array
  arm64: cpufeature: expose arm64_ftr_reg struct for CTR_EL0

 arch/arm64/include/asm/cpufeature.h | 15 +--
 arch/arm64/kernel/cpufeature.c      | 98 ++++++++++----------
 2 files changed, 57 insertions(+), 56 deletions(-)

-- 
2.7.4
