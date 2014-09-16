From: b38343@freescale.com (Robin Gong)
Date: Tue, 16 Sep 2014 11:52:05 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <5416D26A.4080707@ahsoftware.de>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <5416D26A.4080707@ahsoftware.de>
Message-ID: <20140916035204.GB20800@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 01:50:02PM +0200, Alexander Holler wrote:
> Am 10.09.2014 07:30, schrieb Robin Gong:
> >There is one weird data in rxfifo after one full rx/tx transfer
> >done sometimes. It looks a design issue and hard to workaround
> >totally, so disable dma functhion here. And will re-enable it
> >once the root cause found.
> 
> Hmm, I experience problems with DMA too but on uart3. I'm using the same
> workaround for the uart (I've just commented out the dma entries in the DT).
> The problem manifests itself here such, that brcm_patchram_plus
> hangs while uploading the firmware to a BCM4330 connected at uart3
> (reproducible).
> 
> So maybe there is a bug in the DMA-engine which not only effects
> SPI. Or both drivers contain the same error in handling DMA (maybe
> through c&p).
> But that's just specualtion from me, I haven't looked further into
> that problem.
> 
> Regards,
> 
> Alexander Holler
Thanks for your information share. But my issue should be caused by hardware,
since everything is ok if it runs on other i.mx6 chip. Is your board also based
on i.mx6 chip? If yes, hope you can raise your issue in freescale community or
contact with Andy whose mail address added in CC list fugang.duan at freescale.cm.
We have fix some bugs in UART DMA case.
