From: davem@davemloft.net (David Miller)
Date: Mon, 09 Mar 2015 22:41:18 -0400 (EDT)
Subject: [PATCH] rds: avoid potential stack overflow
In-Reply-To: <17806664.ym3oszzFIH@wuerfel>
References: <17806664.ym3oszzFIH@wuerfel>
Message-ID: <20150309.224118.1760532839925378471.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 09 Mar 2015 13:06:52 +0100

> The rds_iw_add_conn function stores a large 'struct rds_sock' object
> on the stack in order to pass a pair of addresses.

As Sowmini pointed out, this function is not the top-level
guilty one, it's rds_iw_update_cm_id.

Please respin this with a corrected commit message, thanks.
