From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Aug 2018 09:33:16 +0100
Subject: [PATCH v2 03/29] nvmem: add a notifier chain
In-Reply-To: <20180810080526.27207-4-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-4-brgl@bgdev.pl>
Message-ID: <343dde5f-7e92-426f-89e4-1bfcf6714337@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
> +int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_register_notifier);
> +
> +int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
> +
Kerneldoc is missing for these both exported symbols too!

--srini
