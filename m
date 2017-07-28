From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Jul 2017 11:54:27 +0200
Subject: [PATCH 3/3] net-next: stmmac: dwmac-sun8i: choose internal PHY
 via compatible
In-Reply-To: <CAGb2v64w-KCmYExN7OqvuLj42-pHN-BN5iKpxA+KW84v+RfCDQ@mail.gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728092818.23419-4-clabbe.montjoie@gmail.com>
 <CAGb2v64w-KCmYExN7OqvuLj42-pHN-BN5iKpxA+KW84v+RfCDQ@mail.gmail.com>
Message-ID: <20170728095427.GA31579@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 05:49:55PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 28, 2017 at 5:28 PM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > The current way to find if the phy is internal is to compare DT phy-mode
> > and emac_variant/internal_phy.
> > But it will negate a possible future SoC where an external PHY use the
> > same phy mode than the internal one.
> >
> > This patch adds a new way to find if the PHY is internal, via its
> > compatible.
> >
> > Since the phy_mode of the internal PHY does need to be know, the
> > variant internal_phy member is converted to a boolean.
> >
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > index fffd6d5fc907..04f7ddd802b0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > @@ -48,7 +48,7 @@
> >   */
> >  struct emac_variant {
> >         u32 default_syscon_value;
> > -       int internal_phy;
> > +       bool internal_phy;
> 
> Nit: please add a verb to the name, like "has_internal_phy",
> or even "soc_has_internal_phy". This makes it clear what this
> property represents.
> 
> ChenYu

I will use soc_has_internal_phy

Thanks
