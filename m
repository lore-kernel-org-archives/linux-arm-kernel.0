From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 15 Aug 2012 15:29:16 +0800
Subject: [PATCH v3 3/4] dmatest: add dmaengine_slave_config for DMA_MEMCPY
In-Reply-To: <20120814082047.GF18957@n2100.arm.linux.org.uk>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-4-git-send-email-zhangfei.gao@marvell.com>
 <20120814082047.GF18957@n2100.arm.linux.org.uk>
Message-ID: <CAMj5Bkg7sOf39AkpW1An5gTNEbKmFvqVNfXjkFXu6MhSAkYCCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 4:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 14, 2012 at 12:11:58PM +0800, Zhangfei Gao wrote:
>> Set direction to DMA_MEM_TO_MEM
>> DMA driver may require such configure info
>
> No, this is wrong.  By default, any channel being asked to do memcpy
> should deal with the channel configuration itself and not require it
> to be set - otherwise this breaks the async_tx API.
>
> So consider that dma-test found a bug in your driver which needs fixing.

Thanks Russell for the info.

Really not know DMA_MEM_TO_MEM should be set as default.
>From include/linux/dmaengine.h only find "DMA_ASYNC_TX capability
is automatically set as dma devices are registered".

Will change driver and set config as DMA_MEM_TO_MEM as default setting.

Thanks
