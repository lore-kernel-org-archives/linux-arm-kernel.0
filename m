From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 11:19:01 -0800
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Add eeprom information
In-Reply-To: <1456159868-32416-2-git-send-email-nm@ti.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
 <1456159868-32416-2-git-send-email-nm@ti.com>
Message-ID: <20160222191901.GT13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160222 08:51]:
> Add EEPROM at 0x50 that describes the board configuration.
> This is useful for userspace programs that may need to check board
> revision and other similar information.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 36c0fa6c362a..50312f80b972 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -591,6 +591,11 @@
>  		DRVDD-supply = <&vdd_3v3>;
>  		DVDD-supply = <&aic_dvdd>;
>  	};
> +
> +	eeprom: eeprom at 50 {
> +		compatible = "at,24c32";
> +		reg = <0x50>;
> +	};
>  };
>  

Applying into omap-for-v4.6/dt thanks.

Tony
