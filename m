From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Apr 2014 20:19:11 +0200
Subject: [PATCH v2 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <53551E9D.9080107@ti.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <20140419182528.414b9b2e@skate> <53551E9D.9080107@ti.com>
Message-ID: <20140421201911.10783191@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Santosh Shilimkar,

On Mon, 21 Apr 2014 09:35:25 -0400, Santosh Shilimkar wrote:

> > In mach-mvebu, what we do is that we register a bus notifier on the
> > platform bus, so that we can set our custom DMA operations for all
> > platform devices in the system. Should this be done in a different way
> > after your series?
> > 
> Nope. Since you have a very custom SOC specific case, you can continue
> what you are doing.

True, but as you said, the goal is to remove machine code. So instead
of having just a 'dma-coherent' property, shouldn't we have a
dma-method property, which could be dma-method = "coherent" or
dma-method = "marvell,io-coherent" and therefore allow the DT binding
to cover more use cases than just the default non-coherent and coherent
DMA operations?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
