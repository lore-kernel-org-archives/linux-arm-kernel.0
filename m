From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 11 Jun 2012 21:18:48 +0200
Subject: [PATCH 1/3] net: lpc_eth: Replace WARN() trace with simple
 pr_warn()
In-Reply-To: <4FD5B9C8.4020800@antcom.de>
References: <1339401793-12258-1-git-send-email-stigge@antcom.de>
 <1339403108.6001.1697.camel@edumazet-glaptop> <4FD5AE1D.9030807@antcom.de>
 <20120611.020352.1962768244524496467.davem@davemloft.net>
 <4FD5B9C8.4020800@antcom.de>
Message-ID: <1339442328.6001.2602.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-11 at 11:26 +0200, Roland Stigge wrote:

> Is it sensible at this point to increase the TX buffers anyway? For
> different reasons of course: We have enough SRAM available and TX
> buffers (16->32) are still more than RX buffers (48).

I doubt it has any impact on performance for a 100Mbit link ?

One thing that could be done would be to free skbs in
lpc_eth_hard_start_xmit() instead of __lpc_handle_xmit()
