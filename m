From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 16 Jun 2016 00:11:11 +0200
Subject: [v2 PATCH 1/4] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <1465810789-22303-2-git-send-email-zyw@rock-chips.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <1465810789-22303-2-git-send-email-zyw@rock-chips.com>
Message-ID: <2262175.XUeGlE1YsE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 17:39:46 schrieb Chris Zhong:
> This patch adds a binding that describes the Rockchip USB Type-C PHY
> for rk3399
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - add some registers description
> 
> Changes in v1:
> - add extcon node description
> - move the registers in phy driver
> - remove the suffix of reset
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 77
> ++++++++++++++++++++++ 1 file changed, 77 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt new file
> mode 100644
> index 0000000..430920c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -0,0 +1,77 @@
> +* ROCKCHIP type-c PHY
> +---------------------
> +
> +Required properties:
> + - compatible : should be "rockchip,rk3399-typec-phy0" or
> +			 "rockchip,rk3399-typec-phy1"
> + - reg: Address and length of the usb phy control register set
> + - rockchip,grf : phandle to the syscon managing the "general
> +   register files"
> + - clocks : phandle + clock specifier for the phy clocks
> + - clock-names : string, clock name, must be "tcpdcore", "tcpdphy_ref";
> + - resets : a list of phandle + reset specifier pairs
> + - reset-names : string reset name, must be:
> +		 "tcphy", "tcphy_pipe", "uphy_tcphy"
> + - #phy-cells : Must be 0.  See ./phy-bindings.txt for details.
> + - extcon : extcon specifier for the Power Delivery
> +
> +Note, there are 2 type-c phys for RK3399, and they are almost identical,
> except +these registers(description below), every register node contains
> 3 sections: +offset, enable bit, write mask bit.
> + - rockchip,typec_conn_dir : the register of type-c connector direction,
> +   for type-c phy0, it must be <0xe580 0 16>;
> +   for type-c phy1, it must be <0xe58c 0 16>;

I think I said this already, but these register-lists would be much happier 
being defined inside the driver - see how Frank managed this on his usb2phy 
please.

Heiko
