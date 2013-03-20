From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 13:26:09 +0000
Subject: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
In-Reply-To: <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
 <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
Message-ID: <201303201326.09265.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013, Manjunathappa, Prakash wrote:
> Adds device tree support for davinci_mmc. Also add binding documentation.
> As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> option because of dependencies on EDMA and GPIO module DT support.

Shouldn't the binding at least specify the names for the DMA channels?
It's fine if the driver works without those, but I think there is no
strict dependency here: If dma_request_slave_channel does not find
a channel, the driver can just continue in PIO mode, and as soon
as the EDMA driver is merged, it will work with DMA.

	Arnd
