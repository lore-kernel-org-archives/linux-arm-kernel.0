From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Oct 2017 14:52:31 +0200
Subject: [PATCH v3 01/10] ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback
 compat string
In-Reply-To: <20171013123311.15278-2-horms+renesas@verge.net.au>
References: <20171013123311.15278-1-horms+renesas@verge.net.au>
 <20171013123311.15278-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdV+8=xDW+AxJkXBfB7EkrNCKErjg7Exv8BFR1m0otSWqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 2:33 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car GPIO Gen1 fallback compat string
> in place of now deprecated non-generation specific
> R-Car GPIO fallback compat string in DT of r8a7778 SoC.
>
> As the driver does not match on "renesas,gpio-r8a7778" there
> are some run-time considerations for this patch:
>
> * When a resulting DTB is used with kernels newer than v4.14 this should
>   not have any run-time effect as renesas,rcar-gen1-gpio is matched by the
>   driver since commit dbd1dad2ab8f ("gpio: rcar: add gen[123] fallback
>   compatibility strings")
>
> * However, when used with older kernels GPIO will be disabled as
>   no compat string match will be made by the driver.
>
> The regression documented above for the new DTB with old kernel case
> is acceptable in my opinion.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v3
> * Consistently use gen1 rather than gen2 binding in patch and refer to it
>   in changelog.
>
> v2
> * Note run-time considerations in changelog as pointed out by
>   Geert Uytterhoeven
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
