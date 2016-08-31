From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Aug 2016 11:31:07 +0100
Subject: [PATCH v2 0/3] arm64: cpufeature: constify and refactor feature array
Message-ID: <1472639470-28224-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the series that constifies and refactors the cpufeatures data
structures, in a way that allows certain pieces to be referenced directly by
external code. This was triggered by the discussion around Suzuki's CTR
emulation series [0]

Changes since v1/RFC:
- replace 'if (<cond>) { BUG(); }' with 'BUG_ON(<cond>);' (#2)
- don't dereference NULL return value of bsearch() (#2)
- rename global ctrel0_ftr_reg to arm64_ftr_reg_ctrel0 (#3)
- add Suzuki's R-b (#1, #2, #3)

[0] http://marc.info/?l=linux-arm-kernel&m=147152604303792&w=2

Ard Biesheuvel (3):
  arm64: cpufeature: constify arm64_ftr_bits structures
  arm64: cpufeature: constify arm64_ftr_regs array
  arm64: cpufeature: expose arm64_ftr_reg struct for CTR_EL0

 arch/arm64/include/asm/cpufeature.h | 15 +--
 arch/arm64/kernel/cpufeature.c      | 99 ++++++++++----------
 2 files changed, 58 insertions(+), 56 deletions(-)

-- 
2.7.4
