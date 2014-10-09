From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 9 Oct 2014 14:27:07 +0200
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Add RGX clock to device tree
In-Reply-To: <1412848985-29353-2-git-send-email-ykaneko0929@gmail.com>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
 <1412848985-29353-2-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdV59fkhAxGrvx4VERWPm5v4roy1WNVyPAO73+W-bPn16A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san, Abe-san,

On Thu, Oct 9, 2014 at 12:03 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Kouei Abe <kouei.abe.cp@renesas.com>

Thanks for your patches!

> Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi            | 9 +++++----
>  include/dt-bindings/clock/r8a7790-clock.h | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 2380fd5..27c038c 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi

>                         clock-output-names =
> -                               "jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
> -                               "vsp1-du0", "vsp1-rt", "vsp1-sy";
> +                               "jpu", "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0",
> +                               "vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";

Why is this clock called "pvrsrvkm"?
The datasheet calls this clock "3DG".

> --- a/include/dt-bindings/clock/r8a7790-clock.h
> +++ b/include/dt-bindings/clock/r8a7790-clock.h

> +#define R8A7790_CLK_PVRSRVKM           12

Likewise.

My comments also apply to the corresponding patch for r8a7791.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
