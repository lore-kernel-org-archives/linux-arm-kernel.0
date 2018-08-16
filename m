From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:13:03 +0100
Subject: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
In-Reply-To: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5cd6b8a8-2370-517d-deb1-378bff6e362b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

The patch looks good to me. One minor nit below.

On 14/08/18 23:14, Mathieu Poirier wrote:
> This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
> as it is for the ETF and ETR drivers.  This streamlines the code and adds
> commonality with the other drivers when dealing with similar operations.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
>   1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 9fd77fdc1244..69287163ce4e 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c

> @@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
> +	if (drvdata->mode == CS_MODE_SYSFS) {
>   		etb_disable_hw(drvdata);
>   		etb_dump_hw(drvdata);
>   		etb_enable_hw(drvdata);

Looks good to me.

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
