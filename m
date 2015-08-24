From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Aug 2015 14:12:06 -0700
Subject: [PATCH 00/18] ARM: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAOesGMjku09wsUmwooq2ZXLyV7CPfioi0oAV5EgvW_wE98VYeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2015 at 9:36 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, SoC code can not add const qualifier to smp_operations
> structures although they are never over-written.
>
> 01/18 and 02/18 add small changes to the ARM core to fix that.
> The rest of this series replace "__initdata" with "const ... __initconst"
> for each of SoC code.
>
> I split this series into per-SoC so that each sub-arch maintainer
> can easily give their Acked-by.  (Is this better?)

When you split, chances are each sub-arch maintainer will apply
instead of ack. If that's what you want, that's fine.

> Russell, Olof, and Arnd:
>
> How should this series be applied (if it looks good)?
> The first two are ARM-tree wide and looks like in the field of Russell.
> The rest are highly SoC-related.

Easiest of all would probably be to get the sub-arch patches into one
release, then switch the prototypes and function definitions in the
next. If you switch prototypes first you'll get a bunch of warnings,
right?


-Olof
