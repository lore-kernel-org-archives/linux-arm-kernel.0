From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 11:06:36 +0100
Subject: arm: mvebu: Various mvebu clock fixes/improvements
In-Reply-To: <20121120094345.GO10259@lunn.ch>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119182701.GS14643@lunn.ch> <20121120104042.224e51a5@skate>
 <20121120094345.GO10259@lunn.ch>
Message-ID: <20121120110636.7306b00e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 20 Nov 2012 10:43:45 +0100, Andrew Lunn wrote:

> > Unfortunately, I don't think putting patch 1 last will work either: in
> > patch 7, I change the SATA clocks to point to the gating clocks. So if
> > patch 1 is not there, those clocks do not exist and the driver fails to
> > clk_get() those clocks.
> 
> I don't think that is fatal. Orion5x does not have those clocks. The
> PCI version of the SATA devices also does not have those clocks.

Hum, I will check this. But I think that the point that lead me to look
into the clocks is that when I added:

	clocks = <&gate_clk xx>;

to my Ethernet DT nodes, then clk_get() was returning an error, until I
enabled the gating clocks. But I'll double check that.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
