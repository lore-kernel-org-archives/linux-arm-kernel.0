From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 12:03:16 +0200
Subject: [GIT PULL] ARM/clk move ICST library to drivers/clk
Message-ID: <CACRpkdbPagc3fVyzryRYhcwnQ2WA-z7fSbW+VpR09iLqvVEhjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this moves the ICST library from arch/arm to drivers/clk
so it can be reused from there.

The patches are ACKed by Stephen Boyd.

Please pull it into some cleanup branch in ARM SoC.

Yours,
Linus Walleij


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/arm-to-clk-icst

for you to fetch changes up to ba3fae06c7a4e80ab9d48a8a045b352da97cf23d:

  ARM/clk: move the ICST library to drivers/clk (2017-04-07 11:58:12 +0200)

----------------------------------------------------------------
This moves the ICST helper library from arch/arm to drivers/clk

----------------------------------------------------------------
Linus Walleij (2):
      ARM: plat-versatile: remove stale clock header
      ARM/clk: move the ICST library to drivers/clk

 arch/arm/common/Kconfig                                   |  3 ---
 arch/arm/common/Makefile                                  |  1 -
 arch/arm/plat-versatile/include/plat/clock.h              | 15 ---------------
 drivers/clk/versatile/Kconfig                             |  3 +++
 drivers/clk/versatile/Makefile                            |  2 +-
 drivers/clk/versatile/clk-icst.c                          |  1 +
 drivers/clk/versatile/clk-icst.h                          |  2 --
 drivers/clk/versatile/clk-impd1.c                         |  1 +
 drivers/clk/versatile/clk-realview.c                      |  1 +
 drivers/clk/versatile/clk-versatile.c                     |  1 +
 {arch/arm/common => drivers/clk/versatile}/icst.c         |  2 +-
 .../include/asm/hardware => drivers/clk/versatile}/icst.h |  6 ++----
 12 files changed, 11 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/include/plat/clock.h
 rename {arch/arm/common => drivers/clk/versatile}/icst.c (98%)
 rename {arch/arm/include/asm/hardware => drivers/clk/versatile}/icst.h (94%)
