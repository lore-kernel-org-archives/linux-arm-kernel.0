From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Jul 2018 11:05:18 +0200
Subject: [PATCH/RFT 1/7] arm64: dts: renesas: r8a77965: Add Audio-DMAC
 device nodes
In-Reply-To: <1531856883-19645-2-git-send-email-ykaneko0929@gmail.com>
References: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
 <1531856883-19645-2-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdVA_Geohmr+Fy0diaFuHqW-Aiyo_MYOpb=yLy6Cm=H_kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san,

On Tue, Jul 17, 2018 at 9:48 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Audio-DMAC{0,1} device nodes for the R8A77965 SoC.
>
> Based on a similar patch of the R8A7796 device tree
> by uninori Morimoto <kuninori.morimoto.gx@renesas.com>.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -1386,6 +1386,74 @@
>                         status = "disabled";
>                 };
>
> +               audma0: dma-controller at ec700000 {

> +               };
> +

Please respect sort order (by unit address, per device group).
The two audma nodes should be inserted just before usb at ee000000.

>                 ohci0: usb at ee080000 {
>                         compatible = "generic-ohci";
>                         reg = <0 0xee080000 0 0x100>;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
