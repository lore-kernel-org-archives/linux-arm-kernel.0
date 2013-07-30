From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 10:46:42 -0600
Subject: [PATCH 6/9] serial: tegra: move to generic dma DT binding
In-Reply-To: <20130730033134.GM15855@rizhao-lap>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
 <51F2D063.5010505@wwwdotorg.org> <20130730033134.GM15855@rizhao-lap>
Message-ID: <51F7EDF2.60700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 09:31 PM, Richard Zhao wrote:
> On Sat, Jul 27, 2013 at 03:39:15AM +0800, Stephen Warren wrote:
>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>> - driver: remove use of nvidia,dma-request-selector
>>> 	  use dma_request_slave_channel to request channel
>>> - update binding doc
>>
>> This patch needs to be amended so that the DMA channel is looked up
>> during probe() rather than open(), to guarantee that deferred probe
>> works. It's possible to hold off probe, but not possible AFAIK to hold
>> off opening the port.
>
> How about avoid return -EPROBE_DEFER at open() time? It can be in
> another patch.

I don't really understand what you mean. -EPROBE_DEFER is something that
only makes sense for probe() to return (or functions used by probe()).
It doesn't make sense to return it anywhere else, since probe deferral
is something that can only happen for probe().
