From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  9 Oct 2017 23:35:12 +0900
Subject: [PATCH 0/3] ARM, hexagon, c6x: build: fix usage of CFLAGS_MODULE,
 LDFLAGS_MODULE
Message-ID: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CFLAGS_MODULE, AFLAGS_MODULE, and LDFLAGS_MODULE are supposed
to be set by users.

In-kernel Makefile must use KBUILD_ prefixed variables.

This is explained in Documentation/kbuild/{kbuild.txt, makefiles.txt}

Most of architectures follow the rule, but I found violations
in ARM, hexagone, and c6x.

Fix them.



Masahiro Yamada (3):
  ARM: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
  hexagon: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
  c6x: add KBUILD_ prefix to CFLAGS_MODULE

 arch/arm/Makefile     | 6 +++---
 arch/c6x/Makefile     | 2 +-
 arch/hexagon/Makefile | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
