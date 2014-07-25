From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 25 Jul 2014 18:42:17 +0530
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140725131217.GS8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 09:46:14PM +0200, Maxime Ripard wrote:
> Hi,
> 
> This patchset adds support for the DMA controller found in the
> Allwinner A31 and A23 SoCs.
> 
> This has been tested using the newly introduced SPI driver on an A31
> EVK. Support for DMA-driven SPI transfers will be the subject of
> another patch serie.
> 
> This has been around for around 5 monthes now, and didn't get any
> review but nitpicks for three versions, so I feel like it could be
> merged quite quickly.
I have applied this now.

Can you please send follow patches for these:
- don't recall if I pointed earlier, but can we use direct conversion for
  calculating convert_burst() and convert_buswidth(), latter one at least
  seem doable
- don't use devm_request_irq(). You have irq enabled and you have killed
  tasklet. This is too racy. You need to ensure no irqs can be generated before killing
  tasklets.
- use synchronize_irq() before killing tasklet

Thanks

-- 
