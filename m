From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:37:51 -0700
Subject: [PATCH v5 3/7] drivers: dma-coherent: Account dma_pfn_offset
 when used with device tree
In-Reply-To: <b04cb1f5-7e5a-04cb-272c-62be2d1ce6fa@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-4-git-send-email-vladimir.murzin@arm.com>
 <20170620134219.GA31496@infradead.org>
 <b04cb1f5-7e5a-04cb-272c-62be2d1ce6fa@arm.com>
Message-ID: <20170626093751.GA21570@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 02:50:34PM +0100, Robin Murphy wrote:
> On 20/06/17 14:42, Christoph Hellwig wrote:
> > Wouldn't the smal patch below solve the same issue in a simple way?
> 
> That assumes that all devices accessing a shared pool will have the same
>  dma_pfn_offset as the first one, which cannot strictly be relied upon
> (even if it is highly likely in practice).

Which seems like another argument why the global pool should be
a different implementation / interface than the per-device dma
mapping helpers..
