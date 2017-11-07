From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 12:09:27 +0100
Subject: [PATCH] ARM: dts: iwg20d-q7: Add support for ttySC3
In-Reply-To: <TY1PR06MB0895D27B9C7F2D3B3113654EC0460@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1507539981-4193-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUprE7QuXF_sX47JyrvuZXhXnQFufy4OHeJ5ExwwoogKw@mail.gmail.com>
 <TY1PR06MB0895D27B9C7F2D3B3113654EC0460@TY1PR06MB0895.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdXPSUmNiFF7gmkWng5OA_U4DUF+4uohjkjvuMPwgffj-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Mon, Oct 23, 2017 at 3:25 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>> > > --- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
>> > > +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
>> > > @@ -11,6 +11,7 @@
>> > >  / {
>> > >         aliases {
>> > >                 serial0 = &scif0;
>> > > +               serial3 = &scifb1;
>> >
>> > Given this port is not labeled "serial3", but called "data uart", you may want
>> > to add a comment to avoid confusion:
>>
>> It's a little bit confusing, isn't it? The lines related to such interface are named as UART0_x on the carrier board schematic, the section
>> of the schematic that contains the header is named "data uart header", and the board documentation names it explicitly as "UART 3 -
>> /dev/ttySC3 (SCIFB1)".

And you cannot use "serial0" (to match "UART0"), as that's already in use
for the SOM...

>> I don't think there is anything we can do to make this easier for the user really, is there? :D
>> If we decide to add a comment to serial 3, I guess we need to be consistent and add comments for the other serial interfaces too.
>> If you still prefer having a comment there I'll send a v2 and patch(es) for adding comments to the other interfaces, just let me know.
>
> Any thoughts about this?

Making life easier for the user is good.
Consistency is also good.

I have no strong feelings about this, so do as you please...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
