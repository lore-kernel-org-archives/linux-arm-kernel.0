From: mbizon@freebox.fr (Maxime Bizon)
Date: Fri, 31 Oct 2014 22:07:10 +0100
Subject: DMA allocations from CMA and fatal_signal_pending check
In-Reply-To: <20141031082818.GB14642@js1304-P5Q-DELUXE>
References: <544FE9BE.6040503@gmail.com>
 <20141031082818.GB14642@js1304-P5Q-DELUXE>
Message-ID: <1414789630.14835.49.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2014-10-31 at 17:28 +0900, Joonsoo Kim wrote:

> I guess that it is okay that bcm_sysport_open() return -EINTR?

actually, since CMA alloc is hidden behind dma_alloc_coherent(), all you
get back is NULL and then return ENOMEM.

-- 
Maxime
