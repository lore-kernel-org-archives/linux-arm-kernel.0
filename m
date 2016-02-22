From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Feb 2016 19:19:18 +0900
Subject: next-20160222 build: 5 failures 9 warnings (next-20160222)
In-Reply-To: <E1aXlz4-000486-Pb@optimist>
References: <E1aXlz4-000486-Pb@optimist>
Message-ID: <20160222101918.GY18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 08:36:46AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/net/ethernet/ti/netcp_core.c:1846:31: error: invalid type argument of '->' (have 'struct tc_to_netdev')
> ../drivers/net/ethernet/ti/netcp_core.c:1851:35: error: invalid type argument of '->' (have 'struct tc_to_netdev')
> ../drivers/net/ethernet/ti/netcp_core.c:1855:8: error: invalid type argument of '->' (have 'struct tc_to_netdev')
> ../drivers/net/ethernet/ti/netcp_core.c:1856:28: error: invalid type argument of '->' (have 'struct tc_to_netdev')
> ../drivers/net/ethernet/ti/netcp_core.c:1857:21: error: invalid type argument of '->' (have 'struct tc_to_netdev')

caused by commit 16e5cc647173a (net: rework setup_tc ndo op to consume
general tc operand) in the net-next tree which looks to have a missing *
in the rewrite of the function arguments for that driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/87ece996/attachment-0001.sig>
