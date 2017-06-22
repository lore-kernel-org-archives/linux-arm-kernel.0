From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 22 Jun 2017 13:46:09 +0100
Subject: [PATCH v5 2/7] dma: Add simple dma_noop_mmap
In-Reply-To: <20170620132324.GA11370@infradead.org>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-3-git-send-email-vladimir.murzin@arm.com>
 <20170620132324.GA11370@infradead.org>
Message-ID: <8670225a-30a5-d567-0979-c96fd115a50f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 14:23, Christoph Hellwig wrote:
> On Wed, May 24, 2017 at 11:24:27AM +0100, Vladimir Murzin wrote:
>> This patch adds a simple implementation of mmap to dma_noop_ops.
> 
> Currently we use dma_common_mmap as the generic fallback if a dma_ops
> instance doesn't implement a mmap method.  Can you just fix up
> dma_common_mmap for your nommu case - it looks like yours is basically
> a subset.

dma_common_map() is guarded with CONFIG_MMU and I'm not dare to change that
since I have no idea 1) why it was done 2) how it affects other arches :(

> 
> In fact I suspect yours should call dma_mmap_from_coherent as well,
> so the only different is the lack of pgprot_noncached call.
> 

OK, I'll add a call to dma_mmap_from_coherent().

Cheers
Vladimir
