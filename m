From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 06 Dec 2012 10:16:45 +0000
Subject: [PATCH v2 1/2] ARM: Exynos5250: Enabling ehci-s5p driver
In-Reply-To: <1352357665-7435-2-git-send-email-gautam.vivek@samsung.com>
References: <1352357665-7435-1-git-send-email-gautam.vivek@samsung.com>
 <1352357665-7435-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20121206101645.4C28E3E05A4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Nov 2012 12:24:24 +0530, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Adding EHCI device tree node for Exynos5250 along with
> the device base adress and gpio line for vbus.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |   25 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 +++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    6 ++++
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +
>  5 files changed, 38 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> new file mode 100644
> index 0000000..833f5cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -0,0 +1,25 @@
> +Samsung Exynos SoC USB controller
> +
> +The USB devices interface with USB controllers on Exynos SOCs.
> +The device node has following properties.
> +
> +EHCI
> +Required properties:
> + - compatible: should be "samsung,exynos-ehci" for USB 2.0

Ditto here. Please be specific in compatible strings.  "samsung,exynos5250-ehci"

Otherwise the binding looks fine to me.

g.
