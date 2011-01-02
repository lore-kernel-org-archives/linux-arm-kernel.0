From: rabin@rab.in (Rabin Vincent)
Date: Sun, 2 Jan 2011 11:24:24 +0530
Subject: mmci: bug in DATABLOCKEND handling?
Message-ID: <AANLkTimdMfdOyj8bnfmYkuz89FFuWOirsVbyQ5jedDpZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MMCI, on variants which use the DATABLOCKEND interrupt, if we cross
more than one block boundary in the loop inside mmc_pio_read() or
mmci_pio_write(), when the DATABLOCKEND irq is handled after interrupts
are enabled in mmci_pio_irq(), won't the block count be incorrect
because we would consider that only one block has been transferred, when
in fact it has been two?  Or can this never happen for some reason?
