From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 09:42:15 -0600
Subject: [PATCH v1 16/19] arm: dts: mt7623: fixup available memory size
 on bananapi-r2
In-Reply-To: <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
Message-ID: <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:16:36PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> There is 2GB DDR3 available on bananapi-r2 board as [1] specified.
> 
> [1] http://www.banana-pi.org/r2.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 140ff78..3e8d02c 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -38,6 +38,11 @@
>  			default-state = "off";
>  		};
>  	};
> +
> +	memory {

Unit address?

> +		device_type = "memory";
> +		reg = <0 0x80000000 0 0x80000000>;
> +	};
>  };
>  
>  &afe {
> -- 
> 2.7.4
> 
