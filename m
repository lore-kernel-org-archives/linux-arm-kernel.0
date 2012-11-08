From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 8 Nov 2012 18:29:12 +0530
Subject: [PATCH 4/4] arm/dts: am33xx: Add CPSW and MDIO module nodes for
 AM33XX
In-Reply-To: <50914107.2090909@ti.com>
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
 <1351498881-32482-6-git-send-email-hvaibhav@ti.com> <50914107.2090909@ti.com>
Message-ID: <509BACA0.8060409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 8:47 PM, Benoit Cousson wrote:
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index c634f87..e233cfa 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -78,3 +78,11 @@
>   		};
>   	};
>   };
> +
> +&cpsw_emac0 {
> +	phy_id = "4a101000.mdio:00";
> Why are you using that kind of interface? You seem to want a reference
> to a device.
>
> Cannot you have something less hard coded like:
> phy_id = <&davinci_mdio>, <0>;
Benoit

I am having a issue in converting the above phy_id conversion from 
"<&davinci_mdio>, <0>" to
"4a101000.mdio:00". Since davinci_mdio is a child node to cpsw, the 
platform device for mdio is
not created to get the mdio device name "4a101000.mdio".
Can you point me a reference to get the right implementation.

Regards
Mugunthan V N
