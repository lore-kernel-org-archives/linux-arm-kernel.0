From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Jul 2014 08:46:52 -0700
Subject: [PATCH 1/4] Documentation: dt-bindings: add dt binding info for
 Rockchip dwc2
In-Reply-To: <1406683873-18194-2-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406683873-18194-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=X2ZZkK=18T=c40a3ZkwaoDk5Vf0hCir_OdC7r888hwUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Jul 29, 2014 at 6:31 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This add necessary dwc2 binding documentation for Rockchip socs:
> rk3066, rk3188 and rk3288
>
> add dr_mode as optional properties.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index aa91034..eb80d7b 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -4,6 +4,9 @@ Platform DesignWare HS OTG USB 2.0 controller
>  Required properties:
>  - compatible : One of:
>    - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
> +  - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
> +  - "rockchip,rk3188-usb","rockchip,rk3066-usb": for rk3188 Soc;
> +  - "rockchip,rk3288-usb","rockchip,rk3066-usb": for rk3288 Soc;
>    - snps,dwc2: A generic DWC2 USB controller with default parameters.
>  - reg : Should contain 1 register range (address and length)
>  - interrupts : Should contain 1 interrupt
> @@ -15,6 +18,8 @@ Optional properties:
>  - phys: phy provider specifier
>  - phy-names: shall be "usb2-phy"
>  Refer to phy/phy-bindings.txt for generic phy consumer properties
> +- dr_mode: shall be one of "host", "peripheral" and "otg"
> +  Refer to usb/generic.txt

One other note: Maybe we should break this series into two different
patch series'.  I think that the patches for doing "dr_mode" can be
totally separate from the ones adding support for rockchip, right?

-Doug
