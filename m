From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 22 Jul 2012 20:48:19 +0100
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <5009668A.7090502@metafoo.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <50081AC0.10703@metafoo.de> <201207192126.31772.marex@denx.de>
 <201207200418.41554.marex@denx.de> <5009668A.7090502@metafoo.de>
Message-ID: <500C5903.1090601@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2012 03:09 PM, Lars-Peter Clausen wrote:
> On 07/20/2012 04:18 AM, Marek Vasut wrote:
>>> Dear Lars-Peter Clausen,
> 
>> [...]
>>
>> One more thing I'm curious about. There's another ADC block on the CPU, called 
>> HSADC (high-speed ADC). It can sample even up to 2Msamples/s. If I were to, say 
>> -- sample at 100kHz and be able to DMA the results into memory -- is there any 
>> way to push such results into userland somehow? Or how to operate such fast 
>> beast?
> 
> Proper support for high speed sampling is still something that's missing
> from IIO. You can't mmap your buffers, you can't splice a IIO data stream to
> another file descriptor, there is no support for zero copy. So your
> bottleneck will become that you have to copy lots of data around. But it is
> certainly something that will be added at some point. So implementing the
> driver as a IIO driver is definitely the right direction.

Lars has pretty much covered it.  A long time back I had a cunning plan
to wait for the tracing frameworks to agree on a one true ring buffer
then leverage that work to get us everything we could want.

Some of those buffers are extremely fast versatile and do fun things like
splicing.  Also we have very little chance of introducing yet another complex
buffer implementation to the kernel (which incidentally  is why we are ditching
sw_ring - other than it being rubbish ;)  There were various articles on lwn
about this work, but I haven't heard anything recently.  If anyone does
want (and crucially have time) to look into high performance (and large) buffer
options, that would be excellent!  It is definitely something we want to have.

Jonathan


> 
> - Lars
> 
