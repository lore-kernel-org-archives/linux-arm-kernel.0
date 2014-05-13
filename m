From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 09:07:13 +0900
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <CAMuHMdX_19vLyO7fqaBO7=WpdoZ8fYm9BU9Zmj6cXSNDNYE+Kw@mail.gmail.com>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
 <536C1945.1000601@cogentembedded.com>
 <20140509050610.GB2624@katana>
 <536D5DC3.3070409@cogentembedded.com>
 <20140511000834.GM31760@verge.net.au>
 <CAMuHMdX_19vLyO7fqaBO7=WpdoZ8fYm9BU9Zmj6cXSNDNYE+Kw@mail.gmail.com>
Message-ID: <20140513000713.GB18157@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 09:35:46AM +0200, Geert Uytterhoeven wrote:
> On Sun, May 11, 2014 at 2:08 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sat, May 10, 2014 at 02:59:15AM +0400, Sergei Shtylyov wrote:
> >> Hello.
> >>
> >> On 05/09/2014 09:06 AM, Wolfram Sang wrote:
> >>
> >> >>>+  eeprom at 50 {
> >> >>>+          compatible = "renesas,24c02";
> >>
> >> >>    This is not quite right: Renesas' part is called differently, and
> >> >>you're carrying the other vendor's naming onto Renesas parts. I'd
> >> >>just say "24c02" (which I'll do in the Henninger board patch).
> >>
> >> >What about "generic"?
> >>
> >>    I don't know, really. However, you're right in that there should
> >> be some vendor prefix -- I've just seen
> >> Documentation/devicetree/bindings/eeprom.txt.
> >
> > A quick survey of arch/arm/boot/dts/ yields:
> >
> > "atmel,24c02" (22 times)
> > "microchip,24c02" (once)
> > "mcp,24c02" (once)
> >
> > So it seems to me that precedence is in favour of using "renesas,24c02".
> 
> Except that the Renesas part is called differently (as Sergei already pointed
> out), unlike the Atmel and Microchip parts.
> 
> So it should be:
> 
>         compatible = "renesas,r1ex24002", "<something>,24c02";
> 
> Unfortunately the datasheet doesn't mention compatibility with parts from
> other manufacturers.
> 
> So let's <something> be "atmel"?

If <something> isn't documented as being compatible then
I feel that we should not add it to the list.

> BTW, we have a similar issue with Genmai, which has an R1EX24128.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
