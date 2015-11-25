From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Nov 2015 09:48:35 +0100
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
In-Reply-To: <877fl68uqh.wl%kuninori.morimoto.gx@renesas.com>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
 <20151109012943.GF4832@verge.net.au>
 <CAMuHMdXBQNCibJU4EDuFZX0zRzUZfC_4KTyXFNVLL81a51Q4RA@mail.gmail.com>
 <20151109090139.GM4832@verge.net.au>
 <CAMuHMdWv1Ae1JTDyN2JkuHC1Fmfw25gtmmUkSMUitrUQnv82Ug@mail.gmail.com>
 <20151110001111.GB1040@verge.net.au>
 <20151124023025.GA21853@verge.net.au>
 <87k2p7yjbl.wl%kuninori.morimoto.gx@renesas.com>
 <20151125002752.GH20596@verge.net.au>
 <877fl68uqh.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CAMuHMdV7FZmSU8oK0N_BCAWj5Li_y3NBUeMyCW=5Gu7j1e7T6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san, Simon,

On Wed, Nov 25, 2015 at 7:27 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > I would like to check latest version.
>> > Which branch/tag can I check ?
>>
>> If you want to check for apply-time and compile-time dependencies use
>> the latest renesas-devel tag in my renesas tree.
>>
>> If you want to check run-time you may need to pull in some dependencies,
>> especially the cpg-mssr-v6 branch of Geert's renesas-drivers tree.  A
>> sledge-hammer approach would be to pull in the latest renesas-drivers tag
>> of that tree.
>>
>> In any case I'll need to know what run-time dependencies, other than
>> cpg-mssr, are missing from renesas-next and/or renesas-devel so we can
>> sensibly decide what to queue up.

This is about DT, which is independent from code? ;-)

> Recent renesas-drivers sound has many conflicts, and sound
> has strange behavior. I had tried it before and noticed.
> I'm not sure latest one, but it has conflict log.
> I'm using a littile older kernel, because of above reason.

You mean the conflict when merging vsp1-kms-20151112~4?
As that branch is based on a very old renesas-drivers release, I made
sure that merging it doesn't impact any sound driver. I.e. I reverted
all changes not related to rcar-du and vsp1.

You can verify using git diff 38f5d0b6..1f9e8ee5

> Anyway, I tried below, and I could get sound.

Good, thanks for checking!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
