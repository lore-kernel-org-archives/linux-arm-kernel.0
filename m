From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 20:08:18 +0100
Subject: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
In-Reply-To: <2198668.ESbmzZvna4@avalon>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
 <2198668.ESbmzZvna4@avalon>
Message-ID: <CAMuHMdVH4PyhxR3JLLPX9a3fKaEgdpQpd2aa4YKL6DUD8+Pw2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 5:20 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 24 December 2013 12:56:50 Geert Uytterhoeven wrote:
>> Add pinctrl and SPI devices for RSPI on Genmai.
>>
>> On this board, only rspi4 is in use. It's bus contains a single device
>> (a wm8978 audio codec), for which no bindings are defined yet.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> Cc: devicetree at vger.kernel.org
>> ---
>>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
>> b/arch/arm/boot/dts/r7s72100-genmai-reference.dts index
>> 114510f8bf09..6d99630627e4 100644
>> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
>> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
>> @@ -43,7 +43,7 @@
>>  };
>>
>>  &pfc {
>> -     pinctrl-0 = <&scif2_pins &ethernet_pins>;
>> +     pinctrl-0 = <&scif2_pins &ethernet_pins &rspi4_pins>;
>
> You should add pinctrl-0 and pinctrl-names properties to the spi4 node
> instead. Device nodes should reference their pinctrl configuration directly,
> scif2 and ethernet are exceptions as DT bindings for those devices are not in
> mainline yet.

I put it there because the actual driver doesn't use DT yet. Is that OK?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
