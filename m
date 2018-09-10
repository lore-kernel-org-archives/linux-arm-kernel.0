From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 08:33:26 +0100
Subject: [PATCH v2 07/16] nvmem: change the signature of nvmem_unregister()
In-Reply-To: <20180907100750.14564-8-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-8-brgl@bgdev.pl>
Message-ID: <545e0e3a-7728-7179-2bc3-fbb813e3c39d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This function can no longer fail and there are no more users that check
> it return value. Change it to return void.

This should be either part of Kref patch or it should state that 
refcount handling is impoved in Kref patch so there is no need of 
returning error code from unregister.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 8 ++------
>   include/linux/nvmem-provider.h | 9 +++------
>   2 files changed, 5 insertions(+), 12 deletions(-)
