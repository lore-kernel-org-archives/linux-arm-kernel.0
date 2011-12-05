From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 05 Dec 2011 08:24:19 +0530
Subject: [PATCH v3] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <1322792185-4704-1-git-send-email-b32955@freescale.com>
References: <1322792185-4704-1-git-send-email-b32955@freescale.com>
Message-ID: <1323053659.30390.45.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-02 at 10:16 +0800, Huang Shijie wrote:
> When we use the SDMA in the UART driver(such as imx6q), we will
> meet one situation:
>   Assume we set 64 bytes for the RX DMA buffer.
>   The RX DMA buffer has received some data, but not full.
>   An Aging DMA request will be received by the SDMA controller if we enable the
>   IDDMAEN(UCR4[6]) in this case.
> 
> So the UART driver needs to know the count of the real received bytes,
> and push them to upper layer.
> 
> Add two new fields to sdmac, and update the `residue` in sdma_tx_status().
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
Applied thanks


-- 
~Vinod
