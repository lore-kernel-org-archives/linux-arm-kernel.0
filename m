From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 May 2010 13:19:14 +0200
Subject: [PATCH v3] PXA DMA-capable PATA driver
In-Reply-To: <201005180112.30792.marek.vasut@gmail.com> (Marek Vasut's message
	of "Tue\, 18 May 2010 01\:12\:30 +0200")
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com>
	<201005180112.30792.marek.vasut@gmail.com>
Message-ID: <87pr0s6swd.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne ?t 18. kv?tna 2010 01:09:28 Marek Vasut napsal(a):
>> This patch adds a driver for a harddrive attached to PXA address and data
>> bus. Unlike pata_platform, this driver allows usage of PXA DMA controller,
>> making the transmission speed 3x higher.
>
> Hey guys, all the issues pointed out should be addressed. See below.
> Cheers!

For the first iteration, you can have my :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

For the next iteration, it would be good to :
 - fix the error path in pxa_ata_probe()
   => if dmam_alloc_coherent() fails
   => if pxa_request_dma() fails
 - in pxa_ata_remove()
   => maybe call devm_iounmap()

--
Robert
