From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Mon, 4 Dec 2017 13:33:57 +0000
Subject: [PATCH 0/2] ARM: davinci: fix eDMA probing for dm365
Message-ID: <20171204133359.45625-1-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, as an intermediate step toward migrating a davinci dm365 based product from 2.6.32.71
to 4.14(.3+) I'm trying to get the dm365 evm (evaluation board) to work

The very first problem is `edma: probe of edma.0 failed with error -5` caused by dm365 not
been included on some refactoring done by Peter Ujfalusi in 2015 which got solved by the
cherry-picking the following changes into dm365.c

* cef5b0da4019 2015-10-14 Peter Ujfalusi ARM: davinci: Add dma_mask to eDMA devices
* 7ab388e85faa 2015-10-14 Peter Ujfalusi ARM: davinci: Use platform_device_register_full() to create pdev for eDMA
