From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 1 Sep 2017 11:30:33 +0200
Subject: [PATCH ] ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
In-Reply-To: <20170901084923.GC14918@verge.net.au>
References: <1504106234-41450-1-git-send-email-biju.das@bp.renesas.com>
 <20170831084534.GF29946@verge.net.au>
 <KL1PR06MB170280A3D466C9B35AF73939B89D0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <TY1PR06MB07029D315FC6EE500D1EEA55B79D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <20170901084923.GC14918@verge.net.au>
Message-ID: <CAMuHMdXFO+oirricuB2prtm2ca1AyMLDgx6ib5cVNRK0=7T+5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Sep 1, 2017 at 10:49 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Aug 31, 2017 at 09:32:25AM +0000, Chris Paterson wrote:
>> > From: Biju Das
>> > > From: Simon Horman [mailto:horms at verge.net.au]
>> > > > +       phy3: ethernet-phy at 3 {
>> > > > +       /*
>> > > > +        * On some older versions of the platform (before R4.0) the phy
>> > > address
>> > > > +        * may be 1 or 3. The address is fixed to 3 for R4.0 onwards.
>> > > > +        */
>> > > > +               reg = <3>;
>> > > > +               micrel,led-mode = <1>;
>> > >
>> > > Does the phy have an interrupt?
>> >
>> > The current board doesn't support interrupt . But there is a plan to support this
>> > in future board variants through (GPIO3_28).
>>
>> Actually, the plan has recently changed and at the moment interrupt support will not be added in the production version of the board.
>>
>> If in the end the plan changes again and the actual hardware does add interrupt support we'll submit a new patch accordingly.
>
> Thanks for following-up on this. I'm still surprised there is no interrupt
> - does link speed renegotiation initiated by the other end of the link work
> in a timely manner? - but if its not there and my wishful thinking won't
> make it so.

I guess it behaves similar to Koelsch using the new CPG/MSSR driver, and
without the probe deferral fix for of_mdio, where it also falls back to polling.
Cfr. the figures in
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg17422.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
