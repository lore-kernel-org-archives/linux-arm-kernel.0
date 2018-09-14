From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Sep 2018 15:12:04 +0200
Subject: [RFC PATCH 2/3] dma-mapping: clear dma_ops pointer also on ARM
In-Reply-To: <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
Message-ID: <20180914131204.GA27141@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 05:17:15PM +0200, Wolfram Sang wrote:
> The generic fallback of arch_teardown_dma_ops() clears the dma_ops
> pointer but the ARM specific version does not. Rename the generic one,
> so it can be called from ARM specific one, too. This will ensure
> consistent behaviour.

Hmm.  I'd rather remove your new generic version entirely and move
the ops clearing into the two callers.
