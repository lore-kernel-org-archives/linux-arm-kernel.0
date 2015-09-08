From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 Sep 2015 15:25:33 +0300
Subject: [PATCH] dmaengine: omap-dma: Add support for memcpy
In-Reply-To: <3187470.tKXzQaPa1m@avalon>
References: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
 <3187470.tKXzQaPa1m@avalon>
Message-ID: <55EED3BD.1080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent,

On 09/08/2015 02:24 PM, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patch.
> 
> While trying to port the omap_vout driver to the DMA engine API I noticed that 
> the driver makes use of double-indexed transfers, which are not supported by 
> the omap-dma driver. I haven't checked in details what would be required, but 
> the interleaved API might be a good candidate for this. Do you have any plan 
> to add support for double-indexed transfers to the omap-dma driver ?

If double-indexed transfer support is needed by drivers still using the
legacy/direct sDMA API, then I don't think we have other options..
So far I have not looked at that part and where it would fit.
I'll try to find time to look at this. I hope not in the distant future ;)

> On Wednesday 22 April 2015 10:34:29 Peter Ujfalusi wrote:
>> The sDMA controller is capable of performing memory copy operation. It need
>> to be configured to software triggered mode and without HW synchronization.
>> The sDMA can copy data which is aligned to 8, 16 or 32 bits.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 49 insertions(+), 2 deletions(-)
> 

-- 
P?ter
