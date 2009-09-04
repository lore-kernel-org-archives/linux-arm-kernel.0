From: mtittinge@hotmail.com (Marc Titinger)
Date: Fri, 4 Sep 2009 13:22:12 +0200
Subject: i.MX31 : need help with 32bit-DMA read from SSI1-FIFO0 to external
	memory
Message-ID: <BLU105-W164D922827059FEC404EB3BAEE0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org












Hello kernel gurus, 

I have an audio driver adapted from the alsa driver for the "PMIC" companion chip found on most i.MX31eval boards. 
DMA read and write from/to the SSI1 fifo0 works OK with 8 bit and 16 bit wordlength set , but when I request a DMA read with 

mxc_dma_request(MXC_DMA_SSI1_24BIT_RX0, "..."); 

the transfer seems to abort for some reason and by the time the callback is called the destination buffer is only partially filled with data from the SSI. According to the iMX31 manual 32bit r/w are possible from/to the SSI fifo0, and the DMA write to the fifo works as expected. 

Has anyone successfully programmed a DMA read from the SSI1 fifo (register SRX0) to memory with a wordlength of 32 bits on i.MX31, and may know about any pitfall ?

Thanks and regards,
Marc Titinger.





Un avatar ? votre image ?  Cr?ez votre mini-moi !
_________________________________________________________________
Tchattez en direct en en vid?o avec vos amis !  
http://www.windowslive.fr/messenger/
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090904/9e51a34d/attachment.htm>
