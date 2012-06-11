From: davem@davemloft.net (David Miller)
Date: Mon, 11 Jun 2012 13:13:55 -0700 (PDT)
Subject: [PATCH] net: lpc_eth: fix tx completion
In-Reply-To: <1339435296.6001.2484.camel@edumazet-glaptop>
References: <4FD5AE1D.9030807@antcom.de>
 <1339404835.6001.1788.camel@edumazet-glaptop>
 <1339435296.6001.2484.camel@edumazet-glaptop>
Message-ID: <20120611.131355.1151863180696891268.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 11 Jun 2012 19:21:36 +0200

> From: Eric Dumazet <edumazet@google.com>
> 
> __lpc_handle_xmit() has two bugs :
> 
> 1) It can leak skbs in case TXSTATUS_ERROR is set
> 
> 2) It can wake up txqueue while no slot was freed.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Roland Stigge <stigge@antcom.de>
> Tested-by: Roland Stigge <stigge@antcom.de>

Applied and queued up for -stable.
