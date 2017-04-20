From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Apr 2017 13:36:28 +0200
Subject: [PATCH/RFC v2 1/2] arm64: dts: r8a7795: Add support for R-Car H3
 ES2.0
In-Reply-To: <3119026.3cPho1BBNv@avalon>
References: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
 <1714563.qChlbIjNcO@avalon>
 <CAMuHMdWmvhZjxKfEdGJ3d_w0d2s2kK+8iW1tsEM584qZc+dVEQ@mail.gmail.com>
 <3119026.3cPho1BBNv@avalon>
Message-ID: <CAMuHMdXvd_S_mRkO1Oayuxhb1husgMZf8P1Yj+cepJu_YBEQ1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Apr 20, 2017 at 1:24 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 20 Apr 2017 12:55:28 Geert Uytterhoeven wrote:
>> On Thu, Apr 20, 2017 at 12:42 PM, Laurent Pinchart wrote:
>> > On Thursday 20 Apr 2017 11:36:59 Geert Uytterhoeven wrote:
>> >> On Mon, Mar 27, 2017 at 10:48 AM, Laurent Pinchart wrote:
>> >>> On Friday 24 Mar 2017 14:37:44 Geert Uytterhoeven wrote:
>> >>>> Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
>> >>>>   - The following devices no longer exist on ES2.0, and are thus
>> >>>>     removed:
>> >>>>     fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
>> >>>>
>> >>>>   - The DU <-> VSPD topology is different on ES2.0, hence remove the
>> >>>>     "vsps" property from the DU node until the driver can handle this.
>> >>>
>> >>> I think I'll need a different compatible string between ES1.x and ES2
>> >>> for the DU. It could make sense to move the whole DU node to *-es1.dtsi.
>> >>> We can decide about that later when I'll have a DU driver prototype
>> >>> ready.
>> >>
>> >> Why would you need a different compatible string?
>> >> Can't you use soc_device_match() to handle ES1.x SoCs?
>> >>
>> >> The different DU <-> VSPD topology is handled through the vsps property
>> >> in
>> >> DTS. Are the ports different, too? That can be handled in DTS.
>> >
>> > My point (not expressed clearly) was that, as I'll need a different vsps
>> > property, I can as well go for a different compatible string.
>>
>> Do you need a different vsps property?
>> AFAIK, the current array links each DU channel to a VSPD.
>> When a VSPD is shared between multiple channels, you can still link these
>> channels to the same VSPD.
>>
>> Or is my understanding incorrect?
>
> Do you mean listing the same VSP multiple times in the vsps array ? Yes, from

Yes, that's what I mean.

> a bindings point of view I think that would work too. That is, until we get a

OK.

> ES2.1 that will have a completely different hardware topology :-)

We'll fix that after we have received ES2.1 documentation...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
