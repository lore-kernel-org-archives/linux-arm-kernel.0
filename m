From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 1 Nov 2018 00:27:30 +0900
Subject: [PATCH 3/9] powerpc: remove CONFIG_PCI_QSPAN
In-Reply-To: <20181019120952.32763-4-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-4-hch@lst.de>
Message-ID: <CAK7LNATPnn=8B2jisxfwOg5KWr1YSkBJEtiquzK9GQ8s-D2Q9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This option isn't actually used anywhere.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---


Applied to linux-kbuild.




>  arch/powerpc/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..e8c8970248bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -955,7 +955,6 @@ config PCI
>         bool "PCI support" if PPC_PCI_CHOICE
>         default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
>                 && !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> -       default PCI_QSPAN if PPC_8xx
>         select GENERIC_PCI_IOMAP
>         help
>           Find out whether your system includes a PCI bus. PCI is the name of
> @@ -969,14 +968,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>         def_bool PCI
>
> -config PCI_QSPAN
> -       bool "QSpan PCI"
> -       depends on PPC_8xx
> -       select PPC_I8259
> -       help
> -         Say Y here if you have a system based on a Motorola 8xx-series
> -         embedded processor with a QSPAN PCI interface, otherwise say N.
> -
>  config PCI_8260
>         bool
>         depends on PCI && 8260
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
