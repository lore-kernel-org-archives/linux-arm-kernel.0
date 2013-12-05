From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 03:46:08 +0100
Subject: [PATCH V3] dma: tegra: register as an OF DMA controller
In-Reply-To: <529F65E6.9050606@wwwdotorg.org>
References: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
 <201312040234.09708.arnd@arndb.de> <529F65E6.9050606@wwwdotorg.org>
Message-ID: <201312050346.09225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013, Stephen Warren wrote:
> > 
> > We really need to be better at having a common set of rules regarding what
> > it actually means to set the slave_id through dma_slave_config(). IMHO
> > we should just treat it as a bug for any dmaengine driver that is configured
> > through DT, or we should get rid of this entirely.
> 
> By the end of this series (for the Tegra driver) I can remove those "+"
> lines you quoted above; the slave ID will only come from DT through
> of_xlate, and any slave ID in the slave_config will simply be ignored.

Ok, that's certainly a step in the right direction. However, as I said
my comment wasn't really directed at you and I think it's more important
to have a clear policy that we can enforce across all dmaengine drivers.

It's really up to Vinod and Dan to decide how it should be handled
in general.

	Arnd
