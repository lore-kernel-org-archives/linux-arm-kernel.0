From: simon.budig@kernelconcepts.de (Simon Budig)
Date: Tue,  2 Aug 2011 20:57:45 +0200
Subject: [PATCH] Fix for AMBA PL011 serial driver (tx_empty logic)
Message-ID: <1312311466-3814-1-git-send-email-simon.budig@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Budig <simon@budig.de>

Hi all.

This is a resend of a patch i submitted a few days ago although with a
mangled formatting. I don't know who maintains the PL011 AMBA driver, so
I hope someone steps up and helps me in bringing this upstream.

There is a problem with the logic of tx_empty in the amba-pl011 serial
port driver. Instead of checking for an empty FIFO it checks for a
not-full FIFO, which - according to Documentation/serial/driver - is
wrong.

Thanks,
        Simon

Simon Budig (1):
  Fix logic of tx_empty.

 drivers/tty/serial/amba-pl011.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
