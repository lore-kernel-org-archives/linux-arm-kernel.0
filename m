From: rizhao@nvidia.com (Richard Zhao)
Date: Tue, 30 Jul 2013 11:31:35 +0800
Subject: [PATCH 6/9] serial: tegra: move to generic dma DT binding
In-Reply-To: <51F2D063.5010505@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
 <51F2D063.5010505@wwwdotorg.org>
Message-ID: <20130730033134.GM15855@rizhao-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 03:39:15AM +0800, Stephen Warren wrote:
> On 07/23/2013 10:09 PM, Richard Zhao wrote:
> > - driver: remove use of nvidia,dma-request-selector
> > 	  use dma_request_slave_channel to request channel
> > - update binding doc
> 
> This patch needs to be amended so that the DMA channel is looked up
> during probe() rather than open(), to guarantee that deferred probe
> works. It's possible to hold off probe, but not possible AFAIK to hold
> off opening the port.
How about avoid return -EPROBE_DEFER at open() time? It can be in
another patch.

Thanks
Richard
