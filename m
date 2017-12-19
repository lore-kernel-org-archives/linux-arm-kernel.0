From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Dec 2017 09:45:05 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7745: move timer node out of bus
In-Reply-To: <20171218215044.13088-3-horms+renesas@verge.net.au>
References: <20171218215044.13088-1-horms+renesas@verge.net.au>
 <20171218215044.13088-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUELsg=qPrho-SmekY_d24q9waUwGS90HFEKQsSV1w7=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:50 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The timer node does not have any register properties and thus shouldn't be
> placed on the bus.
>
> This problem is flagged by the compiler as follows:
> $ make dtbs W=1
> ...
> arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
>   DTC     arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb
> arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
