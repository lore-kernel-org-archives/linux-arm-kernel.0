From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 20 Jul 2012 16:09:14 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <201207200418.41554.marex@denx.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <50081AC0.10703@metafoo.de> <201207192126.31772.marex@denx.de>
 <201207200418.41554.marex@denx.de>
Message-ID: <5009668A.7090502@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2012 04:18 AM, Marek Vasut wrote:
>> Dear Lars-Peter Clausen,

> [...]
> 
> One more thing I'm curious about. There's another ADC block on the CPU, called 
> HSADC (high-speed ADC). It can sample even up to 2Msamples/s. If I were to, say 
> -- sample at 100kHz and be able to DMA the results into memory -- is there any 
> way to push such results into userland somehow? Or how to operate such fast 
> beast?

Proper support for high speed sampling is still something that's missing
from IIO. You can't mmap your buffers, you can't splice a IIO data stream to
another file descriptor, there is no support for zero copy. So your
bottleneck will become that you have to copy lots of data around. But it is
certainly something that will be added at some point. So implementing the
driver as a IIO driver is definitely the right direction.

- Lars
