From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 May 2017 16:24:53 +0200
Subject: [PATCH 2/2] arm64: marvell: dts: add second 1G port on the Armada
 8040 DB
In-Reply-To: <1494890913-8360-3-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Tue, 16 May 2017 01:28:33 +0200")
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-3-git-send-email-mw@semihalf.com>
Message-ID: <87zie3wszu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On mar., mai 16 2017, Marcin Wojtas <mw@semihalf.com> wrote:

> Armada 8040 DB is equipped with 4 (2x 10G SFI + 2x 1G RGMII)
> ethernet ports of which only one was hitherto enabled.
> Because currently mvpp2 driver is capable of supporting only
> 1G RGMII/SGMII, enable second port from CP slave HW block.
>

Applied on mvebu/dt64

Thanks,

Gregory

> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index dc0d084..3cde649 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -169,6 +169,22 @@
>  	status = "okay";
>  };
>  
> +&cps_mdio {
> +	phy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&cps_ethernet {
> +	status = "okay";
> +};
> +
> +&cps_eth1 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "rgmii-id";
> +};
> +
>  &ap_sdhci0 {
>  	status = "okay";
>  	bus-width = <4>;
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
