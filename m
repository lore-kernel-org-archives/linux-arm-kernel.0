From: mturquette@ti.com (Mike Turquette)
Date: Sun, 18 Nov 2012 20:30:34 -0800
Subject: [PATCH 1/2] clk: mvebu: armada 370/XP add clock gating control
 provider for DT
In-Reply-To: <20121117135435.GA13479@lunn.ch>
References: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
 <1353088920-17458-1-git-send-email-gregory.clement@free-electrons.com>
 <1353088920-17458-2-git-send-email-gregory.clement@free-electrons.com>
 <20121117082602.GF24569@lunn.ch> <50A75BB4.4070003@free-electrons.com>
 <20121117135435.GA13479@lunn.ch>
Message-ID: <20121119043034.21126.92888@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andrew Lunn (2012-11-17 05:54:35)
> > > What is the ddr clock for? Does bad things happen if you turn it off?
> > > Kirkwood has a similar clock, dunit, which i decided not to export,
> > > since when you turn it off, the whole SoC locks up.
> > 
> > Well of course if you code run in DDR then it could be a problem. But
> > I think it could be useful to turn it off when going to suspend, it
> > the DDR can do self-refresh. In this case it should be possible to run
> > the code from SRAM or L2 Cache.
> 
> O.K. Just watch out for the lateinit call in the clock framework.
> 

CLK_IGNORE_UNUSED is the flag you want for this situation.

Regards,
Mike

>      Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
