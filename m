From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Aug 2017 10:42:51 +0800
Subject: [PATCH 2/3] ARM: sun8i: sunxi-h3-h5: add phy-is-integrated
 property to internal PHY
In-Reply-To: <20170810085129.20463-3-clabbe.montjoie@gmail.com>
References: <20170810085129.20463-1-clabbe.montjoie@gmail.com>
 <20170810085129.20463-3-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v64dBZgN6-8kHnnN1qiEXHnbXw_FM9WxGHPU0h-tZDbspA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 10, 2017 at 4:51 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch add the new phy-is-integrated property to the internal PHY
> node.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 4b599b5d26f6..54fc24e4c569 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -425,6 +425,7 @@
>                                         reg = <1>;
>                                         clocks = <&ccu CLK_BUS_EPHY>;
>                                         resets = <&ccu RST_BUS_EPHY>;
> +                                       phy-is-integrated;

You also need to "delete" this property at the board level for
any board that has the external PHY at address <1>. Otherwise
they will stop working. This is due to the internal and external
PHYs having the same path and node name in the device tree, so
they are effectively the same node.

ChenYu

>                                 };
>                         };
>                 };
> --
> 2.13.0
>
