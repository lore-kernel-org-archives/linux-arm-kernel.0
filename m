From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Sep 2011 15:32:14 +0300
Subject: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT support
In-Reply-To: <4E60C9FF.9050608@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-7-git-send-email-b-cousson@ti.com>
	<20110902080944.GP3548@atomide.com> <4E609800.9090402@ti.com>
	<20110902104330.GR3548@atomide.com> <4E60C174.50604@ti.com>
	<20110902115733.GU3548@atomide.com> <4E60C9FF.9050608@ti.com>
Message-ID: <20110902123213.GV3548@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110902 14:47]:
> >         .tap    = OMAP2_L4_IO_ADDRESS(0x4900a000),
> 
> BTW, how can we get rid of that OMAP2_L4_IO_ADDRESS?

That needs to be mapped early for SoC detection to work
for cpu_is_omapxxxx stuff :(
 
> In fact only the tap should be required at map_io time to get the
> DEVICE_ID, I guess that the others entries could be retrieve later?

Yes well whatever needs to be mapped early for the SoC
revision detection. It could be that we can map timers
and serial port only early, then set up the mappings for
the rest later on. That is if we can avoid SoC and revision
detection early.

Tony
