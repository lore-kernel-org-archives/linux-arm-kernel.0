From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 29 Nov 2017 15:44:35 -0800
Subject: [PATCH 0/7] Add support for GNU gold
Message-ID: <20171129234442.655-1-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add macros for detecting the linker name and version,
and apply fixes and workarounds needed to link the arm64 kernel with
GNU gold.

Sami Tolvanen (7):
  kbuild: add ld-name macro and support for GNU gold
  kbuild: add ld-if-name-version and linker-specific macros
  kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION with GNU gold
  arm64: fix -m for GNU gold
  arm64: keep .altinstructions and .altinstr_replacement
  arm64: explicitly pass --no-fix-cortex-a53-843419 to GNU gold
  arm64: add a workaround for GNU gold with ARM64_MODULE_PLTS

 Makefile                          |  5 +++++
 arch/arm64/Makefile               | 17 +++++++++++++++++
 arch/arm64/kernel/module.lds      |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S   |  4 ++--
 include/asm-generic/vmlinux.lds.h |  8 ++++----
 scripts/Kbuild.include            | 16 ++++++++++++++++
 6 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.15.0.531.g2ccb3012c9-goog
