From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 11:49:42 +0000
Subject: at91: Error while registering DMA controller in 3.3-rc
In-Reply-To: <4F4F49E1.4020902@atmel.com>
References: <4F4F49E1.4020902@atmel.com>
Message-ID: <201203011149.42948.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Nicolas Ferre wrote:
> We currently have a regression on 3.3-rc kernels about the DMA
> controller registration.
> 
> http://article.gmane.org/gmane.linux.kernel.mmc/13014
> 
> This is due to the DMA driver having seen an update during the 3.3 merge
> window  but the AT91 device files not having the corresponding
> modifications.
> 
> Maybe you remember, those modifications where part of the famous AT91
> board/device series that was postponed to 3.4 due to a flood of issues...
> 
> So now, I would like to know if it is possible to resolve this problem
> by queuing the DMA related patches that we have already in
> at91/device-board branch to mainline before 3.3-final?

Yes, that should be possible. We try not have the same patches in multiple
branches, but since this is a regression, I think we should do it anyway.

> The patches that I am talking about are:
> 
> bdad0b9 ARM: at91/dma: remove platform data from DMA controller
> and
> 2756bf5 ARM: at91/dma: DMA controller registering with DT support
> 
> I do think it is pretty silly to try to resolve this issue by not taking
> those two little patches and modifying source code to workaround this
> issue. If we do this, we will get conflicts and need to rework the
> already queued 3.4 material.
> 
> Do you want me to prepare a new at91-fixes branch with those two patches
> or you can take them yourself?

Better send me a pull request so that you can do some testing on the
exact branch that you send me. I would probably end up with the
same tree and I'm not worried about doing it, but we should make sure
that it actually works.

	Arnd
