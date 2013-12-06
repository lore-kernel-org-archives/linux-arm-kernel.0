From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 6 Dec 2013 13:09:06 -0800
Subject: [PATCH 07/10] ARM: dts: sun7i: cubietruck: Enable the GMAC
In-Reply-To: <1386350983-13281-8-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-8-git-send-email-wens@csie.org>
Message-ID: <CAGVrzcb_r9_p4urz4XkE2A-G85KAHJa4PJ=Gt9a4RPYQNJ6j0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/6 Chen-Yu Tsai <wens@csie.org>:
> The CubieTruck uses the GMAC with an RGMII phy.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 8a1009d..af212a2 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -33,6 +33,14 @@
>                         pinctrl-0 = <&uart0_pins_a>;
>                         status = "okay";
>                 };
> +
> +               gmac: ethernet at 01c50000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&gmac_pins_rgmii>;
> +                       snps,phy-addr = <1>;

What is this snps,phy-addr property? Why is not a standard device tree
node for an Ethernet PHY node used?

> +                       phy-mode = "rgmii";

Especially since you use the relatively standard "phy-mode" property here?
--
Florian
