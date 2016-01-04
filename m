From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 4 Jan 2016 11:32:00 +0000
Subject: [Xen-devel] [PATCH v2 33/34] xenbus: use virt_xxx barriers
In-Reply-To: <1451572003-2440-34-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-34-git-send-email-mst@redhat.com>
Message-ID: <568A5830.9000501@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/12/15 19:10, Michael S. Tsirkin wrote:
> drivers/xen/xenbus/xenbus_comms.c uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.

Acked-by: David Vrabel <david.vrabel@citrix.com>

If you're feeling particularly keen there's a rmb() consume_one_event()
in drivers/xen/events/events_fifo.c that can be converted to virt_rmb()
as well.

David
