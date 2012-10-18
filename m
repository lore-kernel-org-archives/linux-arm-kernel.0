From: b32955@freescale.com (Huang Shijie)
Date: Thu, 18 Oct 2012 17:10:46 +0800
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <20121018085208.GR21164@n2100.arm.linux.org.uk>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <1350541111.5263.3.camel@vkoul-udesk3> <507FA595.4020507@freescale.com>
 <20121018085208.GR21164@n2100.arm.linux.org.uk>
Message-ID: <507FC796.7060401@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?10?18? 16:52, Russell King - ARM Linux ??:
> On Thu, Oct 18, 2012 at 02:45:41PM +0800, Huang Shijie wrote:
>> ? 2012?10?18? 14:18, Vinod Koul ??:
>>> Why cant you do start (prepare clock etc) when you submit the descriptor
>>> to dmaengine. Can be done in tx_submit callback.
>>> Similarly remove the clock when dma transaction gets completed.
>> I ever thought this method too.
>>
>> But it will become low efficient in the following case:
>>
>>    Assuming the gpmi-nand driver has to read out 1024 pages in one
>> _SINGLE_ read operation.
>> The gpmi-nand will submit the descriptor to dmaengine per page. So with
>> your method,
>> the system will repeat the enable/disable dma clock 1024 time. At every
>> enable/disable dma clock,
>> the system has to enable the clock chain and it's parents ...
> And what if you stop using clk_prepare_enable(), and prepare the clock
> when the channel is requested and only use clk_enable() in the tx_submit
yes. it's a little better.
There is nearly no difference between the clk_prepare_enable() and 
clk_enable() in actually.
the clk_gate2_ops does not have any @->prepare.

thanks
Huang Shijie

> method?
>
