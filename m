From: davem@davemloft.net (David Miller)
Date: Tue, 24 Nov 2015 16:25:49 -0500 (EST)
Subject: [PATCH] drivers: net: xgene: fix: ifconfig up/down crash
In-Reply-To: <1448309092-21550-1-git-send-email-isubramanian@apm.com>
References: <1448309092-21550-1-git-send-email-isubramanian@apm.com>
Message-ID: <20151124.162549.528006670345277057.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 23 Nov 2015 12:04:52 -0800

> Fixing kernel crash when doing ifconfig down and up in a loop,
 ...
> The fix was to reorder napi_enable, napi_disable, request_irq and
> free_irq calls, move register_netdev after dma_coerce_mask_and_coherent.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Khuong Dinh <kdinh@apm.com>

Applied, thanks.
