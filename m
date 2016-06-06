From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jun 2016 18:40:59 +0900
Subject: [PATCH 0/4] serial: earlycon: keep earlycon symbols for non-module
 and driver clean-ups
Message-ID: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


1/4: keep earlycon symbols only when CONFIG_SERIAL_EARLYCON is defined
     and the driver is built-in.

2/4 thru 4/4: driver clean-ups.
              (partially reverts build fixes by Arnd Bergmann)



Masahiro Yamada (4):
  earlycon: mark earlycon code as __used iif the caller is built-in
  serial: 8250_uniphier: drop !defined(MODULE) conditional
  serial: 8250_mtk: drop !defined(MODULE) conditional
  serial: 8250_ingenic: drop #if conditional surrounding earlycon code

 drivers/tty/serial/8250/8250_ingenic.c  | 2 --
 drivers/tty/serial/8250/8250_mtk.c      | 2 +-
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 drivers/tty/serial/8250/Kconfig         | 2 +-
 include/linux/serial_core.h             | 8 +++++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

-- 
1.9.1
