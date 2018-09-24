From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 24 Sep 2018 13:03:41 +0200
Subject: [PATCH] arm64: dts: broadcom: Use the .dtb name in the rule,
 rather than .dts
In-Reply-To: <20180924102228.19656-1-liviu@dudau.co.uk>
References: <b42d2e57-8bcd-0d6a-7a4d-aeefedcdd5f3@i2se.com>
 <20180924102228.19656-1-liviu@dudau.co.uk>
Message-ID: <539eb374-9122-6c09-4c64-80bfa6b7bf89@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.09.2018 um 12:22 schrieb Liviu Dudau:
> Commit a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
> Module IO Board V3") adds the bcm2837-rpi-cm3-io3.dts file as a target
> in the Makefile, rather than the .dtb name. This will skip the
> generation of the .dtb file at compile time and will fail the dtbs_install
> target.
>
> Fixes: a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
> Module IO Board V3")
>
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, i will add a dtbs_install step to my test jobs.

@Arnd @Olof Should this fix for 4.20 go via pull request or can you
apply it directly to your tree?

> ---
>  arch/arm64/boot/dts/broadcom/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index 3d98f5f5ab88..667ca989c11b 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
>  			      bcm2837-rpi-3-b-plus.dtb \
> -			      bcm2837-rpi-cm3-io3.dts
> +			      bcm2837-rpi-cm3-io3.dtb
>  
>  subdir-y	+= northstar2
>  subdir-y	+= stingray
