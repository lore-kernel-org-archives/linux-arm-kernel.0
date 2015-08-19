From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Aug 2015 22:35:04 +0530
Subject: [PATCHv4 5/6] dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()
In-Reply-To: <1436365699-6862-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150819170504.GN13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:28:18PM +0200, Thomas Petazzoni wrote:
> When commit 6f166312c6ea2 ("dmaengine: mv_xor: add support for a38x
> command in descriptor mode") added support for the descriptor mode
> available in Marvell Armada 38x and later SoCs, it added a new
> function mv_chan_set_mode_to_desc() which allows to configure a XOR
> channel to get the specific operation to be done from each individual
> DMA descriptor.
> 
> However, this function was mainly a duplicate of the existing
> mv_chan_set_mode(), with just the operation being different.
> 
> This commit re-organizes the code into a single mv_chan_set_mode()
> function, which takes the operation mode as argument, and the
> mv_xor_channel_add() function decides whether to use
> XOR_OPERATION_MODE_IN_DESC or XOR_OPERATION_MODE_XOR.

This one as well

-- 
~Vinod
