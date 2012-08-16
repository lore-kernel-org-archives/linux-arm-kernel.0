From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:59:21 +0000
Subject: [PATCH] ARM: LPC32xx: Provide DMA filter callbacks via platform
 data
In-Reply-To: <1345122935-22115-1-git-send-email-stigge@antcom.de>
References: <1345122935-22115-1-git-send-email-stigge@antcom.de>
Message-ID: <201208161359.21276.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Roland Stigge wrote:
> The SLC and MLC NAND drivers now need their dma_filter callbacks via platform
> data to make them independent of single DMA engine drivers.
> 
> (This also helps fixing build errors of the SLC and MLC drivers when building
> as modules because direct access to AMBA dma filter functions isn't available
> via export.)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Yes, this looks right.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Once we have proper DT bindings for the DMA channels, we can hopefully
get rid of the auxdata again.

	Arnd
