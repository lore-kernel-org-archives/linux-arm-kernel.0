From: davem@davemloft.net (David Miller)
Date: Tue, 14 May 2013 00:48:02 -0700 (PDT)
Subject: [PATCH] mv643xx_eth: fix NAPI weight being > 64
In-Reply-To: <1368508632-13742-1-git-send-email-andrew@lunn.ch>
References: <1368508632-13742-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130514.004802.2003665831321985333.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 14 May 2013 07:17:12 +0200

> 3.10-rc1 issues the following warning:
> 
> netif_napi_add() called with weight 128 on device eth%d
> 
> This patch reduce the weight to 64.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

We have a macro, NAPI_POLL_WEIGHT, for this, please use it.
