From: davem@davemloft.net (David Miller)
Date: Thu, 19 Dec 2013 19:21:36 -0500 (EST)
Subject: [PATCH v2] net: mvmdio: fix interrupt timeout handling
In-Reply-To: <1387458588-17231-1-git-send-email-leigh@solinno.co.uk>
References: <52B2D97F.4070200@gmail.com>
 <1387458588-17231-1-git-send-email-leigh@solinno.co.uk>
Message-ID: <20131219.192136.1089859619183118911.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leigh Brown <leigh@solinno.co.uk>
Date: Thu, 19 Dec 2013 13:09:48 +0000

> This version corrects the whitespace issue.
> 
> orion_mdio_wait_ready uses wait_event_timeout to wait for the
> SMI interrupt to fire.  wait_event_timeout waits for between
> "timeout - 1" and "timeout" jiffies.  In this case a 1ms timeout
> when HZ is 1000 results in a wait of 0 to 1 jiffies, causing
> premature timeouts.
> 
> This fix ensures a minimum timeout of 2 jiffies, ensuring
> wait_event_timeout will always wait at least 1 jiffie.
> 
> Issue reported by Nicolas Schichan.
> 
> Tested-by: Nicolas Schichan <nschichan@freebox.fr>
> Signed-off-by: Leigh Brown <leigh@solinno.co.uk>

Applied, and queued up for -stable.

I wonder how many other wait_event_timeout() users potentially have
this problem.
