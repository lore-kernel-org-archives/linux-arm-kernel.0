From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 18 Jul 2017 13:59:58 +0000
Subject: [PATCH] ARM: shmobile: rcar-gen2: Correct arch timer frequency on
 RZ/G1E
In-Reply-To: <1500384557-22123-1-git-send-email-geert+renesas@glider.be>
References: <1500384557-22123-1-git-send-email-geert+renesas@glider.be>
Message-ID: <KL1PR06MB1702B09E7C1EFE352D759E5BB8A10@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks good to me.

Regards,
Biju

> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert+renesas at glider.be]
> Sent: 18 July 2017 14:29
> To: Simon Horman <horms@verge.net.au>; Magnus Damm
> <magnus.damm@gmail.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>; Biju Das
> <biju.das@bp.renesas.com>; linux-renesas-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] ARM: shmobile: rcar-gen2: Correct arch timer frequency on
> RZ/G1E
>
> According to the datasheet, the frequency of the ARM architecture timer on
> RZ/G1E depends on the frequency of the ZS clock, just like on R-Car
> E2 and V2H.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.
>
> v2:
>   - Rebased to avoid dependencies.
> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-
> shmobile/setup-rcar-gen2.c
> index 3bd505da31726869..7ab1690fab8299eb 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -70,7 +70,8 @@ void __init rcar_gen2_timer_init(void)
>  void __iomem *base;
>  u32 freq;
>
> -if (of_machine_is_compatible("renesas,r8a7792") ||
> +if (of_machine_is_compatible("renesas,r8a7745") ||
> +    of_machine_is_compatible("renesas,r8a7792") ||
>      of_machine_is_compatible("renesas,r8a7794")) {
>  freq = 260000000 / 8;/* ZS / 8 */
>  /* CNTVOFF has to be initialized either from non-secure
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
