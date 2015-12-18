From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Dec 2015 14:33:59 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <5673F46C.2070501@gmail.com>
References: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
 <1449904607-4060-2-git-send-email-dirk.behme@gmail.com>
 <CAMuHMdXpgtPDMBUd_aJsxvh1oFF36i5AnTTSvh+1kmEzcWkGyg@mail.gmail.com>
 <5673F46C.2070501@gmail.com>
Message-ID: <CAMuHMdUjjR1UuQDCwsV4U-tSR95W_Go_2u=BBehotCd9vQ9ZJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Fri, Dec 18, 2015 at 12:56 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
> On 18.12.2015 12:03, Geert Uytterhoeven wrote:
>> On Sat, Dec 12, 2015 at 8:16 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>> Add device nodes for the L2 caches, and link the CPU node to its L2
>>> cache node.
>>>
>>> The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
>>> 128 KiB x 16 ways).
>>>
>>> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
>>> 32 KiB x 16 ways).
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>>> ---
>>> Note: Geert: I picked your patch from
>>>
>>> http://www.spinics.net/lists/arm-kernel/msg466628.html
>>>
>>> incoporated some review comments and rebased it against
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/log/?h=next
>>> renesas-next-20151211v2-v4.4-rc1
>>
>> This is more or less what I have locally, except that I kept the latency
>> properties
>
> Hmm, maybe I missed anything, but the only part reading the latency I can
> find is
>
> arch/arm/mm/cache-l2x0.c
>
> [1] which isn't relevant for arm64?

No driver using a property in DT is not a reason not to put the property in DT.
The r8a7995 datasheet does contain the latency values to use.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
