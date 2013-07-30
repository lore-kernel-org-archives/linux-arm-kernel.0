From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 10:44:46 -0600
Subject: [PATCH 3/9] spi: tegra114: move to generic dma DT binding
In-Reply-To: <20130730031536.GK15855@rizhao-lap>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-4-git-send-email-rizhao@nvidia.com>
 <51F2CF53.30002@wwwdotorg.org> <20130730031536.GK15855@rizhao-lap>
Message-ID: <51F7ED7E.5070000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 09:15 PM, Richard Zhao wrote:
> On Sat, Jul 27, 2013 at 03:34:43AM +0800, Stephen Warren wrote:
>> (Stripping CC list a bit)
>>
>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>> - driver: remove use of nvidia,dma-request-selector
>>> 	  use dma_request_slave_channel to request channel
>>> - if dmas/dma-names are missing, it still supports cpu based transfer
>>> - update binding doc and specify dmas/dma-names properties as optional

>>> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
>>
>>> +Optional properties:
>>> +- dmas : The Tegra DMA controller's phandle and request selector for
>>> +  this SPI controller.
>>> +- dma-names : Should be "rx-tx".
>>
>> This should reference dma.txt which defines the DMA DT bindings. How about:
>>
>> ----------
>> Optional properties:
>> - dmas, dma-names : The DMA channel to use for DMA-mode operation. See
>>   dma.txt for the definition of these properties. A single entry named
>>   "rx-tx" must be specified.
>> ----------
> Ok. but how about replace "DMA channel" with "DMA request"?

Sure.
