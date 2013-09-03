From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Tue,  3 Sep 2013 03:52:55 -0700
Subject: [PATCH] *** add support of GCC 4.7 for gcov ***
Message-ID: <1378205576-28467-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

gcc_3_4.c doesn't work with GCC 4.7, as from GCC 4.7 gcov
infrastrucs have been changed. This patch adds gcc_4_7.c to support
GCC 4.7 and newer version, so that both old GCC and 4.7 later
GCC can be supported at runtime.

Jiada Wang (1):
  gcov: add support to GCC 4.7

 kernel/gcov/Makefile   |    2 +-
 kernel/gcov/base.c     |   38 +++++
 kernel/gcov/fs.c       |    6 +
 kernel/gcov/gcc_3_4.c  |  174 +++++++------------
 kernel/gcov/gcc_4_7.c  |  434 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h     |  142 ++++++++++------
 kernel/gcov/gcov_3_4.h |   77 +++++++++
 kernel/gcov/gcov_4_7.h |   77 +++++++++
 8 files changed, 787 insertions(+), 163 deletions(-)
 create mode 100644 kernel/gcov/gcc_4_7.c
 create mode 100644 kernel/gcov/gcov_3_4.h
 create mode 100644 kernel/gcov/gcov_4_7.h

-- 
1.7.9.5
