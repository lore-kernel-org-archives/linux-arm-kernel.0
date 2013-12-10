From: tixy@linaro.org (Jon Medhurst)
Date: Tue, 10 Dec 2013 10:18:57 +0000
Subject: [PATCH 0/3] serial: amba-pl011: fix race conditions during
 initialisation
Message-ID: <1386670740-16914-1-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a UART that is being used for a kernel console is also opened
by user-side, e.g. for use as a terminal, then there are race conditions
which can lead to terminal input being disabled and console output being
corrupted. This small patch series fixes these.

Jon Medhurst (3):
      serial: amba-pl011: use port lock to guard control register access
      serial: amba-pl011: factor out code for writing LCR_H register
      serial: amba-pl011: preseserve hardware settings during initialisation

 drivers/tty/serial/amba-pl011.c |   59 ++++++++++++++++++++++++++++++++++------------------------
