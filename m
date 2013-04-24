From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Apr 2013 14:52:10 +0200
Subject: [PATCH] ASoC: don't call of_dma_request_slave_channel directly
In-Reply-To: <20130424011153.GA2319@shlinux1.ap.freescale.net>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-3-git-send-email-arnd@arndb.de>
 <20130424011153.GA2319@shlinux1.ap.freescale.net>
Message-ID: <201304241452.10298.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013, Shawn Guo wrote:
> On Tue, Apr 23, 2013 at 05:54:33PM +0200, Arnd Bergmann wrote:
> > The exported interface for device drivers is dma_request_slave_channel,
> > not of_dma_request_slave_channel. The former does not depend on device
> > tree but also works with ACPI and other interfaces providing an
> > abstraction for DMA channels.
> > 
> > This fixes link errors when building ALSA as a loadable module.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had already sent a similar patch [1] for that.
> 

Yes, I see it in linux-next now.

Thanks,

	Arnd
