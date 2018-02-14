From: davem@davemloft.net (David Miller)
Date: Wed, 14 Feb 2018 14:24:03 -0500 (EST)
Subject: [net PATCH] Revert "net: thunderx: Add support for xdp redirect"
In-Reply-To: <151854116184.18303.13476104443853509134.stgit@firesoul>
References: <151854116184.18303.13476104443853509134.stgit@firesoul>
Message-ID: <20180214.142403.532212436685780119.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 13 Feb 2018 17:59:22 +0100

> This reverts commit aa136d0c82fcd6af14535853c30e219e02b2692d.
> 
> As I previously[1] pointed out this implementation of XDP_REDIRECT is
> wrong.  XDP_REDIRECT is a facility that must work between different
> NIC drivers.  Another NIC driver can call ndo_xdp_xmit/nicvf_xdp_xmit,
> but your driver patch assumes payload data (at top of page) will
> contain a queue index and a DMA addr, this is not true and worse will
> likely contain garbage.
> 
> Given you have not fixed this in due time (just reached v4.16-rc1),
> the only option I see is a revert.
> 
> [1] http://lkml.kernel.org/r/20171211130902.482513d3 at redhat.com
> 
> Cc: Sunil Goutham <sgoutham@cavium.com>
> Cc: Christina Jacob <cjacob@caviumnetworks.com>
> Cc: Aleksey Makarov <aleksey.makarov@cavium.com>
> Fixes: aa136d0c82fc ("net: thunderx: Add support for xdp redirect")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Applied, thanks Jesper.
