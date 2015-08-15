From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 15 Aug 2015 09:21:56 +0200 (CEST)
Subject: [PATCH RFC 3/3] nvmem: add permission flags in nvmem_config
In-Reply-To: <1439291024-18375-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439290931-18232-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1439291024-18375-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1634428787.18822.1439623316281.JavaMail.open-xchange@oxbsltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 11. August 2015 um
> 13:03 geschrieben:
>
>
> This patch adds perm variable to nvmem_config structure which will allow
> providers to specify the permissions required for the sysfs binary file.
> This permission is applied on top of root-only access permissions set by
> the core.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> drivers/nvmem/core.c | 1 +
> include/linux/nvmem-provider.h | 1 +
> 2 files changed, 2 insertions(+)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 414ed23..7481387 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -312,6 +312,7 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
> config->read_only;
> nvmem->bin = bin_attr_template;
> nvmem->bin.attr.mode = nvmem->read_only ? : (S_IRUSR | S_IWUSR);
> + nvmem->bin.attr.mode |= config->perm;
> nvmem->bin.size = nvmem->size;
> device_initialize(&nvmem->dev);
>
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 0b68caf..de9a61f 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -23,6 +23,7 @@ struct nvmem_config {
> const struct nvmem_cell_info *cells;
> int ncells;
> bool read_only;
> + u16 perm; /* visibility in sysfs */

how about "umode_t mode" or "umode_t sysfs_mode"?

Beside that the whole series looks good to me.

Thanks Stefan
