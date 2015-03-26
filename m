From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 26 Mar 2015 14:11:38 +0200
Subject: [PATCH v2 1/7] dmaengine: of_dma: Support for DMA routers
In-Reply-To: <20150326105018.GJ32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-2-git-send-email-peter.ujfalusi@ti.com>
 <20150326105018.GJ32683@intel.com>
Message-ID: <5513F77A.4030005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 12:50 PM, Vinod Koul wrote:
> On Wed, Mar 11, 2015 at 03:23:24PM +0200, Peter Ujfalusi wrote:
>> DMA routers are transparent devices used to mux DMA requests from
>> peripherals to DMA controllers. They are used when the SoC integrates more
>> devices with DMA requests then their controller can handle.
>> DRA7x is one example of such SoC, where the sDMA can hanlde 128 DMA request
>> lines, but in SoC level it has 205 DMA requests.
>>
>> The of_dma_router will be registered as of_dma_controller with special
>> xlate function and additional parameters and the code will translate and
>> requests a DMA channel from the real DMA controller.
>> This way the router can be transparent for the system while remaining generic
>> enough to be used in different environments.
>>
> Looks fine, was expecting a Documentation updates as well, but that can come
> as follow up patch too

I have added the DT binding document since this series adds support for
routers for platforms booting with DT:

Documentation/devicetree/bindings/dma/dma.txt | 28 ++++++++

-- 
P?ter
