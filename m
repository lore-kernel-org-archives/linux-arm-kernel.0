From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 13 Apr 2011 16:03:44 +0400
Subject: [PATCH 2.6.39 v2] V4L: videobuf-dma-contig: fix mmap_mapper broken
	on	ARM
In-Reply-To: <201104122306.34909.jkrzyszt@tis.icnet.pl>
References: <201104122306.34909.jkrzyszt@tis.icnet.pl>
Message-ID: <4DA59120.1070402@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-04-2011 1:06, Janusz Krzysztofik wrote:

> After switching from mem->dma_handle to virt_to_phys(mem->vaddr) used
> for obtaining page frame number passed to remap_pfn_range()
> (commit 35d9f510b67b10338161aba6229d4f55b4000f5b), videobuf-dma-contig

    Please specify the commit summary -- for the human readers.

> stopped working on my ARM based board. The ARM architecture maintainer,
> Russell King, confirmed that using something like
> virt_to_phys(dma_alloc_coherent()) is not supported on ARM, and can be
> broken on other architectures as well. The author of the change, Jiri
> Slaby, also confirmed that his code may not work on all architectures.

> The patch tries to solve this regression by using
> virt_to_phys(bus_to_virt(mem->dma_handle)) instead of problematic
> virt_to_phys(mem->vaddr). I think this should work even if those
> translations would occure inaccurate for DMA addresses, since possible
> errors introduced by both translations, performed in opposite
> directions, should compensate.

> Tested on ARM OMAP1 based Amstrad Delta board.

> Signed-off-by: Janusz Krzysztofik<jkrzyszt@tis.icnet.pl>

WBR, Sergei
