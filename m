From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 11 Sep 2017 16:11:31 +0900
Subject: [PATCH net-next 1/3] dt-bindings: net: add DT bindings for
 Socionext UniPhier AVE
In-Reply-To: <20170908140322.GD25219@lunn.ch>
References: <1504875731-3680-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20170908140322.GD25219@lunn.ch>
Message-ID: <20170911161130.671B.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, 8 Sep 2017 16:03:22 +0200 <andrew@lunn.ch> wrote:

> > +	eth: ethernet at 65000000 {
> > +		compatible = "socionext,uniphier-ave4";
> > +		reg = <0x65000000 0x8500>;
> > +		interrupts = <0 66 4>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ether_rgmii>;
> > +		phy-mode = "rgmii";
> > +		socionext,desc-bits = <64>;
> > +		local-mac-address = [00 00 00 00 00 00];
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> > +		ethphy: ethphy at 1 {
> > +			reg = <1>;
> > +		};
> 
> 
> So you normally have an mdio node, and the phy as a children of that
> node.
> 
>        mdio {
>                 ethphy: ethernet-phy at 6 {
>                         reg = <6>;
>                 };
>         };
> 
> 	Andrew

I see. I'll rewrite the binding example using mdio node.

---
Best Regards,
Kunihiko Hayashi
