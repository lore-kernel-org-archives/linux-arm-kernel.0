From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 6 Jun 2013 16:44:46 +0530
Subject: [PATCH 03/13] ARM: dts: fork out common Exynos5 nodes
In-Reply-To: <1370516488-25860-3-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CAK9yfHxv7EG_1rtgpOwo3HDN7TdfjnK3wH4bAG=RKQJDeW+hHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2013 16:31, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> In preparation of adding support for Exynos5420, which has many peripherals
> similar to Exynos5250, a new common Exynos5 device tree source file is
> created out of the existing Exynos5250 device tree source file. Only the
> common nodes required for basic boot up on Exynos5420 based boards are moved
> into this new file and the rest of the common nodes would be moved subsequently.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |  121 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   74 +----------------------
>  2 files changed, 122 insertions(+), 73 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5.dtsi
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> new file mode 100644
> index 0000000..ab56608
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -0,0 +1,121 @@
> +/*
> + * Samsung's Exynos5 SoC series common device tree source
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
> + * SoCs from Exynos5 series can include this file and provide values for SoCs
> + * specfic bindings.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "skeleton.dtsi"

Perhaps you could use #include here and rest of the places in this patch?

-- 
With warm regards,
Sachin
