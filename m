From: peda@lysator.liu.se (Peter Rosin)
Date: Wed, 25 Nov 2015 12:55:33 +0100
Subject: SAMA5D3x: I2C, USART1 and DMA.
In-Reply-To: <20151124165334.GA29813@finsecur.com>
References: <56548CD7.4010705@lysator.liu.se>
 <20151124164424.GA28794@finsecur.com> <20151124165334.GA29813@finsecur.com>
Message-ID: <5655A1B5.6060307@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 2015-11-24 17:53, Sylvain Rochet wrote:
> On Tue, Nov 24, 2015 at 05:44:24PM +0100, Sylvain Rochet wrote:
>> On Tue, Nov 24, 2015 at 05:14:15PM +0100, Peter Rosin wrote:
>>> However, cutting out the "dmas" line does not improve things. So, how
>>> do I enable DMA on usart1?
>>
>> You are probably running out of available DMA channels on the DMAC0. 
>> There is 8 channels available per DMAC and this is quite a scarce 
>> resource.
>>
>> See "DMA Channels Definition" tables from the SAMA5D3 datasheet. I hope 
>> you balanced well the peripherals you are using in your design on the 
>> two DMAC to prevent running out of DMA channels.
> 
> I forgot to add that you need to explicitely enable DMA on usart as 
> explained in the Documentation/devicetree/bindings/serial/atmel-usart.txt
> documentation, this way: 
> 
> usart0: serial at f001c000 {
>         ...
>         atmel,use-dma-rx;
>         atmel,use-dma-tx;
>         ...
> }

Got it working, not dropped data yet... Thanks for the pointers!

Cheers,
Peter
