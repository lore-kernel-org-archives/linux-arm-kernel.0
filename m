From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 Mar 2011 11:13:32 +0100
Subject: [PATCH 6/7] dmaengine: change the flags of request_irq()
In-Reply-To: <1300239773-4222-7-git-send-email-b32955@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-7-git-send-email-b32955@freescale.com>
Message-ID: <19840.36172.759509.889358@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> The GPMI may have many DMA channels, such as the imx23 has
> four DMA channels. All these DMA channels share the same interrupt.
> So change the flags from '0' to IRQF_SHARED, else there will be
> an EBUSY error returns.
> 
Problem is, that the mxs_dma_int_handler() need to be rewritten
for that since it currently does not support shared interrupts (as you
can easily find out by enabling CONFIG_DEBUG_SHIRQ.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
