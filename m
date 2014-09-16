From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 09:43:06 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410774073.3314.1.camel@pengutronix.de>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <1410774073.3314.1.camel@pengutronix.de>
Message-ID: <20140916014304.GA23450@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 11:41:13AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 10.09.2014, 13:30 +0800 schrieb Robin Gong:
> > There is one weird data in rxfifo after one full rx/tx transfer
> > done sometimes. It looks a design issue and hard to workaround
> > totally, so disable dma functhion here. And will re-enable it
> > once the root cause found.
> > 
> Sorry, I'm late to this as Shawn seems to already have picked up this
> patch, but this isn't the right way to fix the problem.
> 
> We made it clear at kernel summit last year that we try to not break
> existing DTs as booting a new kernel with an old DT is a valid use case.
> While you don't strictly violate this rule what you do here is only
> fixing systems booting with a new DT while leaving others broken.
> 
> If you are working around a hardware problem please disable DMA support
> in the driver. This will also allow you to enable it again, if you find
> another workaround without touching the DT again.

Okay, it's a valid point.  Patch dropped.

Shawn
