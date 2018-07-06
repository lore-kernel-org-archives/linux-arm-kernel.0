From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 6 Jul 2018 09:56:23 +0200
Subject: [PATCH 5/5] ARM: shmobile: defconfig: Set CONFIG_LOCALVERSION
In-Reply-To: <20180705155513.ooppf45agiebi732@verge.net.au>
References: <20180704114333.27584-1-geert+renesas@glider.be>
 <20180704114333.27584-6-geert+renesas@glider.be>
 <20180705155513.ooppf45agiebi732@verge.net.au>
Message-ID: <CAMuHMdUFz8M08r76Ly=iAaGPsg-JaFaZz3Vb+bgn=a1ZNe-=Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Jul 5, 2018 at 5:55 PM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 04, 2018 at 01:43:33PM +0200, Geert Uytterhoeven wrote:
> > This allows to derive the kernel flavor from the kernel version at
> > runtime.
>
> For my edification could you expand on what this is used for?

With this, the kernel version (as printed during boot, and returned by
e.g. "uname -r") will be something like

    4.18.0-rc3-shmobile-02146-gd2f8e14acc47b8ea

instead of

    dmesg-4.18.0-rc3

which makes it easy to differentiate them from

    4.18.0-rc3-koelsch-02146-gd2f8e14acc47b8ea
    4.17.0-rc1-rcar2-initrd-00547-g19c9f87b5c449c23-dirty

which are built from my personal configs for Koelsch resp. R-Car Gen2
with initrd.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -1,3 +1,4 @@
> > +CONFIG_LOCALVERSION="-shmobile"

We already have

    CONFIG_LOCALVERSION="-arm64-renesas"

in arch/arm64/configs/renesas_defconfig, to differentiate kernels built
from that config with kernels built from arm64 defconfig (which set it to
"-arm64" in my local tree).

All of this makes it easy to keep e.g. a collection of boot logs using
"dmesg > dmesg-$(uname -r)", and compare them.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
