From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 9 May 2018 15:39:45 +0200
Subject: [PATCH v2] arm64: dts: r8a77965: Add SDHI device nodes
In-Reply-To: <1525869504-3361-1-git-send-email-ykaneko0929@gmail.com>
References: <1525869504-3361-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdWq0w2V-Oskvci6bznTMPRXALVkCtefkFgvSm3Obw-e-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san,

On Wed, May 9, 2018 at 2:38 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Add SDHI nodes to the DT of the r8a77965 SoC.
>
> Based on several similar patches of the R8A7796 device tree
> by Simon Horman <horms+renesas@verge.net.au>.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on the devel branch of Simon Horman's renesas tree.
>
> v2 [Yoshihiro Kaneko]
> * As suggested by Simon Horman
> Rebased on top of the devel branch of the renesas tree.

Thanks for the update!

>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 36 +++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> index ba0edda..510815e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -978,23 +978,51 @@
>                 };
>
>                 sdhi0: sd at ee100000 {
> +                       compatible = "renesas,sdhi-r8a77965",
> +                                    "renesas,rcar-gen3-sdhi";
>                         reg = <0 0xee100000 0 0x2000>;
> -                       /* placeholder */
> +                       interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 314>;
> +                       max-frequency = <200000000>;
> +                       power-domains = <&sysc 32>;

In the mean time, <dt-bindings/power/r8a77965-sysc.h> has landed
upstream, so please use R8A77965_PD_ALWAYS_ON.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
