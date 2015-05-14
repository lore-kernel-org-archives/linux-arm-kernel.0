From: balbi@ti.com (Felipe Balbi)
Date: Wed, 13 May 2015 20:43:20 -0500
Subject: [net-next PATCH] net: Reserve skb headroom and set skb->dev even
 if using __alloc_skb
In-Reply-To: <7h8ucs6tzc.fsf@deeprootsystems.com>
References: <20150513182738.GA28201@saruman.tx.rr.com>
 <20150513203413.8252.98057.stgit@ahduyck-vm-fedora22>
 <7h8ucs6tzc.fsf@deeprootsystems.com>
Message-ID: <20150514014320.GA20006@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 02:35:51PM -0700, Kevin Hilman wrote:
> Alexander Duyck <alexander.h.duyck@redhat.com> writes:
> 
> > When I had inlined __alloc_rx_skb into __netdev_alloc_skb and
> > __napi_alloc_skb I had overlooked the fact that there was a return in the
> > __alloc_rx_skb.  As a result we weren't reserving headroom or setting the
> > skb->dev in certain cases.  This change corrects that by adding a couple of
> > jump labels to jump to depending on __alloc_skb either succeeding or failing.
> >
> > Fixes: 9451980a6646 ("net: Use cached copy of pfmemalloc to avoid accessing page")
> > Reported-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> 
> Tested this on top of next-20150513 on an ARM/OMAP
> (am335x-boneblack.dts) an it fixes the boot problem for me.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Yeah, I know it's too late, but I also tested on my AM437x SK.

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/43ae3a92/attachment.sig>
