From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Feb 2014 11:19:56 +0000
Subject: [PATCH v2 1/2] mfd: syscon: Add platform data with a regmap
 config name
In-Reply-To: <1392141165-14338-1-git-send-email-pawel.moll@arm.com>
References: <20140211174829.GJ15081@lee--X1>
 <1392141165-14338-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140212111956.GA15081@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Define syscon platform data structure that can be used
> to define a regmap config name. This is particularly useful
> in the regmap debugfs when there is more than one syscon
> device registered, to distinguish the register blocks.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mfd/syscon.c                 | 4 ++++
>  include/linux/platform_data/syscon.h | 8 ++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 include/linux/platform_data/syscon.h

<snip>

> +#ifndef PLATFORM_DATA_SYSCON_H
> +#define PLATFORM_DATA_SYSCON_H
> +
> +struct syscon_platform_data {
> +	        const char *label;
> +};

Provided you fix this up:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
