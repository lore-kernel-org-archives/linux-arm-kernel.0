From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 10:05:47 +0000
Subject: [PATCH v3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1298440516.23371.258.camel@vkoul-udesk3>
References: <1298283699-14635-1-git-send-email-shawn.guo@freescale.com>
	<1298433701.23371.236.camel@vkoul-udesk3>
	<20110223055709.GC20346@S2100-06.ap.freescale.net>
	<1298440516.23371.258.camel@vkoul-udesk3>
Message-ID: <20110223100547.GG29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 11:25:16AM +0530, Koul, Vinod wrote:
> Well in that case you are calling the callback from irq handler which is
> not so good. The tasklet is other extreme (slow).

tasklets are run on the exit path of interrupts.

> Given that this is
> also intended for audio I am not sure if calling period elapsed from
> tasklet callback will not cause any audio over/underruns, last I tried
> it used to break quite often in stressed situations.

Nevertheless, the DMA engine API specifies that callbacks shall be called
from tasklet context.
