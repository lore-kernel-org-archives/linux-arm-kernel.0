From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 7 Dec 2013 09:23:27 +0800
Subject: [PATCH 02/10] net: stmmac: Honor DT parameter to force DMA store
 and forward mode
In-Reply-To: <20131206.162606.2277176361893801778.davem@davemloft.net>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-3-git-send-email-wens@csie.org>
 <20131206.162606.2277176361893801778.davem@davemloft.net>
Message-ID: <CAGb2v67ZNtbQm+ZW5v_3wNbz1=oLhXks6gbTSjLYa=Nnoz8w-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending reply due to incorrect MIME type.

On Sat, Dec 7, 2013 at 5:26 AM, David Miller <davem@davemloft.net> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
> Date: Sat,  7 Dec 2013 01:29:35 +0800
>
> > @@ -47,6 +47,7 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
> >               plat->bus_id = 0;
> >
> >       of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr);
> > +     plat->force_sf_dma_mode = of_property_read_bool(np, "snps,force_sf_dma_mode");
>
> Will this do the right thing for when the property is not present?
> Right now the force_sf_dma_mode value is always false.

of_property_read_bool will return false when the property is not present.

> In fact won't it override the explicit settings done elsewhere in the
> driver?

Point taken. The current implementation will override settings passed from
platform data. ORing the two would be better.


Thanks
