From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 15 Sep 2014 13:50:02 +0200
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410327012-31185-1-git-send-email-b38343@freescale.com>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
Message-ID: <5416D26A.4080707@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.09.2014 07:30, schrieb Robin Gong:
> There is one weird data in rxfifo after one full rx/tx transfer
> done sometimes. It looks a design issue and hard to workaround
> totally, so disable dma functhion here. And will re-enable it
> once the root cause found.

Hmm, I experience problems with DMA too but on uart3. I'm using the same
workaround for the uart (I've just commented out the dma entries in the DT).
The problem manifests itself here such, that brcm_patchram_plus hangs 
while uploading the firmware to a BCM4330 connected at uart3 (reproducible).

So maybe there is a bug in the DMA-engine which not only effects SPI. Or 
both drivers contain the same error in handling DMA (maybe through c&p).
But that's just specualtion from me, I haven't looked further into that 
problem.

Regards,

Alexander Holler
