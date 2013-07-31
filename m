From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 15:33:12 -0600
Subject: [PATCH 2/9] dma: tegra20-apbdma: move to generic device tree
 bindings
In-Reply-To: <20130731035256.GR15855@rizhao-lap>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-3-git-send-email-rizhao@nvidia.com>
 <51F2CDBE.40802@wwwdotorg.org> <20130730030644.GJ15855@rizhao-lap>
 <51F7ED62.4060404@wwwdotorg.org> <20130731035256.GR15855@rizhao-lap>
Message-ID: <51F98298.7000002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 09:52 PM, Richard Zhao wrote:
> On Wed, Jul 31, 2013 at 12:44:18AM +0800, Stephen Warren wrote:
>> On 07/29/2013 09:06 PM, Richard Zhao wrote:
>>> On Sat, Jul 27, 2013 at 03:27:58AM +0800, Stephen Warren wrote:
>>>> (Stripping the Cc list a lot)
>>>>
>>>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>>>> Update tegra20-apbdma driver to adopt generic DMA device tree bindings.
>>>>> It calls of_dma_controller_register() with of_dma_simple_xlate to get
>>>>> the generic DMA device tree helper support. The #dma-cells for apbdma
>>>>> must be 1, which is slave ID.
...
>>>> Why does this driver need to define a filter function? I thought the
>>>> dmaengine's DT support would already match DMA clients/engines based on
>>>> the phandle in DT? Isn't the need to pass the slave channel ID into
>>>> drivers something pretty fundamental to dmaengine, and hence something
>>>> it already supports?
>>>
>>> of_dma_simple_xlate only pass slave id to filter function. It needs
>>> change to pass dt node too. I didn't start work on the common code
>>> change yet. Do you think we need to hold it until common code change?
>>
>> Oh dear, I can't see how the core DT DMA support can work for anyone
>> without the ability to limit DMA clients to the specific DMA controller
>> that's specified in DT. If that functionality truly is missing, then it
>> certainly needs to be added first.
> 
> omap-dma uses the same way. 

The fact that some other driver does the same wrong thing isn't really a
good excuse not to fix it now.
