From: davem@davemloft.net (David Miller)
Date: Thu, 07 Feb 2013 23:37:08 -0500 (EST)
Subject: [PATCH v3 2/2 net-next] net: fec: fix spin_lock dead lock
In-Reply-To: <1360198799-25173-2-git-send-email-Frank.Li@freescale.com>
References: <1360198799-25173-1-git-send-email-Frank.Li@freescale.com>
 <1360198799-25173-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130207.233708.2170335376726433338.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 7 Feb 2013 08:59:59 +0800

> =========================================================
> [ INFO: possible irq lock inversion dependency detected ]
> 3.8.0-rc5+ #82 Not tainted
> ---------------------------------------------------------
> swapper/0/0 just changed the state of lock:
>  (&(&fep->hw_lock)->rlock){..-...}, at: [<8034e2f8>] fec_enet_start_xmit+0x48/0x                      2cc
> but this lock took another, SOFTIRQ-unsafe lock in the past:
> (prepare_lock){+.+.+.}
> 
> and interrupts could create inverse lock ordering between them.
> other info that might help us debug this:
> Possible interrupt unsafe locking scenario:
> 
> CPU0				CPU1
> ----				----
> lock(prepare_lock);
> 				local_irq_disable()
> 				lock(&(&fep->hw_lock)->rlock);
> 				lock(prepare_lock);
> <Interrupt>
> lock(&(&fep->hw_lock)->rlock);
> 
> *** DEADLOCK ***
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
