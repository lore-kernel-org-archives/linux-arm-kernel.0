From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 9 Oct 2014 14:29:53 +0200
Subject: [PATCH 3/4] ARM: shmobile: r8a7790: Add MMP clock to device tree
In-Reply-To: <1412848985-29353-4-git-send-email-ykaneko0929@gmail.com>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
 <1412848985-29353-4-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdVDEfJzFS6PjczDfZiavxp6LkPgP9i_zWG+Cn0LVfZv-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san, Hosoya-san,

On Thu, Oct 9, 2014 at 12:03 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

Thanks for your patches!

> Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi            | 22 ++++++++++++++--------
>  include/dt-bindings/clock/r8a7790-clock.h | 11 ++++++++++-
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 27c038c..244a838 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi

>                         clock-output-names =
> -                               "jpu", "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0",
> +                               "vcp1", "vcp0", "vpc1", "vpc0", "jpu", "ssp1",
> +                               "tmu1", "pvrsrvkm", "2ddmac", "fdp2", "fdp1",
> +                               "fdp0", "tmu3", "tmu2", "cmt0", "tmu0",

The datasheet calls these clocks "fdp1-2", "fdp1-1", and "fdp1-0", instead
of "fdp2", "fdp1", and "fdp0".

> --- a/include/dt-bindings/clock/r8a7790-clock.h
> +++ b/include/dt-bindings/clock/r8a7790-clock.h

> +#define R8A7790_CLK_2DDMAC             15
> +#define R8A7790_CLK_FDP2               17
> +#define R8A7790_CLK_FDP1               18
> +#define R8A7790_CLK_FDP0               19
>  #define R8A7790_CLK_TMU3               21
>  #define R8A7790_CLK_TMU2               22
>  #define R8A7790_CLK_CMT0               24

Likewise.

My comments also apply to the corresponding patch for r8a7791.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
