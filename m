From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Oct 2018 13:08:31 +0100
Subject: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
In-Reply-To: <20181030093139.10226-1-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
Message-ID: <20181030120831.GC27873@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 10:31:37AM +0100, Kurt Kanzenbach wrote:
> Hi,
> 
> the Xilinx mdio wait functions may return false positives under certain
> circumstances: If the functions get preempted between reading the corresponding
> mdio register and checking for the timeout, they could falsely indicate a
> timeout.

Hi Kurt

I wonder if it would be possible to add a readx_poll_timeout() which
passes two parameters to op()?

I keep seeing this basic problem in various drivers, and try to point
people towards readx_poll_timeout(), but it is not the best of fit.

Otherwise, could you add a axienet_ior_read_mcr(lp), and use
readx_poll_timeout() as is?

       Andrew
