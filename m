From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 16 Nov 2011 08:55:12 +0200
Subject: [PATCH v2 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <4EC27EED.4030108@metasoft.pl>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
 <3ea8d56034f25cbe3fd8a4c31d7d0d1540b6ac7e.1306662317.git.mika.westerberg@iki.fi>
 <4EC27EED.4030108@metasoft.pl>
Message-ID: <20111116065512.GB2703@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 04:02:05PM +0100, Rafal Prylowski wrote:
> 
> 1) Control register is incorrectly programmed for IDE (m2m_hw_setup),
> probably copy-paste bug ;)

Yes, this is certainly a copy-paste bug or something. Thanks for fixing :)

Can you send a separate patch for this? Make sure you Cc Vinod Koul as he is
the maintainer of slave dma subsystem.

> 2) Kernel oops when trying to stop running transfers by calling
> dmaengine_terminate_all(...) - caused by dereferencing empty list
> in ep93xx_dma_get_active

Can you post that OOPS log? I would like to understand this problem a bit
better before we do any fixes for the driver.
