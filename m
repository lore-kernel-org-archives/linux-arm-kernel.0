From: davem@davemloft.net (David Miller)
Date: Tue, 30 Oct 2018 11:25:28 -0700 (PDT)
Subject: [PATCH 2/2] net: xilinx_emaclite: recheck condition after
 timeout in mdio_wait()
In-Reply-To: <20181030093139.10226-3-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-3-kurt@linutronix.de>
Message-ID: <20181030.112528.308459967263600648.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Tue, 30 Oct 2018 10:31:39 +0100

> The function could report a false positive if it gets preempted between reading
> the XEL_MDIOCTRL_OFFSET register and checking for the timeout.  In such a case,
> the condition has to be rechecked to avoid false positives.
> 
> Therefore, check for expected condition even after the timeout occurred.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Same objections as your previous patch.

This isn't fixing anything.
