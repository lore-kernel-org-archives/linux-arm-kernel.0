From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 08 Sep 2014 20:43:40 +0200
Subject: [PATCH v5 0/4] Patches to add support for Rockchip dwc2 controller
In-Reply-To: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
References: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <4508852.pY5QcWPyfZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am Freitag, 8. August 2014, 11:55:55 schrieb Kever Yang:
> These patches to add support for dwc2 controller found in
> Rockchip processors rk3066, rk3188 and rk3288,
> and enable dts for rk3288 evb.

will you take patches 1 and 2?


Thanks
Heiko


> 
> Changes in v5:
> - max_transfer_size change to 65535 to met the requirement of
>   header file
> - change the sort order of dwc2 in rk3288.dtsi
> - don't enable otg port for evb
> 
> Changes in v4:
> - max_transfer_size change to 65536, this should be enough
>   for most transfer, the hardware auto-detect will set this
>   to 0x7ffff which may make dma_alloc_coherent fail when
>   non-dword aligned buf from driver like usbnet happen.
> - remove EHCI and HSIC dts patch for Doug had post it seprately.
> 
> Changes in v3:
> - EHCI and HSIC move new for version 3.
> - Rebase
> 
> Changes in v2:
> - Split out dr_mode and rk3288 bindings.
> - add compatible "snps,dwc2" bingding info
> - set most parameters as driver auto-detect
> - evb patch added in version 2
> 
> Kever Yang (4):
>   Documentation: dt-bindings: add dt binding info for Rockchip dwc2
>   usb: dwc2: add compatible data for rockchip soc
>   ARM: dts: add rk3288 dwc2 controller support
>   ARM: dts: Enable USB host1(dwc) on rk3288-evb
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt |  3 +++
>  arch/arm/boot/dts/rk3288-evb.dtsi              |  4 ++++
>  arch/arm/boot/dts/rk3288.dtsi                  | 20 ++++++++++++++++++
>  drivers/usb/dwc2/platform.c                    | 29
> ++++++++++++++++++++++++++ 4 files changed, 56 insertions(+)
