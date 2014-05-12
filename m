From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 12 May 2014 16:10:51 +0400
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <CAMuHMdX_19vLyO7fqaBO7=WpdoZ8fYm9BU9Zmj6cXSNDNYE+Kw@mail.gmail.com>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>	<1392633882-12142-2-git-send-email-wsa@the-dreams.de>	<536C1945.1000601@cogentembedded.com>	<20140509050610.GB2624@katana>	<536D5DC3.3070409@cogentembedded.com>	<20140511000834.GM31760@verge.net.au>
 <CAMuHMdX_19vLyO7fqaBO7=WpdoZ8fYm9BU9Zmj6cXSNDNYE+Kw@mail.gmail.com>
Message-ID: <5370BA4B.6070003@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/12/2014 11:35 AM, Geert Uytterhoeven wrote:

>>>>>> +  eeprom at 50 {
>>>>>> +          compatible = "renesas,24c02";

>>>>>     This is not quite right: Renesas' part is called differently, and
>>>>> you're carrying the other vendor's naming onto Renesas parts. I'd
>>>>> just say "24c02" (which I'll do in the Henninger board patch).

>>>> What about "generic"?

>>>     I don't know, really. However, you're right in that there should
>>> be some vendor prefix -- I've just seen
>>> Documentation/devicetree/bindings/eeprom.txt.

>> A quick survey of arch/arm/boot/dts/ yields:

>> "atmel,24c02" (22 times)
>> "microchip,24c02" (once)
>> "mcp,24c02" (once)

>> So it seems to me that precedence is in favour of using "renesas,24c02".

> Except that the Renesas part is called differently (as Sergei already pointed
> out), unlike the Atmel and Microchip parts.

> So it should be:

>          compatible = "renesas,r1ex24002", "<something>,24c02";

    Unfortunately, that way the legacy I2C driver matching used now won't work 
anymore. :-(

> Unfortunately the datasheet doesn't mention compatibility with parts from
> other manufacturers.

> So let's <something> be "atmel"?

    Yes, probably. But the "renesas,r1ex24002" part have to be dropped.

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei
