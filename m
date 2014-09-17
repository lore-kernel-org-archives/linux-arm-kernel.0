From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 17 Sep 2014 16:46:43 +0000 (UTC)
Subject: [PATCH 02/12] ARM: OMAP3: Use force-idle for UARTs because of
 DMA errata
In-Reply-To: <20140916174434.GB1580@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
 <1410837126-31553-2-git-send-email-tony@atomide.com>
 <alpine.DEB.2.02.1409161605200.23518@utopia.booyaka.com>
 <20140916174434.GB1580@atomide.com>
Message-ID: <alpine.DEB.2.02.1409171559470.20823@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Sep 2014, Tony Lindgren wrote:

> For toggling the DMA vs PIO mode, that should be done with some Linux
> generic API from the driver. But since we don't have that, I don't think
> there's much overhead for always configuring for DMA mode. Or do you
> see some issues with that?

I think it should be OK.  Probably it would not be a case of additional 
overhead.  The impact would be on UART wakeup handling.  We'll just want 
to keep an eye on wakeups from characters received on the UART, and if 
those start flaking out occasionally, we might take a closer look at this 
patch.  

The race window, if it even exists, would be pretty narrow.  And the 
erratum usage note doesn't mention any impact on wakeups...  

> Yes great. I've verified that's enough to make it work properly with off-idle
> and dma when tested against Sebastian's uart_v10_pre1 branch.
> 
> Updated patch below, thanks for catching the bogus configuration.

Cool, thanks for looking into those flags.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
