From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 07 Nov 2014 17:52:23 +0100
Subject: [PATCH] ARM: dts: rockchip: add pinctrl nodes for SPDIF, LCDC, CIF,
 HDMI, USB and GPS
In-Reply-To: <1415373589-11650-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1415373589-11650-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <5384745.1WqprI8GVl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Am Freitag, 7. November 2014, 16:19:49 schrieb Julien CHAUVEAU:
> On RK3066, add pinctrl nodes for SPDIF, LCDC1, CIF0/1, HDMI and USB.
> On RK3188, add pinctrl nodes for SPDIF, LCDC1, CIF and GPS.

Please don't bulk-add pinctrl settings nobody is using for the forseeable 
future. There are currently no spdif, lcdc, cif and hdmi drivers for those 
socs and things like the usb_vbus and sd_pwr pins are used as gpios through 
regulators.

Pinctrl settings can be added in the same patch adding the device node, 
_after_ a driver got accepted.


> At the same time, add some missing pinctrl for SDMMC0 and SDMMC1
> and fix the unit addresses of GPIO0 and GPIO1 banks in rk3188.dtsi.

I you're concatenating change descriptions by "and" or your "At the same 
time", it's a good indicator that these should be two separate patches.
The general rule is, one patch - one issue.


So I'd suggest resending the address fix for the two gpios and leaving the pin 
settings be till something really uses them,


Heiko
