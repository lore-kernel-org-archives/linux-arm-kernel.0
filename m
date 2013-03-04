From: davem@davemloft.net (David Miller)
Date: Mon, 04 Mar 2013 14:15:07 -0500 (EST)
Subject: [PATCH v3 1/1 net-next] net: fec: put tx to napi poll function
 to fix dead lock
In-Reply-To: <1362368065-5809-1-git-send-email-Frank.Li@freescale.com>
References: <1362368065-5809-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130304.141507.1100300683952317840.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Mon, 4 Mar 2013 11:34:25 +0800

> up stack ndo_start_xmit already hold lock.
> fec_enet_start_xmit needn't spin lock.
> stat_xmit just update fep->cur_tx
> fec_enet_tx just update fep->dirty_tx
> 
> Reserve a empty bdb to check full or empty
> cur_tx == dirty_tx    means full
> cur_tx == dirty_tx +1 means empty
> 
> So needn't is_full variable.
 ...
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
