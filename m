From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 08:38:49 +0100
Subject: [PATCH 01/18] Documentation: Describe the ux500 realated audio
 related DT nodes
In-Reply-To: <20120729203106.GD4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
Message-ID: <50163A09.8060203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/12 21:31, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:45:45PM +0100, Lee Jones wrote:
>
>> +++ b/Documentation/devicetree/bindings/sound/ux500.txt
>> @@ -0,0 +1,62 @@
>> +* ux500 Audio Driver and ab8500 Audio CODEC
>> +
>> +Required properties:
>> + - compatible:
>> +   - Machine Driver : "stericsson,snd-soc-mop500"
>> +   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
>> +   - DMA (platform) : "stericsson,ux500-pcm"
>> +   - Audio CODEC    : "stericsson,ab8500-codec"
>
> What is this a binding document for?  It looks like the binding for a
> machine driver...

No, it's a binding document for all of the ux500 driver and CODEC 
blocks. Do you really want me to split it all up? I think the only 
component which could be sanely split-out is the ab8500-codec, which 
could (should?) live in [1].

>> +Optional properties:
>> + - reg              : Physical base address and length of the device's registers.
>> + - interrupts       : The interrupt outputs from the device.
>> + - interrupt-parent : The parent interrupt controller.
>> + - <name>-supply    : Phandle to the regulator <name> supply
>
> ...but these don't look anything like machine driver properties.

These properties are relevant for some, but not all of the components 
above, hence why the are listed at 'optional properties'.

[1] Documentation/devicetree/bindings/mfd/ab8500.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
