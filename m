From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  8 Aug 2017 22:48:40 +0900
Subject: [PATCH 0/3] serial: 8250_uniphier: bug fix and suspend/resume support
Message-ID: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1/3 is a bug-fix (the driver may unregister a different port)

2/3 and 3/3 add suspend/resume support.



Masahiro Yamada (3):
  serial: 8250_uniphier: fix serial port index in private data
  serial: 8250_uniphier: use CHAR register for canary to detect
    power-off
  serial: 8250_uniphier: add suspend/resume support

 drivers/tty/serial/8250/8250_uniphier.c | 63 ++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 9 deletions(-)

-- 
2.7.4
