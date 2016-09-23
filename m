From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 16:33:24 +0900
Subject: [PATCH v2 0/3] arm64: kgdb: fix single stepping
Message-ID: <20160923073327.9657-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kgdb support on arm64 was merged in v3.15, but from its first appearance,
"signle step" has never worked well.

This patch fixes all the error cases I found so far.
The original patch[1] was splitted into three pieces, ones for each case.
patch#1, #2 should be applied to all the version, v3.15 and later.
pathc#3 only for v3.16 and later.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295632.html

AKASHI Takahiro (3):
  arm64: kgdb: fix single stepping
  arm64: kgdb: prevent kgdb from being invoked recursively
  arm64: kgdb: disable interrupts while a software step is enabled

 arch/arm64/kernel/kgdb.c | 60 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

-- 
2.10.0
