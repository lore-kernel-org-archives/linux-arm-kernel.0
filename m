From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:38:58 -0800
Subject: [PATCH v2 0/7] Add support for GNU gold
In-Reply-To: <20171129234442.655-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-1-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add macros for detecting the linker name and version,
and apply fixes and workarounds needed to link the arm64 kernel with
GNU gold.

Changes since v1:
  - moved LD_DEAD_CODE_DATA_ELIMINATION fixes to the beginning of the
    patch set and removed mentions of gold
  - renamed ld-if-name-version to __ld-ifversion for consistency
  - cleaned up the erratum changes in arch/arm64/Makefile

Sami Tolvanen (7):
  kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION
  arm64: keep .altinstructions and .altinstr_replacement
  kbuild: add ld-name macro
  kbuild: add __ld-ifversion and linker-specific macros
  arm64: fix -m for GNU gold
  arm64: explicitly pass --no-fix-cortex-a53-843419 to GNU gold
  arm64: add a workaround for GNU gold with ARM64_MODULE_PLTS

 arch/arm64/Makefile               | 17 +++++++++++++++++
 arch/arm64/kernel/module.lds      |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S   |  4 ++--
 include/asm-generic/vmlinux.lds.h |  8 ++++----
 scripts/Kbuild.include            | 16 ++++++++++++++++
 5 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.15.0.531.g2ccb3012c9-goog
