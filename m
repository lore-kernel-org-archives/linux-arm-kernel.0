From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 11 Apr 2018 14:38:55 +0530
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <1522665546-10035-3-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
Message-ID: <20180411090854.GY6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:

> +
> +		if (chan->xdev->has_axieth_connected) {
> +			seg = list_first_entry(&desc->segments,
> +					struct xilinx_axidma_tx_segment, node);
> +			if (cb.callback_param) {
> +				app_w = (u32 *) cb.callback_param;

why are you interpreting callback_param? This is plainly wrong.
we do not know what is the interpretation of callback_param and it is
internal to submitter.

What exactly is the problem you are trying to solve?

> +				hw = &seg->hw;
> +				*app_w = hw->status & XILINX_DMA_MAX_TRANS_LEN;
> +				memcpy(app_w, hw->app, sizeof(u32) *
> +					XILINX_DMA_NUM_APP_WORDS);
> +			}

-- 
~Vinod
