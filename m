From: samitolvanen@google.com (Sami Tolvanen)
Date: Tue, 28 Nov 2017 16:00:08 -0800
Subject: [PATCH 0/3] Add version macros for clang and fix arm64 for clang <6.0
Message-ID: <20171129000011.55235-1-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to build an arm64 kernel with clang <6.0, we need to work
around LLVM bug 30792 by using -mno-implicit-float instead of
-mgeneral-regs-only.

This patch set adds macros for checking clang version, and enable the
workaround only for affected compiler versions.

Greg Hackmann (1):
  arm64: use -mno-implicit-float instead of -mgeneral-regs-only

Sami Tolvanen (2):
  kbuild: add clang-version.sh
  kbuild: add cc-if-name-version and compiler-specific variants

 arch/arm64/Makefile      |  5 ++++-
 scripts/Kbuild.include   | 31 +++++++++++++++++++++++++++++++
 scripts/clang-version.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100755 scripts/clang-version.sh

-- 
2.15.0.417.g466bffb3ac-goog
