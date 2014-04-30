From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 30 Apr 2014 22:14:06 +0530
Subject: [PATCH 2/4] ARM: dts: Add usb2phy to Exynos 5250
In-Reply-To: <1398848110-6152-3-git-send-email-gautam.vivek@samsung.com>
References: <1398848110-6152-1-git-send-email-gautam.vivek@samsung.com>
 <1398848110-6152-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAK9yfHyj9xyNiSo6S2bDnF+k1oB3LR+aG+N7Kgg60VPKYKjnjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 30 April 2014 14:25, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> From: Kamil Debski <k.debski@samsung.com>
>
> Add support to PHY of USB2 of the Exynos 5250 SoC.
>
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> [gautam.vivek at samsung.com: Split the usb phy entries from
> syscon entries from earlier patch: dts: Add usb2phy to Exynos 5250]
> [gautam.vivek at samsung.com: Added phy entry for OHCI also along with EHCI]
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>
> Changes from v7:
> None
>
>  arch/arm/boot/dts/exynos5250.dtsi |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 70f0cd5..51e554c 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -563,6 +563,14 @@
>
>                 clocks = <&clock CLK_USB2>;
>                 clock-names = "usbhost";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port at 0 {
> +                       reg = <0>;
> +                       phys = <&usb2_phy_gen 1>;
> +                       phy-names = "host";
> +                       status = "ok";

This should be "okay".

> +               };
>         };
>
>         usb at 12120000 {
> @@ -572,6 +580,14 @@
>
>                 clocks = <&clock CLK_USB2>;
>                 clock-names = "usbhost";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port at 0 {
> +                       reg = <0>;
> +                       phys = <&usb2_phy_gen 1>;
> +                       phy-names = "host";
> +                       status = "ok";

ditto.


-- 
With warm regards,
Sachin
