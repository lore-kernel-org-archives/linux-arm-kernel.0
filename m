From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 26 Sep 2012 10:46:01 +0900
Subject: [PATCH V2 3/3] ARM: EXYNOS: Add drm-device node to the dtsi file
In-Reply-To: <1348232397-2477-4-git-send-email-l.krishna@samsung.com>
References: <1348232397-2477-1-git-send-email-l.krishna@samsung.com>
 <1348232397-2477-4-git-send-email-l.krishna@samsung.com>
Message-ID: <135e01cd9b88$aea81140$0bf833c0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leela Krishna Amudala wrote:
> 
> This patch adds platform drm-device node to the dtsi file
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 6401c94..f0cc06d 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -495,4 +495,8 @@
>  		reg = <0x14400000 0x40000>;
>  		interrupts = <18 5>, <18 4>, <18 6>;
>  	};
> +
> +	drm-device {
> +		compatible = "samsung,exynos-drm-device";
> +	};
>  };
> --

Please check below comments from Thomas Abraham and I agree with his
opinion.

There cannot be a node that represents a virtual device. Device tree should
ideally describe the hardware but the above node does not represent a
hardware device. The creation of the platform device instance for the above
device should handled inside the kernel code.

Thanks.

K-Gene <kgene@kernel.org>
