From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 28 Nov 2015 10:15:50 +0100
Subject: [PATCH] arm: renesas: select PINCTRL for Renesas SoC
In-Reply-To: <1448648871-15008-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1448648871-15008-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAMuHMdVNDWSehXpuBANFCN4HWx7H6ms9o-Ru-nZ7u9QJiUSNbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 7:27 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> If Renesas SoCs are the only devices selected then the
> pinctrl core is not selected and the renesas pfc controller
> will not get included in the kernel.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 25a9031..fc3d692 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -72,6 +72,7 @@ config ARCH_SHMOBILE
>  config ARCH_RENESAS
>         bool "Renesas SoC Platform"
>         select ARCH_SHMOBILE
> +       select PINCTRL

This was added quite a while ago. renesas-devel-20151123-v4.4-rc2 has it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
