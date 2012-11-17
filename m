From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 14:54:35 +0100
Subject: [PATCH 1/2] clk: mvebu: armada 370/XP add clock gating control
 provider for DT
In-Reply-To: <50A75BB4.4070003@free-electrons.com>
References: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
 <1353088920-17458-1-git-send-email-gregory.clement@free-electrons.com>
 <1353088920-17458-2-git-send-email-gregory.clement@free-electrons.com>
 <20121117082602.GF24569@lunn.ch>
 <50A75BB4.4070003@free-electrons.com>
Message-ID: <20121117135435.GA13479@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What is the ddr clock for? Does bad things happen if you turn it off?
> > Kirkwood has a similar clock, dunit, which i decided not to export,
> > since when you turn it off, the whole SoC locks up.
> 
> Well of course if you code run in DDR then it could be a problem. But
> I think it could be useful to turn it off when going to suspend, it
> the DDR can do self-refresh. In this case it should be possible to run
> the code from SRAM or L2 Cache.

O.K. Just watch out for the lateinit call in the clock framework.

     Andrew
