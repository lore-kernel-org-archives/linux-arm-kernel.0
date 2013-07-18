From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jul 2013 14:36:23 +0200
Subject: [PATCH V2 5/8] serial: at91: support run time switch transfer mode
In-Reply-To: <51E7B37C.5090105@atmel.com>
References: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
 <1373942627-7121-6-git-send-email-elen.song@atmel.com>
 <20130718081520.GC16015@ns203013.ovh.net> <51E7B37C.5090105@atmel.com>
Message-ID: <51E7E147.30104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2013 11:21, elen.song :
> Hi JC:
> On 7/18/2013 4:15 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 10:43 Tue 16 Jul     , Elen Song wrote:
>>> We will switch to pio mode when request of dma or pdc fail.
>>> But soon or later, when the request is success, the transfer mode can switch to them at
>>> next open serial port action.
>>> So in startup stage, we should get original transfer mode.
>> You need to update the Documentation of the binding to said the driver support
>> dmas bindings for the new IP
>
> one question, it seems the document should write like:
>
> use DMA:
>       usart0: serial at f001c000{
>           compatible = "atmel,at91sam9260-usart";
>           dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
>                        <&dma0 2
> (AT91_DMA_CFG_PER_ID(3)|AT91_DMA_CFG_FIFOCFG_ASAP)>;
>           dma-names = "tx","rx";
> };
>
> Should I replace macros with typical values?

Yes. That is the common rule for DT documentation.

Bye,
-- 
Nicolas Ferre
