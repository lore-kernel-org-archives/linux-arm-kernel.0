From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 13 Aug 2017 08:21:39 +0200
Subject: [PATCH 00/11] constify uart_ops structures
Message-ID: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

---

 drivers/tty/serial/21285.c                  |    2 +-
 drivers/tty/serial/apbuart.c                |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 drivers/tty/serial/m32r_sio.c               |    2 +-
 drivers/tty/serial/meson_uart.c             |    2 +-
 drivers/tty/serial/mpc52xx_uart.c           |    2 +-
 drivers/tty/serial/mux.c                    |    2 +-
 drivers/tty/serial/owl-uart.c               |    2 +-
 drivers/tty/serial/sunsab.c                 |    2 +-
 drivers/tty/serial/sunsu.c                  |    2 +-
 drivers/tty/serial/ucc_uart.c               |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
