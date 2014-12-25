From: paul@pauljones.id.au (Paul Jones)
Date: Thu, 25 Dec 2014 08:13:09 +0000
Subject: [linux-sunxi] [PATCH] ARM: dts: Fix missing usb0_reset for
 sun4i / sun5i
In-Reply-To: <1419448758-22371-2-git-send-email-hdegoede@redhat.com>
References: <1419448758-22371-1-git-send-email-hdegoede@redhat.com>
 <1419448758-22371-2-git-send-email-hdegoede@redhat.com>
Message-ID: <B7F2379062E32745A8651FBDB20F64593F4B4A74@Server.waterlogic.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-sunxi at googlegroups.com [mailto:linux-
> sunxi at googlegroups.com] On Behalf Of Hans de Goede
> Sent: Thursday, 25 December 2014 6:19 AM
> To: Maxime Ripard
> Cc: linux-arm-kernel at lists.infradead.org; devicetree; linux-
> sunxi at googlegroups.com; Roman Byshko; Alain Durand; Hans de Goede
> Subject: [linux-sunxi] [PATCH] ARM: dts: Fix missing usb0_reset for sun4i /
> sun5i
> 
> The recent sun4i-usb-phy changes to add (preliminary) support for the oth
> phy, cause the ehci/ohci controllers to no longer work on sun4i / sun5i,
> because the phy driver refuses to load due to a missing usb0_reset reset
> controller in the dts files for sun4i / sun5i:

Should that be otg phy?


Paul.
 
> [    0.094293] sun4i-usb-phy 1c13400.phy: failed to get reset usb0_reset
> [    0.094326] sun4i-usb-phy: probe of 1c13400.phy failed with error -22
> 
> This fixes this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 4 ++--  arch/arm/boot/dts/sun5i-
> a10s.dtsi | 4 ++--  arch/arm/boot/dts/sun5i-a13.dtsi  | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-
> a10.dtsi
> index 03e6843..356efb8 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -445,8 +445,8 @@
>  			reg-names = "phy_ctrl", "pmu1", "pmu2";
>  			clocks = <&usb_clk 8>;
>  			clock-names = "usb_phy";
> -			resets = <&usb_clk 1>, <&usb_clk 2>;
> -			reset-names = "usb1_reset", "usb2_reset";
> +			resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
> +			reset-names = "usb0_reset", "usb1_reset",
> "usb2_reset";
>  			status = "disabled";
>  		};
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-
> a10s.dtsi
> index f936b03..668521d 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -397,8 +397,8 @@
>  			reg-names = "phy_ctrl", "pmu1";
>  			clocks = <&usb_clk 8>;
>  			clock-names = "usb_phy";
> -			resets = <&usb_clk 1>;
> -			reset-names = "usb1_reset";
> +			resets = <&usb_clk 0>, <&usb_clk 1>;
> +			reset-names =  "usb0_reset", "usb1_reset";
>  			status = "disabled";
>  		};
> 
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-
> a13.dtsi
> index 3306254..02a9459 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -362,8 +362,8 @@
>  			reg-names = "phy_ctrl", "pmu1";
>  			clocks = <&usb_clk 8>;
>  			clock-names = "usb_phy";
> -			resets = <&usb_clk 1>;
> -			reset-names = "usb1_reset";
> +			resets = <&usb_clk 0>, <&usb_clk 1>;
> +			reset-names =  "usb0_reset", "usb1_reset";
>  			status = "disabled";
>  		};
> 
> --
> 2.1.0
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
