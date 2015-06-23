From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Jun 2015 22:16:28 +0200 (CEST)
Subject: [PATCH v6 2/9] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <1435014518-26223-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014518-26223-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <272462057.251967.1435090588801.JavaMail.open-xchange@oxbsltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 23. Juni 2015 um
> 01:08 geschrieben:
>
>
> [...]
> --- /dev/null
> +++ b/include/linux/nvmem-consumer.h
> @@ -0,0 +1,75 @@
> +/*
> + * nvmem framework consumer.
> + *
> + * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> + * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef _LINUX_NVMEM_CONSUMER_H
> +#define _LINUX_NVMEM_CONSUMER_H
> +
> +struct device;

Do we need forward declaration of struct device_node too?

> +/* consumer cookie */
> [...]
> +}
> +#endif /* CONFIG_NVMEM */
> +
> +#if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> +struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> + const char *name);
> +#else
> +static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> + const char *name)
> +{
> + return ERR_PTR(-ENOSYS);
> +}
> +#endif /* CONFIG_NVMEM && CONFIG_OF */
> +
> +#endif /* ifndef _LINUX_NVMEM_CONSUMER_H */
> --
> 1.9.1
