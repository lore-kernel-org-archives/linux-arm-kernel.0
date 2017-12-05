From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Tue, 5 Dec 2017 12:34:55 +0000
Subject: [PATCH v2 0/3] ARM: davinci: fix eDMA for DM365
In-Reply-To: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>,
 <20171204133359.45625-1-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>,
 <20171204133359.45625-1-amery@hanoverdisplays.com>
Message-ID: <20171205123458.97837-1-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, as an intermediate step toward migrating a davinci dm365 based product from 2.6.32.71
to 4.14(.3+) I'm trying to get the dm365 evm (evaluation board) to work

The very first problem is `edma: probe of edma.0 failed with error -5` caused by dm365 not
been included on some refactoring done by Peter Ujfalusi in 2015 which got solved by the
cherry-picking the following changes into dm365.c

* cef5b0da4019 2015-10-14 Peter Ujfalusi ARM: davinci: Add dma_mask to eDMA devices
* 7ab388e85faa 2015-10-14 Peter Ujfalusi ARM: davinci: Use platform_device_register_full() to create pdev for eDMA

Changes since v1:
* fix dumb typo on 1/2
* add extra change (3/3) correcting the name of mmc devices
