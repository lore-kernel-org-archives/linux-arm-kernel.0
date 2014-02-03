From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 09:42:58 +0000
Subject: [PATCH 08/18] mfd: max14577: Rename state container to maxim_core
In-Reply-To: <1390911522-28209-9-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203094258.GI13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch continues the preparation for adding support for max77836
> device to existing max14577 driver.
> 
> The patch renames the struct "max14577" state container to "maxim_core".
> This is only a rename-like patch, new code is not added.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c     |   22 +++++------
>  drivers/mfd/max14577.c               |   68 +++++++++++++++++-----------------
>  drivers/power/max14577_charger.c     |   16 ++++----
>  drivers/regulator/max14577.c         |    6 +--
>  include/linux/mfd/max14577-private.h |    5 ++-
>  5 files changed, 60 insertions(+), 57 deletions(-)

Need some more maintainer Acks here.

> -struct max14577 {
> +/*
> + * State container for max14577-like drivers.
> + */

I don't think this comment is required.

Besides that, the code looks fine:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> +struct maxim_core {
>  	struct device *dev;
>  	struct i2c_client *i2c; /* Slave addr = 0x4A */
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
