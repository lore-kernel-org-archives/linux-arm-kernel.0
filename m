From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 2 Jan 2017 09:59:24 +0100
Subject: [PATCH 3/8] ARM: dts: armada-388-clearfog: Utilize new DSA binding
In-Reply-To: <20170102022249.10657-4-f.fainelli@gmail.com>
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-4-f.fainelli@gmail.com>
Message-ID: <0997385a-700c-bbcc-4194-77f641885cbd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 01/02/2017 03:22 AM, Florian Fainelli wrote:
> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net:
> dsa: Document new binding"). The legacy binding node is kept included, but is
> marked disabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/armada-388-clearfog.dts | 65 +++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
> index 71ce201c903e..35207aa1f4ec 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dts
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dts
> @@ -351,6 +351,8 @@
>  	};
>  
>  	dsa at 0 {
> +		status = "okay";

I think you wanted "disabled" here !

> +
>  		compatible = "marvell,dsa";
>  		dsa,ethernet = <&eth1>;
>  		dsa,mii-bus = <&mdio>;
> @@ -444,3 +446,66 @@
>  		status = "disabled";
>  	};
>  };
[...]

Neil
