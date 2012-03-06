From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 6 Mar 2012 17:11:36 +0200
Subject: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Message-ID: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- patch2:
  * fixed the timeout for waiting for ST_IO_CHAIN == 1
  * added clear for ST_IO_CHAIN bit (as per spec + implementation in patch 1)
  * replaced the timeout at the end of function with a simple register
    readback (timing out on a register value that we are clearing does
    not make that much sense, the bit is cleared the very first time CPU
    manages to read it)
- patch5:
  * added spinlock for protecting io_chain_trigger operation

Tested on omap3 beagle + omap4 blaze. Also did measurements for the
cost of IO chain trigger operation with ARM performance counters:

- omap3 approx 7...8us
- omap4 approx 2...4us

-Tero
