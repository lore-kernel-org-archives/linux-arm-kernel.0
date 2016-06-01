From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jun 2016 14:27:57 +0200
Subject: [PATCH 13/13] ARM: dts: blanche: add Ethernet support
In-Reply-To: <a60346f2-2abb-342b-dd20-38d401c4ceb3@cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
 <CAMuHMdU2P6VKXNpEHGOKpyuM45Pk0CuHWngxwu5AYGqYfduXXg@mail.gmail.com>
 <a60346f2-2abb-342b-dd20-38d401c4ceb3@cogentembedded.com>
Message-ID: <CAMuHMdXUdg8+ux2j5SsthZS6DWZnHfan0jL=PpYEwfnS7fbRkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 1, 2016 at 2:16 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 6/1/2016 11:22 AM, Geert Uytterhoeven wrote:
>>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>>
>>> +       ethernet at 18000000 {
>>> +               compatible = "smsc,lan89218", "smsc,lan9115";
>>
>>
>> The "smsc,lan89218" needs to be documented in the device tree bindings.
>
>    Have you looked at those bindings?

Now I did.

>> Google couldn't find any evidence you submitted a patch for that.
>
>    Because the bindings document *any* LAN9115 compatible chip already.

Ah, generic wildcard, not listing valid values. Hence checkpatch complained...

Google predict-while-you-type suggests "lan89218aq"? Should you use that?
BTW, that's why we always want to document all valid values...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
