From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 31 May 2013 10:04:37 +0200
Subject: [PATCH 0/3] at_hdmac: dt dma bindings update
In-Reply-To: <20130530201321.GE23653@game.jcrosoft.org>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
 <20130530172649.GC3767@intel.com> <20130530201321.GE23653@game.jcrosoft.org>
Message-ID: <51A85995.1050909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/2013 22:13, Jean-Christophe PLAGNIOL-VILLARD :
> On 22:56 Thu 30 May     , Vinod Koul wrote:
>> On Thu, May 30, 2013 at 06:08:20PM +0200, ludovic.desroches at atmel.com wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> Hi,
>>>
>>> This set of patches update the dt dma binding for at_hdmac since we need one
>>> more parameter. In order to keep backward compatibility, an existing cell will
>>> be used to add this parameter. Since the content of that cell will become a
>>> magic value due to the concatenation of the two parameters, it is time to
>>> use macros.
>> which tree is this targetted to be applied?
>
> arm-soc as this depends on alreadied applied cleanup I've

... already pushed (it must be the end of your sentence, Jean-Christophe...)

Vinod, Arnd,

- patch 1 shall be applied before any of the two others of the series
- patch 2 is pure DT modification, but relies on Jean-Christophe's
   already pushed cleanup branch in arm-soc
- patch 3 is the pure dmaengine one, but relies on the 1st patch

So, maybe the preferred way to include this material upstream is to go 
through arm-soc as suggested by Jean-Christophe.

Bye,

>> Arnd, can you review this series and ack if this needs to be applied thru
>> dmaengine?
>
> I prefer the invert
>
> Best Regards,
> J.
>>
>> --
>> ~Vinod
>>>
>>> Regards
>>>
>>> Ludovic Desroches (3):
>>>    ARM: at91: dt: add header to define at_hdmac configuration
>>>    ARM: at91: dt: switch DMA DT bindings to pre-processor
>>>    at_hdmac: add FIFO configuration parameter to DMA DT binding
>>>
>>>   .../devicetree/bindings/dma/atmel-dma.txt          |  7 ++++--
>>>   arch/arm/boot/dts/at91sam9g45.dtsi                 |  5 ++--
>>>   arch/arm/boot/dts/at91sam9n12.dtsi                 | 11 +++++----
>>>   arch/arm/boot/dts/at91sam9x5.dtsi                  | 17 +++++++-------
>>>   arch/arm/boot/dts/sama5d3.dtsi                     | 19 +++++++--------
>>>   drivers/dma/at_hdmac.c                             | 25 ++++++++++++++++----
>>>   include/dt-bindings/dma/at91.h                     | 27 ++++++++++++++++++++++
>>>   7 files changed, 81 insertions(+), 30 deletions(-)
>>>   create mode 100644 include/dt-bindings/dma/at91.h
>>>
>>> --
>>> 1.7.11.3
>>>
>>
>> --
>


-- 
Nicolas Ferre
