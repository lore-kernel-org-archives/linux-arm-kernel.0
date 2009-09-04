From: lrg@kernel.org (Liam Girdwood)
Date: Fri, 04 Sep 2009 16:29:57 +0100
Subject: i.MX31 : need help with 32bit-DMA read from SSI1-FIFO0 to
	external memory
In-Reply-To: <BLU105-W164D922827059FEC404EB3BAEE0@phx.gbl>
References: <BLU105-W164D922827059FEC404EB3BAEE0@phx.gbl>
Message-ID: <1252078197.5798.118.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-04 at 13:22 +0200, Marc Titinger wrote:
> 
> Hello kernel gurus, 
> 
> I have an audio driver adapted from the alsa driver for the "PMIC"
> companion chip found on most i.MX31eval boards. 
> DMA read and write from/to the SSI1 fifo0 works OK with 8 bit and 16
> bit wordlength set , but when I request a DMA read with 
> 
> mxc_dma_request(MXC_DMA_SSI1_24BIT_RX0, "..."); 
> 
> the transfer seems to abort for some reason and by the time the
> callback is called the destination buffer is only partially filled
> with data from the SSI. According to the iMX31 manual 32bit r/w are
> possible from/to the SSI fifo0, and the DMA write to the fifo works as
> expected. 
> 
> Has anyone successfully programmed a DMA read from the SSI1 fifo
> (register SRX0) to memory with a wordlength of 32 bits on i.MX31, and
> may know about any pitfall ?
> 

Iirc, 24bit SDMA was broken (causing a domain violation) due to a SDMA
script bug in the FSL BSP kernels. It may be worth contacting Freescale
for updated SDMA scripts.

If you do get updated scripts from Freescale please post them here as
they can also be used with the ASoC i.MX31 driver.

Thanks

Liam 
