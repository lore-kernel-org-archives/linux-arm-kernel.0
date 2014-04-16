From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 15:37:34 -0400 (EDT)
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416191825.GA22246@redhat.com>
References: <20140416164310.GA15739@redhat.com>
 <20140416.133831.364304583096073299.davem@davemloft.net>
 <20140416191825.GA22246@redhat.com>
Message-ID: <20140416.153734.675854782374654510.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 16 Apr 2014 21:18:25 +0200

> The last question... area->page = alloc_page(GFP_HIGHUSER), and I am
> not sure that arch/arm/mm/highmem.c:kmap_atomic() can't break the
> aliasing, __fix_to_virt() in this case will use the same (per-cpu) idx.
> 
> Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
> care, but could you please ack/nack my understanding?

Good point, it might therefore make sense to use a low-mem page.
