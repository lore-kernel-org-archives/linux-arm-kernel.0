From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 17:54:15 +0800
Subject: [PATCH v3 2/2] dma/imx-sdma: use writel to write register when
 enable a channel
In-Reply-To: <20120105091904.GO2414@b20223-02.ap.freescale.net>
References: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
 <1325750362-22598-3-git-send-email-richard.zhao@linaro.org>
 <20120105092316.GB1729@S2101-09.ap.freescale.net>
 <20120105091904.GO2414@b20223-02.ap.freescale.net>
Message-ID: <20120105095413.GD1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 05:19:05PM +0800, Richard Zhao wrote:
> Russel mentioned that too. But I cannot understand.
> If CONFIG_ARM_DMA_MEM_BUFFERABLE, readl/writel always call rmb/wmb. Do
> we realy need it? It might affect performance.
> 
For safety, I think we need it.  The operations should be really fast.

-- 
Regards,
Shawn
