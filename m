From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Fri, 27 Feb 2015 16:07:13 +0800
Subject: [PATCH v2 0/5] tty/serial: at91: fix bugs when using multiple serials
Message-ID: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches fix bugs when using multiple serial ports at the same time:
 - The using rx ring buffer in DMA is inconsistent with its allocation.
 - The serial port can't send and receive data when it's opened the second time
   and the later if it switches to PIO when DMA channel is not available.
 - The serial port can lead to kernel crash when data is sending and receiving
   and the program is killed.
 
The patches were made from branch tty-next of gregkh/tty.git repository, and 
tested on a SAMA5D36 VB boards with 5 serial ports enabled.

Changes from v1:
 - Use macro PAGE_ALIGNED to simplify the expression.

Leilei Zhao (5):
  tty/serial: at91: correct check of buf used in DMA
  tty/serial: at91: correct buffer size used in DMA
  tty/serial: at91: revise the return type of atmel_init_property
  tty/serial: at91: set ops in property init each time
  tty/serial: at91: correct the usage of tasklet

 drivers/tty/serial/atmel_serial.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
1.7.9.5
