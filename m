From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Aug 2013 01:11:27 +0100
Subject: [PATCH 3/5] ARM: highbank: enable DMA zone for LPAE
In-Reply-To: <1375743009-28972-3-git-send-email-robherring2@gmail.com>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
 <1375743009-28972-3-git-send-email-robherring2@gmail.com>
Message-ID: <20130806001127.GA23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 05:50:07PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Some devices are restricted to 32-bit DMA. Thus the platform dma_zone_size
> needs to be set. Otherwise dma-mapping code is complaining, e.g.
> 
> calxedaxgmac fff50000.ethernet: coherent DMA mask 0xffffffff is smaller
> than system GFP_DMA mask 0xffffffffffffffff

Note that the patches I posted last week will fix that in a much nicer
way, as we will only error if we actually have sufficient memory that
the condition becomes problematical.

The other problem here is that we need to get better separation between
what's a bus address and what's a physical address.
