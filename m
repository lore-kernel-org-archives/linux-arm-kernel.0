From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 13 Apr 2016 09:42:59 -0600
Subject: [PATCH] coresight: no need to do the forced type conversion
In-Reply-To: <1460538555-138517-1-git-send-email-lipengcheng8@huawei.com>
References: <1460538555-138517-1-git-send-email-lipengcheng8@huawei.com>
Message-ID: <CANLsYkx658vqSRQKAspTfbuf73Hu14L16zrW4bdXMDewmpeStg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2016 at 03:09, lipengcheng <lipengcheng8@huawei.com> wrote:
> activated and enable are already unsigned type,
> no need to change them to unsigned.
>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index bba9f3d..617574a 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -538,7 +538,7 @@ static ssize_t enable_sink_show(struct device *dev,
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->activated);
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->activated);
>  }
>
>  static ssize_t enable_sink_store(struct device *dev,
> @@ -568,7 +568,7 @@ static ssize_t enable_source_show(struct device *dev,
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->enable);
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
>  }

Applied - thanks.
Mathieu

>
>  static ssize_t enable_source_store(struct device *dev,
> --
> 1.8.3.2
>
