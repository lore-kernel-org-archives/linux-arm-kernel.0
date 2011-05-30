From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 29 May 2011 20:24:54 -0600 (MDT)
Subject: [PATCHv2 2/2] OMAP: add omap_device_reset()
In-Reply-To: <1306500367.1905.18.camel@deskari>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	<1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	<4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>
Message-ID: <alpine.DEB.2.00.1105292022080.8973@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Fri, 27 May 2011, Tomi Valkeinen wrote:

> DSS driver has been designed so that it resets the HW before it begins
> programming it. That way we get the HW into known state. Otherwise we
> need to be extra careful to program all possible registers to a sane
> value. Not impossible, of course, but requires extra work.
> 
> I noticed the problem with DSI driver, it didn't work anymore if I
> didn't reset it.

One thing that I don't quite understand about this thread is that the 
hwmod code should be resetting the DSS hwmods when the system boots.  Is 
something not working with this process?

That is a separate case from the error recovery case.  Sounds like we may 
need to expose a reset function for that purpose as well.  Tomi, I don't 
think your proposed patch is enough for this, though: we'd also need to 
reset the hwmod internal state for that module, and reprogram the 
SYSCONFIG bits, etc. as mach-omap2/omap_hwmod.c:_setup() does.


- Paul
