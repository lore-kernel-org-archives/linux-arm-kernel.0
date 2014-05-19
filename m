From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 19 May 2014 22:39:57 +0300
Subject: [PATCH] s3cmci: port DMA code to dmaengine API
In-Reply-To: <4667090.Oyf6jd3Lyk@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <7633675.1cAc12AFAY@wuerfel>
 <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
 <4667090.Oyf6jd3Lyk@wuerfel>
Message-ID: <CA+E=qVc+gk8zt3MMTQ6qWR0+v3UTww5oufd7v3ffrfnNCBfTUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> Well, at least s3c64xx uses resources for passing dma channel number,
>> and so did I.
>> Btw, It'll make transition to device tree a bit easier.
>
> Actually it doesn't help with the transition to DT at all, because DT
> does not use resources for DMA requests. Instead there is a
> dma_request_slave_channel() interface that gets passed a string to
> match the DT descriptor of the DMA channel. If you want to enable
> DT probing while keeping the traditional way alive, you can
> use dma_request_slave_channel_compat(), although I find it not
> much easier than open-coding it.
>
> There is one issue with dma_request_slave_channel_compat and
> dma_request_channel, which is that you need a pointer to the
> filter function. In portable drivers that pointer should get passed
> in platform_data for the non-DT case, along with the data it
> needs, because there are dma engines that need more than just
> an integer to identify a slave.
>
> For this driver, you don't have to go that far, as long as it's
> ensure that the pointer to the filter function is available to
> the driver, i.e. you can't have a built-in s3mci driver when the
> dmaengine driver is a loadable module.

I'll take a look at dma_request_slave_channel_compat(), thanks for a hint!

Regards,
Vasily
