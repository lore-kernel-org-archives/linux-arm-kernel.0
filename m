From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Jan 2018 11:36:00 +0100
Subject: [PATCH 02/67] alpha: mark jensen as broken
In-Reply-To: <20171229081911.2802-3-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-3-hch@lst.de>
Message-ID: <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> CONFIG_ALPHA_JENSEN has failed to compile since commit aca05038
> ("alpha/dma: use common noop dma ops"), so mark it as broken.

unknown revision or path not in the working tree.
Ah, you dropped the leading "6":
6aca0503847f6329460b15b3ab2b0e30bb752793
is less than 2 years old, though.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b31b974a03cb..e96adcbcab41 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -209,6 +209,7 @@ config ALPHA_EIGER
>
>  config ALPHA_JENSEN
>         bool "Jensen"
> +       depends on BROKEN
>         help
>           DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
>           of the first-generation Alpha systems. A number of these systems

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
