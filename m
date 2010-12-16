From: kernelccrazy@gmail.com (y bhanu)
Date: Wed, 15 Dec 2010 18:08:14 -0800
Subject: dma_cache_sync replacement call
In-Reply-To: <20101215225903.GJ9937@n2100.arm.linux.org.uk>
References: <AANLkTi=p3eaVKUNvxLCThhDC534j_SX+TUtxYgGfu40Q@mail.gmail.com>
	<20101215225903.GJ9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=XVZLcGut44xO8_MM=MH=VbiDtks5MATG5BSyq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Here is understanding after reading DMA-API.txt and looking though
different kernel headers (arch specific & generic)
Correct me if I missed anything.

Purpose of dma_cache_sync:
  to force sync DMA buffers to be able to be accessed by CPU (programs/driver)

Alternative for dma_cache_sync:
 dma_sync_single_for_cpu()  and dma_unmap_single()
 These do the same operation of (i.e.__dma_single_dev_to_cpu ) to
trasfer the buffer ownership.

But, I really dont understand what is the differnec between
dma_sync_single_for_cpu()  and dma_unmap_single()? (Is it is just to
make the name clear?)
I think  dma_sync_single_for_cpu() bests suites to situation.

Thanks
bhanu


On Wed, Dec 15, 2010 at 2:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 15, 2010 at 02:54:57PM -0800, y bhanu wrote:
>> I am porting a Linux wireless driver from MIPS to ARM (ixp4xx).
>>
>> As dma_cache_sync() is not implemented for ARM ,I get some nasty errors:
>> I am not sure whats the replacement for this deprecated call under ARM.
>>
>> can ?anyone help figure out what use instread of dma_cache_sync() &
>> dma_cache_wback_inv() calls?
>
> The answer is to complain to MIPS people as to why they are using their
> own private DMA cache support rather than the DMA API (whose documentation
> can be found in Documentation/DMA-API.txt).
>
> The answer is there is no straight replacement - the answer is to fix the
> driver to use the proper portable interfaces.
>
