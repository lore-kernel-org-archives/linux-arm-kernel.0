From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 5 Jul 2017 15:02:04 +0000
Subject: [PATCH v 1/2] ravb: Add support for r8a7743 SoC
In-Reply-To: <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
References: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
 <1499259711-56175-2-git-send-email-biju.das@bp.renesas.com>
 <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
Message-ID: <KL1PR06MB1702A7AAAE97FBC67578E985B8D40@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> owner at vger.kernel.org] On Behalf Of Sergei Shtylyov
> Sent: 05 July 2017 14:21
> To: Biju Das <biju.das@bp.renesas.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Russell King
> <linux@armlinux.org.uk>
> Cc: Simon Horman <horms@verge.net.au>; Magnus Damm
> <magnus.damm@gmail.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org
> Subject: Re: [PATCH v 1/2] ravb: Add support for r8a7743 SoC
>
> Hello!
>
> On 07/05/2017 04:01 PM, Biju Das wrote:
>
> > Add support for Gigabit Ethernet E-MAC on r8a7743 (RZ/G1M) SoC.
> > Renesas RZ/G1M (R8A7743) SoC Ethernet AVB IP is identical to the R-Car
> > Gen2 family.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> [...]
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> > b/drivers/net/ethernet/renesas/ravb_main.c
> > index 5931e85..e35b30f 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -1869,6 +1869,7 @@ static int ravb_mdio_release(struct ravb_private
> > *priv)  }
> >
> >  static const struct of_device_id ravb_match_table[] = {
> > +{ .compatible = "renesas,etheravb-r8a7743", .data = (void
> > +*)RCAR_GEN2 },
>
>     No, this shouldn't be needed if you specify "renesas,etheravb-rcar-gen2".
>

Thanks for the review. I will remove this change.

> >  { .compatible = "renesas,etheravb-r8a7790", .data = (void
> *)RCAR_GEN2 },
> >  { .compatible = "renesas,etheravb-r8a7794", .data = (void
> *)RCAR_GEN2 },
> >  { .compatible = "renesas,etheravb-rcar-gen2", .data = (void
> > *)RCAR_GEN2 },
>
> MBR, Sergei
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
