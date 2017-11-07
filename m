From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 7 Nov 2017 09:54:27 +0200
Subject: [PATCH] ARM: dts: add phy-reset property for rk3066a-rayeager emac
In-Reply-To: <1510022959-19440-1-git-send-email-zyw@rock-chips.com>
References: <1510022959-19440-1-git-send-email-zyw@rock-chips.com>
Message-ID: <e6f2393e-cb3b-9006-d0f5-6b30fd2a5192@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On 11/07/2017 04:49 AM, Chris Zhong wrote:
> The ethernet phy of rk3066a-rayeager has a reset pin, it controlled by
> GPIO1_D6, this pin should be pull down then pull up to reset the phy.
> Add a phy-reset property in emac, make the phy can be reset when emac
> power on.

for PHY reset there are properties 'reset-gpios' and 'reset-delay-us',
please reference to Documentation/devicetree/bindings/net/mdio.txt

Can you try to reuse them instead of adding new custom properties?

As a side question, which is mainly addressed to Sergei and Roger,
I don't quite understand why PHY properties were initially added to
MAC/MDIO bus device tree nodes, in my opinion they must be moved under
PHY device tree nodes.

--
With best wishes,
Vladimir

> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3066a-rayeager.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
> index 570157f..6064a0a 100644
> --- a/arch/arm/boot/dts/rk3066a-rayeager.dts
> +++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
> @@ -173,6 +173,8 @@
>  	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&rmii_rst>;
>  	phy = <&phy0>;
>  	phy-supply = <&vcc_rmii>;
> +	phy-reset-gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>; /* PHY_RST */
> +	phy-reset-duration = <10>; /* millisecond */
>  	status = "okay";
>  
>  	phy0: ethernet-phy at 0 {
> 
