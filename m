From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 23 May 2017 13:30:54 +0900
Subject: [PATCH v3 0/4] arm64: kgdb: fix single stepping
Message-ID: <20170523043058.5463-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third version of my kgdb patch for fixing single stepping.
(Sorry for this lazy update.)


Kgdb support on arm64 was merged in v3.15, but from its first appearance,
"single step" has never worked well. This patchset fixes all the error
cases I found so far. Issues are reproducable, at least, on Hikey and fast
model and I tested the patches on both of them.

The original patch[1] was splitted into three pieces, patch #1 to #3,
addressing issues one by one, in order for necessary part of changes to
be applied to specific version of kernels, but it might no longer make
much sense.

Regarding to patch #4, I'm not still sure whether it is a right fix,
but it certainly fixes some corner case.

Changes for v3: (May 23, 2017)
* simplify patch #1 to respect the original code
* swap patch #2 and #3
* add patch #4

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295632.html

AKASHI Takahiro (4):
  arm64: kgdb: fix single stepping
  arm64: kgdb: disable interrupts while a software step is enabled
  arm64: kgdb: prevent kgdb from being invoked recursively
  kgdb: select a correct cpu while in a single stepping

 arch/arm64/kernel/kgdb.c  | 62 ++++++++++++++++++++++++++++++++++++++---------
 kernel/debug/debug_core.c |  8 +++---
 2 files changed, 55 insertions(+), 15 deletions(-)

-- 
2.11.1
