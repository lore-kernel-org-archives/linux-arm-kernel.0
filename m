From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jan 2017 18:16:07 +0000
Subject: next-20170110 build: 1 failures 4 warnings (next-20170110)
In-Reply-To: <E1cQqkO-0005XB-2K@optimist>
References: <E1cQqkO-0005XB-2K@optimist>
Message-ID: <20170110181607.dp6giaxyeczykmv4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 07:21:32AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/net/ethernet/ti/netcp_core.c:1951:28: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]

caused by 6a8162e99ef344 (net: netcp: store network statistics in 64
bits).  It's assigning the function

  static struct rtnl_link_stats64 *
  netcp_get_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)

to ndo_get_stats64 which expects a function returning void.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/7194228e/attachment.sig>
