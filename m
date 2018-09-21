From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 20 Sep 2018 18:12:12 -0700
Subject: [PATCH v4 15/22] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <20180914144011.27614-16-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
 <20180914144011.27614-16-brgl@bgdev.pl>
Message-ID: <822f2631-43e3-b4e8-91f6-8c8e94be3dde@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/09/18 07:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a way for machine code users to associate devices with nvmem cells.
> 
> This restores the support for non-DT systems but following a different
> approach. Cells must now be associated with devices using provided
> routines and data structures before they can be retrieved using
> nvmem_cell_get().
> 
> It's still possible to define cells statically in nvmem_config but
> cells created this way still need to be associated with consumers using
> lookup entries.
> 
> Note that nvmem_find() must be moves higher in the source file as we
> want to call it from __nvmem_device_get() for devices that don't have
> a device node.
> 
> The signature of __nvmem_device_get() is also changed as it's no longer
> used to retrieve cells.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 129 ++++++++++++++++++++++++++-------
>   include/linux/nvmem-consumer.h |  28 +++++++
>   2 files changed, 131 insertions(+), 26 deletions(-)

This patch and other follow on patches for core.c does not apply on top 
of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Please rebase and send!

thanks,
srini
