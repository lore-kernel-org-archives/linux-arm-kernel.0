From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 12:39:39 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FA30604.1030401@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA30604.1030401@wwwdotorg.org>
Message-ID: <201205041239.39630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Stephen Warren wrote:
> > +    - #dma-channels: Number of DMA channels supported by the controller.
> > +    - #dma-requests: Number of DMA requests signals supported by the controller.
> 
> I don't see why those properties would be mandatory in device tree. They
> don't appear to be involved in parsing a DMA client's DMA specifier.
> Shouldn't this information be provided at run-time by the DMA controller
> driver. If it supports different HW models with different capabilities,
> then it certainly could represent those values in DT, but I don't think
> this should be required.

Agreed. I would list them as 'optional' though, so that every specific
binding that needs these will have to use the same format.

	Arnd
