From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Jun 2017 06:23:24 -0700
Subject: [PATCH v5 2/7] dma: Add simple dma_noop_mmap
In-Reply-To: <1495621472-9323-3-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170620132324.GA11370@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:24:27AM +0100, Vladimir Murzin wrote:
> This patch adds a simple implementation of mmap to dma_noop_ops.

Currently we use dma_common_mmap as the generic fallback if a dma_ops
instance doesn't implement a mmap method.  Can you just fix up
dma_common_mmap for your nommu case - it looks like yours is basically
a subset.

In fact I suspect yours should call dma_mmap_from_coherent as well,
so the only different is the lack of pgprot_noncached call.
