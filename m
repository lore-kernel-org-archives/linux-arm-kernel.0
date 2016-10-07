From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 7 Oct 2016 12:11:38 +0200
Subject: [PATCH v3 03/11] ARM: shmobile: r8a7743: basic SoC support
In-Reply-To: <836d9018-e8f4-27ef-bfff-06932184d59f@cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <15557770.lH5aPepOeZ@wasted.cogentembedded.com>
 <20161007031537.GK13721@verge.net.au> <2345971.ESZSzve5jF@avalon>
 <836d9018-e8f4-27ef-bfff-06932184d59f@cogentembedded.com>
Message-ID: <CAMuHMdWH8_uREVnc6_iFqAw3Ms+fV3hXpy5Pngn+zcei1EOOpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Oct 7, 2016 at 12:02 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/7/2016 11:33 AM, Laurent Pinchart wrote:
>>>> Add minimal support for the RZ/G1M (R8A7743) SoC.
>>>> Based on the original (and large) patch by Dmitry Shifrin
>>>> <dmitry.shifrin@cogentembedded.com>.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>
>>> Thanks, I have queued this up.
>>
>>
>> I'd like to see this patch rebased on top of "[PATCH] ARM: shmobile:
>> Consolidate R8A779[234] machine definitions".
>
>
>    R87743 is analogous to R8A7791, not R8A779[234], not sure how it is
> connected to your patch.

The comment

+       /*
+        * R8A7790 and R8A7791 can't be handled here as long as they need SMP
+        * initialization fallback.
+        */

is not about r8a7790/r8a7791 in se, but about backward compatibility support
for DTBs without APMU nodes and CPU enable-methods.

For new SoCs, we mandate the presence of these in the DTB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
