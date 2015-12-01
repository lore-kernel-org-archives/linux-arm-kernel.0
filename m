From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 11:15:38 +0100
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <565D729F.2000104@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <13562653.8QgTG33tZS@wuerfel> <565D729F.2000104@ti.com>
Message-ID: <2237139.FINhECNDsD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 12:12:47 Peter Ujfalusi wrote:
> 
> We would need:
>         { "da830-mmc.0", "rx", (void*)EDMA_CTLR_CHAN(0, 16) },
>         { "da830-mmc.0", "tx", (void*)EDMA_CTLR_CHAN(0, 17) },
> 
> as we need to cast the param.
> It is still compact, but having to add the (void*) casting makes it a bit ugly.

Right, I forgot that, but the cast could also be part of EDMA_CTLR_CHAN(),
and with the version I just posted in my other reply that part is solved
as well.

	Arnd
