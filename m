From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Tue, 29 Nov 2011 09:21:39 +0100
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
 <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111129082139.GG27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 08:02:53AM +0000, Chen Peter-B29397 wrote:
> > 
> > In the driver you would then do a clk_get() for those three clocks
> > independent of the platform.
> > 
> The reason why I add this patch is not for clk things, it is for:
> 1. Coming device driver
> 2. Handle things difference between SoC's. not only clk, others
> like low power, wakeup, hsic, or other will comes in future.

The ehci is a standardized core. Please be *very* careful with what you
add to this driver. As said in my other mail, the real differences are
in the phys and the phy handling code should not be in the ehci-mxc
driver at all.
Rather than adding random phy code to the driver you should write phy
drivers. If you still think that there is code missing in this driver
please explain further.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
