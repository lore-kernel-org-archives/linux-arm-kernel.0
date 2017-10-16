From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 16 Oct 2017 08:34:35 +0000
Subject: [PATCH 1/4] ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
In-Reply-To: <1507899796-7941-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507899796-7941-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <KL1PR06MB1702D289BE9642F285CF9ED1B84F0@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like the chosen node "stdout-path = "serial0:115200n8";" is not updated with this patch.

So either drop the patch or fix the chosen node.

Regards,
Biju

> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: 13 October 2017 14:03
> To: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King <linux@armlinux.org.uk>
> Cc: Simon Horman <horms@verge.net.au>; Magnus Damm
> <magnus.damm@gmail.com>; Geert Uytterhoeven <geert@linux-m68k.org>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> renesas-soc at vger.kernel.org; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>
> Subject: [PATCH 1/4] ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
>
> The BSP release from iWave uses /dev/ttySC3 as debug console, this patch
> renames the alias accordingly for compatibility.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> index 52153ec..edda4f1 100644
> --- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> +++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> @@ -16,7 +16,7 @@
>  compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
>
>  aliases {
> -serial0 = &scif4;
> +serial3 = &scif4;
>  ethernet0 = &avb;
>  };
>
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
