From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Fri, 08 Aug 2014 15:15:58 +0200
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
Message-ID: <1407503758.19455.1.camel@sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Kernel 3.16 (running on 3.16.0) the ethernet (fec) connection
stops working after exchanging very little data. Sometimes it comes back
again for some seconds and drops again. No clues in dmesg.

After increasing TX_RING_SIZE in "drivers/net/ethernet/freescale/fec.h"
from 512 to 1024 the connection seems to stay stable (judging after
about half an hour of testing) but I really don't have experience with
kernel driver hacking, so I'm not sure what I'm doing here.
