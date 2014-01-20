From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 17:29:20 +0530
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140120123849.GC15937@n2100.arm.linux.org.uk>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
Message-ID: <20140120115919.GD26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 12:38:50PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 20, 2014 at 12:36:27PM +0100, Lothar Wa?mann wrote:
> > In case user space firmware loading support (CONFIG_FW_LOADER) is
> > enabled, this message may still be inadequate, since the firmware may
> > very well be loaded lateron.
> 
> I haven't worked out whether that's actually possible - I saw no way to
> re-trigger the firmware request, and once the firmware request expires,
> there seems to be no way for userspace to say "okay, the firmware is now
> available, please load it".
In that case why don't we use async version and wait till the userspace is
availble and firmware is loaded. 

So request_firmware_nowait() seems to do the job, I have used in a device where
I call it in probe() so that not to slow booting and make firmware bloc availble
userpsace is availble.

Sounds too good, did I miss anything obvious for this case here?

-- 
~Vinod
