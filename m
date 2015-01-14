From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Jan 2015 11:02:04 +0100
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 CCF Updates for v3.20
In-Reply-To: <20150114002923.GB30021@verge.net.au>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
 <20150112223415.GJ22090@quad.lixom.net>
 <20150113003823.GC27284@verge.net.au>
 <CAMuHMdUgfKQtbjB81_bw8XLGL_zrwNxWt32f7v52KOdb7bNo5A@mail.gmail.com>
 <20150114002923.GB30021@verge.net.au>
Message-ID: <CAMuHMdUbDh8H8ruhuoX9rzEufT3X8gJxx9RNR3ruF8yxMDoSbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jan 14, 2015 at 1:29 AM, Simon Horman <horms@verge.net.au> wrote:
>> > Thanks. The motivation for this branch arrangement was indeed
>> > the atomic switch over.
>>
>> Please correct me if I'm wrong, but IMHO there's no atomicity needed here,
>> as this won't be used until sh73a0 multi-platform support is in.
>
> Ok, it seems that I was slightly mistaken. But we are working towards
> multi-platform support for v3.20, right?

Yes we are ;-)

> Could you take a moment to look at what is currently queued up in
> the sh73a0-multiplatform-for-v3.20 branch, which is based on this
> pull-request and see if you think any re-arrangement of that branch
> is in order.

You already have drivers-for-v3.20 as a separate branch this depends on.
The remaining commits are mostly DTS, except for (1)

    ARM: shmobile: sh73a0: Introduce generic setup callback
    ARM: shmobile: sh73a0: Add Multiplatform support

and (1)

    ARM: shmobile: kzm9g-reference: Remove board C code and DT file

(1) could be done in an SoC support code branch, as (codewise) it's independent
from the rest.
(2) could be done in a board removal branch, but it's only a single commit.

>From a functionality point of view, (1) (and all the rest in the branch) is a
dependency of (2), though.

So if no one complains, I'd leave it as-is. Splitting it up is not
gonna makes things
simpler when I submit my next series ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
