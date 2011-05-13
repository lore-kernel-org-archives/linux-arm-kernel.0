From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 13 May 2011 17:31:04 +0530
Subject: [QUERY] amba/pl022: DMA channel allocation always fail.
Message-ID: <4DCD1D80.7060409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

amba/pl022 and my dma driver dw_dmac.c, both have registered init() routines
with subsys_initcall(). Now at bootup, spi boots up before DMA and so DMA
channels are never available at spi probe.

What should be done to solve this issue?

One idea is allocate DMA channel as and when required, instead of allocating them
at probe. But in that case too i am not sure, that this issue will be solved.
As, if spi slave device is added from board file, then it will also try to transfer
data as soon as spi driver is up. So that too may be called before dma_probe().

-- 
viresh
