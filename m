From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 18 Jul 2012 13:33:42 +0800
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120717152001.GF4477@opensource.wolfsonmicro.com>
References: <5003FB7C.4030509@linaro.org>
 <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
 <20120717133550.GC4477@opensource.wolfsonmicro.com>
 <50057058.2060002@linaro.org>
 <20120717142222.GE4477@opensource.wolfsonmicro.com>
 <50057C1A.80606@linaro.org>
 <20120717152001.GF4477@opensource.wolfsonmicro.com>
Message-ID: <20120718053341.GA4009@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 04:20:01PM +0100, Mark Brown wrote:
> Looking at what's specified in the platform data in the current kernel
> it seems like there's a mixture of things in there that are board and
> silicon specific.  We've got parameters like the the speed mode and
> timeout which are reasonably board specific but we've also got things
> like the FIFO sizes which shouldn't be at all board specific and slsu
> which really looks like it's something that that the driver ought to be
> able to figure out for itself.

I have an IP block getting different FIFO size on different IMX SoCs.
We could introduce a new compatible string for driver to figure it out,
but I think the simpler way is just have the data encoded in device
tree.  In any case DT is not completely limited in encoding board
specific data.  Today, we have IO region and interrupt number of
hardware blocks encoded in DT, and to me, FIFO size could just be
another aspect of hardware block we could choose to encode in DT.

-- 
Regards,
Shawn
