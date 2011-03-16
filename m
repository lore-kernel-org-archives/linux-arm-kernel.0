From: B32955@freescale.com (Huang Shijie-B32955)
Date: Wed, 16 Mar 2011 12:31:26 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggNi83XSBkbWFlbmdpbmU6IGNoYW5nZSB0aGUgZmxh?=
	=?utf-8?Q?gs_of_request=5Firq()?=
In-Reply-To: <19840.36172.759509.889358@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-7-git-send-email-b32955@freescale.com>,
	<19840.36172.759509.889358@ipc1.ka-ro>
Message-ID: <14C4E31473AF7E4B98176CB73615181C100086@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:
   Ok. I'd better ask Shawn Guo to fix the problem.

Huang Shijie


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
