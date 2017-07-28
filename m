From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Jul 2017 17:53:40 +0800
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v66=h_5df=B0Us-kvvFg9r_qSUroDzn-xvQLSpD1d8DhBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 5:28 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> Hello
>
> The current way to find if the phy is internal is to compare DT phy-mode
> and emac_variant/internal_phy.
> But it will negate a possible future SoC where an external PHY use the
> same phy mode than the internal one.
>
> This patchs series adds a new way to find if the PHY is internal, via its
> compatible.

You've already joined in on the discussion for the patch "net: stmmac:
dwmac-rk: Add internal phy support". It is pretty much the same issue.
Please wait for it to come to a proper conclusion. At least then we can
agree on something so different platforms with the same problem don't
have diverging solutions.

ChenYu

>
> Corentin Labbe (3):
>   dt-bindings: net: add compatible for internal sun8i-h3/sun8i-v3s PHYs
>   ARM: sunxi: h3/h5: Add sun8i-h3-ephy compatible
>   net-next: stmmac: dwmac-sun8i: choose internal PHY via compatible
>
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt |  4 ++--
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                    |  3 ++-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     | 16 ++++++++++------
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> --
> 2.13.0
>
