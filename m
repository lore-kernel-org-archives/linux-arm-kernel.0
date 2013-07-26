From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:39:15 -0600
Subject: [PATCH 6/9] serial: tegra: move to generic dma DT binding
In-Reply-To: <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2D063.5010505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> - driver: remove use of nvidia,dma-request-selector
> 	  use dma_request_slave_channel to request channel
> - update binding doc

This patch needs to be amended so that the DMA channel is looked up
during probe() rather than open(), to guarantee that deferred probe
works. It's possible to hold off probe, but not possible AFAIK to hold
off opening the port.
