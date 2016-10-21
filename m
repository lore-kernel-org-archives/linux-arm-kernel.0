From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 21 Oct 2016 18:18:10 +0200
Subject: [PATCH v3 0/2] Add MK808 RK3066 device
In-Reply-To: <cover.1475957884.git.paweljarosz3691@gmail.com>
References: <cover.1475957884.git.paweljarosz3691@gmail.com>
Message-ID: <1671843.4nkAJvukGm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 8. Oktober 2016, 22:21:47 CEST schrieb Pawe? Jarosz:
> Add MK808 RK3066 device
> 
> This patchset adds support for Rikomagic MK808 v1 device with RK901 wifi.
> 
> It is hdmi stick with two usb ports(host and otg), sdmmc, wifi and uart
> onboard.
> 
> It is RK3066 based.
> 
> Pawe? Jarosz (2):
>   devicetree: Add vendor prefix for Rikomagic
>   ARM: dts: rockchip: Add rk3066 MK808 board

applied both patches with received tags for 4.10.

If you have time could try to do a followup patch, adding (and testing) the 
usbphy supplies please?

Should be like

&usbphy0 {
	phy-supply = <&vcc_otg>;
};

&usbphy1 {
	phy-supply = <&vcc_host>;
};

That way we can drop the regulator-always-on property from those two supplies.


Thanks
Heiko
