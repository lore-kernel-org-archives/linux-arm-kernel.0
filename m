From: davem@davemloft.net (David Miller)
Date: Fri, 24 Feb 2012 03:23:49 -0500 (EST)
Subject: [PATCH] davinci_cpdma: Fix channel number written to teardown
 registers
In-Reply-To: <1329983880-23921-1-git-send-email-christian.riesch@omicron.at>
References: <1329983880-23921-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <20120224.032349.795458855905559116.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Riesch <christian.riesch@omicron.at>
Date: Thu, 23 Feb 2012 08:58:00 +0100

> chan->chan_num is 0..CPDMA_MAX_CHANNELS-1 for tx channels and
> CPDMA_MAX_CHANNELS..2*CPDMA_MAX_CHANNELS-1 for rx channels. However,
> the rx and tx teardown registers expect zero based channel numbering.
> 
> Since the upper bits of the registers are reserved, the teardown also
> worked before, this patch is cleanup only.
> 
> Signed-off-by: Christian Riesch <christian.riesch@omicron.at>

Applied to net-next.
