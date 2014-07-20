From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 20 Jul 2014 08:20:49 +0200
Subject: FEC driver hangs hardware on i.MX6SX
In-Reply-To: <20140720025732.GF8537@dragon>
References: <20140720025732.GF8537@dragon>
Message-ID: <20140720062048.GB5686@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 10:57:33AM +0800, Shawn Guo wrote:
> 
> I think the cause is that PTP is still accessing registers after FEC
> driver calls fec_enet_clk_enable(ndev, false) to disable FEC clocks.
> Can you please try to provide a fix for this regression soon?

What do you mean by, "PTP is still accessing registers"?

The only access to any register is through the driver, and the driver
can and should make sure all register accesses are safe.

Thanks,
Richard
