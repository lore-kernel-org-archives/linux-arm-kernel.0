From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Feb 2016 09:42:55 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <20160205095758.GE16556@verge.net.au>
References: <1452953856-5146-1-git-send-email-dirk.behme@gmail.com>
 <56B2370D.2010102@gmail.com> <20160205095758.GE16556@verge.net.au>
Message-ID: <CAMuHMdVRhwGh2bvfNSguX0XnMW0eEgLRTCt3Y3-+KfV0Jy9WHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Fri, Feb 5, 2016 at 10:57 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Feb 03, 2016 at 06:21:17PM +0100, Dirk Behme wrote:
>> On 16.01.2016 15:17, Dirk Behme wrote:
>> >From: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> >Add device nodes for the L2 caches, and link the CPU node to its L2
>> >cache node.
>> >
>> >The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
>> >128 KiB x 16 ways).
>> >
>> >Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>
> [snip]
>
>> Any further comments to this? If not, could this be applied?
>
> Sorry for the delay.
>
> This looks good; I have queued it up.
>
> It should appear in the next (and devel) branches of my renesas tree soon.
> And in linux-next whenever it includes my updated next branch.

So you not only dropped the (controversial) timing related properties, but
in addition:

+               cache-unified;
+               cache-level = <2>;

At least the "cache-level" property is marked as required in ePAPR.
For "cache-unified", the wording is not that strict in ePAPR, but that property
depends on being a unified cache in the first place.

So I think these two properties should be re-added.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
