From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Dec 2014 11:47:46 +0530
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141208061746.GD16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:41:54PM +0100, Maxime Ripard wrote:
> Hi,
> 
> As we discussed a couple of weeks ago, this is the third attempt at
> creating a generic behaviour for slave capabilities retrieval so that
> generic layers using dmaengine can actually rely on that.
> 
> That has been done mostly through two steps: by moving out the
> sub-commands of the device_control callback, so that the dmaengine
> core can then infer from that wether a sub-command is implemented, and
> then by moving the slave properties, such as the supported buswidth,
> to the structure dma_device itself.

Okay managed to get this done. Apart from the two issues identified didn't
find anything so applied and pushed to a branch
"topic/slave_caps_device_control_fix"

Today did some compile tests and found few warnings, were trivial but I
am worried about the testing of this code. Has anyone tested this, if so
which platforms are covered Since I pushed base branch last night, Feng's
bot covered it and all was OK. Looks like Feng's bot doesn't have wide
coverage of arm platforms, wasn't there one run by arm guys which tries to
test and boot, if so can we get this tested there please.

So bit sceptical for merging now. I will send the patches which I have
applied on top of this

Thanks
-- 
~Vinod
