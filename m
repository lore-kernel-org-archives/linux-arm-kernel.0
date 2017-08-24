From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 24 Aug 2017 13:56:16 +0200
Subject: [PATCH 3/4] arm: dts: gr-peach: Add ETHER pin group
In-Reply-To: <20170824114656.GA3905@w540>
References: <1503564523-31899-1-git-send-email-jacopo+renesas@jmondi.org>
 <1503564523-31899-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUoMU=qN3Qjoqmf6uxcS3j5hqthhuBDMPZzA+wSD_BH5A@mail.gmail.com>
 <20170824114656.GA3905@w540>
Message-ID: <CAMuHMdU5Vep+m7XtjcbSvyXUzD_Pn2crcQ68VRmS4bgY44ut0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Thu, Aug 24, 2017 at 1:46 PM, jmondi <jacopo@jmondi.org> wrote:
> On Thu, Aug 24, 2017 at 11:48:14AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Aug 24, 2017 at 10:48 AM, Jacopo Mondi
>> <jacopo+renesas@jmondi.org> wrote:
>> > Add pin configuration subnode for ETHER pin group.
>> > The interface can be configured and probed, but no traffic can be
>> > transmitted or received.
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> >
>> > ---
>> > When in u-boot console I can ping a connected host, after the
>> > system has booted I can configure an ip address on the interface but
>> > cannot exchange any traffic.
>> > I have compared the pin configuration procedure with the u-boot
>> > implemented one and some sketches from mbed operating system libraries,
>> > the configured pins are correct and registers values seems to match.
>> > Not sure if this patch should be sent for inclusion but sending it out
>> > anyway for you to judge this.

>> All OK, but do you need P4_2, which is used for ET_nRST?
>
> I tried requesting the GPIO in the "ether" subnode and define it as
> "active low", so that it is kept high during regular operations.
> I have verified through register writes dump it is cycled just after
> the gpio is requested, and this should reset the interface before the
> actual sh_eth driver kicks in.
>
> I haven't find any mention in device tree bindings documentation of a
> "reset-gpio" property for sh_eth, in the code examples I've seen in
> u-boot and mbed, the interface is reset before any actual
> configuration is performed. I feel like that should be the place where
> that gpio is requested and cycled...

Documentation/devicetree/bindings/net/mdio.txt says

These are generic properties that can apply to any MDIO bus.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
