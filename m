From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 23 Aug 2017 10:28:42 +0300
Subject: [PATCH net-next v2 10/10] arm64: dts: marvell: mcbin: enable
 more networking ports
In-Reply-To: <20170822170830.32413-11-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
 <20170822170830.32413-11-antoine.tenart@free-electrons.com>
Message-ID: <20170823072842.ibk6gqtswhamvppy@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Tue, Aug 22, 2017 at 07:08:30PM +0200, Antoine Tenart wrote:
> This patch enables the two GE/SFP ports. They are configured in 10GKR
> mode by default. To do this the cpm_xdmio is enabled as well, and two
> phy descriptions are added.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Tested-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index abd39d1c1739..6cb4b000e1ac 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -127,6 +127,30 @@
>  	};
>  };
>  
> +&cpm_xmdio {
> +	status = "okay";
> +
> +	phy0: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <0>;
> +	};
> +
> +	phy1: ethernet-phy at 1 {

Should be named 'ethernet-phy at 8' to match the 'reg' property.

> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <8>;
> +	};
> +};

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
