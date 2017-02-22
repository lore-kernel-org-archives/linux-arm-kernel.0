From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 22 Feb 2017 08:11:41 +0530
Subject: [RESEND PATCH] dmaengine: bcm2835: Fix cyclic DMA period splitting
In-Reply-To: <20170220190115.GB4170@camel2.lan>
References: <20170220190115.GB4170@camel2.lan>
Message-ID: <20170222024140.GV2843@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 08:01:16PM +0100, Matthias Reichl wrote:
> The code responsible for splitting periods into chunks that
> can be handled by the DMA controller missed to update total_len,
> the number of bytes processed in the current period, when there
> are more chunks to follow.
> 
> Therefore total_len was stuck at 0 and the code didn't work at all.
> This resulted in a wrong control block layout and audio issues because
> the cyclic DMA callback wasn't executing on period boundaries.
> 
> Fix this by adding the missing total_len update.

Applied, thanks

-- 
~Vinod
