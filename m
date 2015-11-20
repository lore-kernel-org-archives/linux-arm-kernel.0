From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 20 Nov 2015 15:47:38 -0800
Subject: [PATCH 1/1] soc: ti: knav_qmss_queue: Fix linking RAM setup for
 queue managers
In-Reply-To: <1448062781-6708-1-git-send-email-michal.1.morawiec.ext@nokia.com>
References: <1448062781-6708-1-git-send-email-michal.1.morawiec.ext@nokia.com>
Message-ID: <564FB11A.3020906@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 3:39 PM, Michal Morawiec wrote:
> Configure linking RAM for both queue managers also in case
> when only linking RAM 0 is specified in device tree.
>
why ?

> Signed-off-by: Michal Morawiec <michal.1.morawiec.ext@nokia.com>
> ---
>   drivers/soc/ti/knav_qmss_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 6d8646d..a809c30 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -1173,7 +1173,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
>
>   		block++;
>   		if (!block->size)
> -			return 0;
> +			continue;
>
You have to expand this a bit for me. Because you really don't
want kernel code to run the configuration on hardware which doesn't
exist. I mean device tree suppose to specify the linking RAM for both
QMs unless and until there is a reason not too.

Regards,
Santosh
