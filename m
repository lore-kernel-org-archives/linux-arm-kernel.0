From: h.grohne@intenta.de (Helmut Grohne)
Date: Mon, 4 Jun 2018 12:21:56 +0200
Subject: [PATCH v3 0/3] serial: xuartps: hardware race condition and cleanup
Message-ID: <cover.1528106392.git.h.grohne@intenta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The character transmission in xuartps is racy. If the transmitter is disabled
early, the device is confused and produces a desync. Garbage on the remote end
can be a visible symptom. The second patch in this series tries to reduce that
race condition in accordance with the hardware documentation, but it cannot
remove it entirely. The first and third patches are code cleanup.

Changes since v2:
 * Do not attempt to disable the transmitter after a transmission (original
   behaviour around 3.14). These patches no longer touch with the transmitter
   state at all as requested by S?ren Brinkmann.
 * Add Acked-by/Reviewed-by tags from S?ren Brinkmann after addressing his
   remarks.

Earlier patches/discussion at:
    https://www.spinics.net/lists/linux-serial/msg23145.html
    https://www.spinics.net/lists/linux-serial/msg23156.html
    https://www.spinics.net/lists/linux-serial/msg23157.html

Helmut Grohne (3):
  serial: xuartps: fix typo in cdns_uart_startup
  serial: xuartps: reduce hardware TX race condition
  serial: xuartps: remove unnecessary register write

 drivers/tty/serial/xilinx_uartps.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

-- 
2.11.0
