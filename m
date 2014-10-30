From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 10:26:33 +0100
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix SPI mode of SPI-Flash into
 mode3
In-Reply-To: <1414648551-30318-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648551-30318-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVQ0s35sW=kvf80c0s++R-5uNuJQtxMcX1R5ogxNwkp9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:55 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> In order to change into mode3, CPOL and CPHA bit of SPCMD register
> of MSIOF is changed. Mode3 can avoid intermediate voltage.

This is the QSPI node, not MSIOF?

> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
>
>  arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 830f2e8..1606fad 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -343,6 +343,8 @@
>                 spi-tx-bus-width = <4>;
>                 spi-rx-bus-width = <4>;
>                 m25p,fast-read;
> +               spi-cpol;
> +               spi-cpha;
>
>                 partition at 0 {
>                         label = "loader";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
