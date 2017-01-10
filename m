From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 11 Jan 2017 07:21:41 +1100
Subject: next-20170110 build: 1 failures 4 warnings (next-20170110)
In-Reply-To: <20170110181607.dp6giaxyeczykmv4@sirena.org.uk>
References: <E1cQqkO-0005XB-2K@optimist>
 <20170110181607.dp6giaxyeczykmv4@sirena.org.uk>
Message-ID: <20170111072131.51449059@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 10 Jan 2017 18:16:07 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 10, 2017 at 07:21:32AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ../drivers/net/ethernet/ti/netcp_core.c:1951:28: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]  
> 
> caused by 6a8162e99ef344 (net: netcp: store network statistics in 64
> bits).  It's assigning the function
> 
>   static struct rtnl_link_stats64 *
>   netcp_get_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)
> 
> to ndo_get_stats64 which expects a function returning void.

Yes, but only because commit bc1f44709cf2 ("net: make ndo_get_stats64 a
void function") entered the net-next tree on the same day ... so it
needs a followup fixup patch for this new usage.

-- 
Cheers,
Stephen Rothwell
