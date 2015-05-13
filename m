From: davem@davemloft.net (David Miller)
Date: Wed, 13 May 2015 18:07:44 -0400 (EDT)
Subject: [net-next PATCH] net: Reserve skb headroom and set skb->dev
 even if using __alloc_skb
In-Reply-To: <20150513203413.8252.98057.stgit@ahduyck-vm-fedora22>
References: <20150513182738.GA28201@saruman.tx.rr.com>
 <20150513203413.8252.98057.stgit@ahduyck-vm-fedora22>
Message-ID: <20150513.180744.973850573845788118.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Wed, 13 May 2015 13:34:13 -0700

> When I had inlined __alloc_rx_skb into __netdev_alloc_skb and
> __napi_alloc_skb I had overlooked the fact that there was a return in the
> __alloc_rx_skb.  As a result we weren't reserving headroom or setting the
> skb->dev in certain cases.  This change corrects that by adding a couple of
> jump labels to jump to depending on __alloc_skb either succeeding or failing.
> 
> Fixes: 9451980a6646 ("net: Use cached copy of pfmemalloc to avoid accessing page")
> Reported-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

Applied, thanks.
