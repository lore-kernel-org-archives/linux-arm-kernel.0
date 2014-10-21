From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 21 Oct 2014 14:22:27 -0400
Subject: [PATCH 1/2] ARM: dts: k2e-mvm: add 1g ethernet phys nodes
In-Reply-To: <1413811244-4041-1-git-send-email-grygorii.strashko@ti.com>
References: <1413811244-4041-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <5446A463.8020601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 09:20 AM, Grygorii Strashko wrote:
> Keystone K2E-EVM has two 1G Marvell 88E1514 Ethernet PHYs
> installed, which are compatible with 88E1510.
> Hence, add corresponding child nodes for 1G MDIO bus.
>
> For more information see:
>    https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
>
> Signed-off-by: Grygorii Strashko<grygorii.strashko@ti.com>
> ---
>   arch/arm/boot/dts/k2e-evm.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
> index c568f06..560d621 100644
> --- a/arch/arm/boot/dts/k2e-evm.dts
> +++ b/arch/arm/boot/dts/k2e-evm.dts
> @@ -139,3 +139,15 @@
>   		};
>   	};
>   };
> +
> +&mdio {
> +	ethphy0: ethernet-phy at 0 {
> +		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
> +		reg =<0>;
> +	};
> +
> +	ethphy1: ethernet-phy at 1 {
> +		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
> +		reg =<1>;
> +	};
> +};

In the subject do s/k2e-mvm/k2e-evm/

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
