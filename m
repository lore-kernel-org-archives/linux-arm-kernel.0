From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 15:22:56 +0900
Subject: [PATCH v2 4/7] ARM: dts: rockchip: add virtual iommu for display
In-Reply-To: <1465392392-2003-5-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-5-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5AU2xV98bAEDvPpV1-5ED3oCMgp9vuTymX-RpWFVhH=mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> An virtual iommu without reg or interrupts for display.
> Adding this according to iommu driver changes.
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 7fa932f..4cd535f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -219,9 +219,15 @@
>                 clock-names = "timer", "pclk";
>         };
>
> +       display_mmu: virtual-iommu {
> +               compatible = "rockchip,iommu";
> +               #iommu-cells = <0>;
> +       };
> +

Device tree should describe real hardware and so it isn't really a
good idea to add such virtual iommu, especially using a compatible
string of a real device.

Please see my comments to patch 3/7 for an alternative idea.

Best regards,
Tomasz
