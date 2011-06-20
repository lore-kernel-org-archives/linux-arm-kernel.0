From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 21 Jun 2011 00:14:14 +0900
Subject: [Linaro-mm-sig] [PATCH 7/8] common: dma-mapping: change
	alloc/free_coherent method to more generic alloc/free_attrs
In-Reply-To: <20110620150610.GG26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
	<20110620150610.GG26089@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimJDpKR4Nm8Lz3V1Yov=07wadAmfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 12:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Wrong - there is a difference. ?For pre-ARMv6 CPUs, it returns memory
> with different attributes from DMA coherent memory.
>
> And we're not going to sweep away pre-ARMv6 CPUs any time soon. ?So
> you can't ignore dma_alloc_writecombine() which must remain to sanely
> support framebuffers.
>
OK. Thanks.

Then, I think we can implement dma_alloc_writecombine() away from dma_map_ops.
IMHO, those devices that use dma_alloc_writecombine() are enough with
the default dma_map_ops.
Removing a member from dma_map_ops is too heavy work.
