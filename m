From: mst@redhat.com (Michael S. Tsirkin)
Date: Fri, 10 Feb 2017 19:16:10 +0200
Subject: [PATCH] virtio: Try to untangle DMA coherency
In-Reply-To: <20170209183118.GI19397@arm.com>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
 <20170201195732-mutt-send-email-mst@kernel.org>
 <20170201182659.GM8177@arm.com>
 <20170201210648-mutt-send-email-mst@kernel.org>
 <20170202112614.GB30577@arm.com>
 <bb041fbe-3fde-0dc1-ae28-cca5acfe9dc5@arm.com>
 <20170202182224-mutt-send-email-mst@kernel.org>
 <20170202164049.GI13839@arm.com>
 <20170209201341-mutt-send-email-mst@kernel.org>
 <20170209183118.GI19397@arm.com>
Message-ID: <20170210191409-mutt-send-email-mst@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 06:31:18PM +0000, Will Deacon wrote:
> On ARM (and other archs such as
> Power), having a mismatch between a cacheable and a non-cacheable mapping
> can result in a loss of coherency between the two (for example, if the
> non-cacheable gues accesses bypass the cache, but the cacheable host
> accesses allocate in the cache).

I guess it's an optimization to avoid cache snoops for non-cacheable accesses?

-- 
MST
