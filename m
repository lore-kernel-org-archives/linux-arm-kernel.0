From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Jan 2014 11:41:35 +0100
Subject: [PATCH 0/4] tty/serial: at91: fixes dealing with port shutdown
Message-ID: <cover.1389090437.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These four fixes are pretty important for our atmel_serial driver as they
deal with closing/re-opening of ports. They fix race condition and
null pointers dereference.
I added the "stable" tag to each of them (v3.12).

Even if we are late in the development cycle, can you please consider including
these patches for 3.13?

Thanks, best regards,
   Nicolas Ferre

Marek Roszko (3):
  tty/serial: at91: Handle shutdown more safely
  tty/serial: at91: fix race condition in atmel_serial_remove
  tty/serial: at91: prevent null dereference in tasklet function

Mark Deneen (1):
  tty/serial: at91: reset rx_ring when port is shutdown

 drivers/tty/serial/atmel_serial.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
1.8.2.2
