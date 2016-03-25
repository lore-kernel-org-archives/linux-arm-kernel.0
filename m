From: davem@davemloft.net (David Miller)
Date: Fri, 25 Mar 2016 11:44:23 -0400 (EDT)
Subject: [PATCH v2 1/1] net: macb: remove BUG_ON() and reset the queue
 to handle RX errors
In-Reply-To: <1458898654-25864-1-git-send-email-cyrille.pitchen@atmel.com>
References: <1458898654-25864-1-git-send-email-cyrille.pitchen@atmel.com>
Message-ID: <20160325.114423.859412154606595295.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Fri, 25 Mar 2016 10:37:34 +0100

> This patch removes two BUG_ON() used to notify about RX queue corruptions
> on macb (not gem) hardware without actually handling the error.
> 
> The new code skips corrupted frames but still processes faultless frames.
> Then it resets the RX queue before restarting the reception from a clean
> state.
> 
> This patch is a rework of an older patch proposed by Neil Armstrong:
> http://patchwork.ozlabs.org/patch/371525/
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thank you.
