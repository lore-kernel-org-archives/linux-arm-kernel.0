From: baijiaju1990@gmail.com (Jia-Ju Bai)
Date: Tue, 12 Dec 2017 15:30:01 +0800
Subject: [BUG] drivers/spi: a possible sleep-in-atomic bug in atmel_spi_remove
Message-ID: <229fd3a0-b88e-5b86-e26e-ec6b79d37a2c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to drivers/spi/spi-atmel.c, the kernel module may sleep under 
a spinlock.
The function call path is:
atmel_spi_remove (acquire the spinlock)
   atmel_spi_release_dma
     dma_release_channel
       mutex_lock --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
