From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 11:50:54 +0100
Subject: arm: mvebu: Various mvebu clock fixes/improvements
In-Reply-To: <20121120110636.7306b00e@skate>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119182701.GS14643@lunn.ch> <20121120104042.224e51a5@skate>
 <20121120094345.GO10259@lunn.ch> <20121120110636.7306b00e@skate>
Message-ID: <20121120115054.6425563a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 20 Nov 2012 11:06:36 +0100, Thomas Petazzoni wrote:

> Hum, I will check this. But I think that the point that lead me to look
> into the clocks is that when I added:
> 
> 	clocks = <&gate_clk xx>;
> 
> to my Ethernet DT nodes, then clk_get() was returning an error, until I
> enabled the gating clocks. But I'll double check that.

It is indeed not fatal with SATA because the driver tries to get the
clock, and if it can't, the driver just gives up.

However, with the mvneta driver, it really wants the clock (the driver
needs at some point to do a clk_get_rate(), so we have to have a
clock), and in this case, not having the gating clocks is an issue.

That said, since the mvneta driver is new, I don't mind if it is
non-functional up to the point where the gating clocks are enabled.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
