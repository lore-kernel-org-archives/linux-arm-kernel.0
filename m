From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 17:44:20 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: Add support for rk3399
 excavator main board
In-Reply-To: <1501756357-10511-2-git-send-email-jacob-chen@iotwrt.com>
References: <1501756357-10511-1-git-send-email-jacob-chen@iotwrt.com>
 <1501756357-10511-2-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1833135.MvGxPPiF9h@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. August 2017, 18:32:37 CEST schrieb Jacob Chen:
> Add support for the rk3399 excavator main board.
> This board works in a combination with the sapphire SOM.
> 
> This board have been sold as the rk3399 evaluation board for commercial customers.
> You can get more info from below link:
> http://opensource.rock-chips.com/wiki_Excavator_sapphire_board
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>


> +&spdif {
> +	pinctrl-0 = <&spdif_bus>;

part of the core spdif node in rk3399 so dropped this one

> +	i2c-scl-rising-time-ns = <450>;
> +	i2c-scl-falling-time-ns = <15>;
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +};

applied for 4.14 with the above and some property reordering.
I've also added an entry to
	Documentation/devicetree/bindings/arm/rockchip.txt
for the board. When adding future boards, please always also add an
entry for that.


Thanks
Heiko
