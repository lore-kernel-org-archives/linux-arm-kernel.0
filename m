From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 19 Oct 2018 21:56:34 +0900
Subject: [PATCH 2/9] arm: remove EISA kconfig option
In-Reply-To: <20181019120952.32763-3-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-3-hch@lst.de>
Message-ID: <CAK7LNATc54ZMaKLzabW=NqCQ+WSr-3C7PNAGL6OmOnQf_kgOyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
> which provides support for things like PCI to EISA bridges, so it is most
> likely dead.
>
> If this is wrong we will be able to resurrect it easily by selecting
> HAVE_EISA for the right arm configs after this series.

What is your concern?

This absolutely looks dead to me.


> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..e33735ce1c14 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -165,21 +165,6 @@ config HAVE_PROC_CPU
>  config NO_IOPORT_MAP
>         bool
>
> -config EISA
> -       bool

There is no prompt for this symbol.
Hence, there is no way for a user to enable this directly.

'select EISA' is the only way to enable it.

git grep 'select EISA'
gave no hit.

So, we can say it is dead.





> -       ---help---
> -         The Extended Industry Standard Architecture (EISA) bus was
> -         developed as an open alternative to the IBM MicroChannel bus.
> -
> -         The EISA bus provided some of the features of the IBM MicroChannel
> -         bus while maintaining backward compatibility with cards made for
> -         the older ISA bus.  The EISA bus saw limited use between 1988 and
> -         1995 when it was made obsolete by the PCI bus.
> -
> -         Say Y here if you are building a kernel for an EISA-based machine.
> -
> -         Otherwise, say N.
> -
>  config SBUS
>         bool



I guess the situation is the same as powerpc.

The difference between arm and powerpc is the presence of help.

You fold the powerpc change in 9/9.


-- 
Best Regards
Masahiro Yamada
