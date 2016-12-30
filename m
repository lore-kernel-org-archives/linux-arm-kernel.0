From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Fri, 30 Dec 2016 16:58:51 +0800
Subject: [PATCH v5 12/14] irqchip: mbigen: drop module owner
In-Reply-To: <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
Message-ID: <586621CB.50307@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Module owner will be set by driver core, so drop it.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> ---
>   drivers/irqchip/irq-mbigen.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 03b79b0..c01ab41 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -293,7 +293,6 @@ static int mbigen_device_probe(struct platform_device *pdev)
>   static struct platform_driver mbigen_platform_driver = {
>   	.driver = {
>   		.name		= "Hisilicon MBIGEN-V2",
> -		.owner		= THIS_MODULE,
>   		.of_match_table	= mbigen_of_match,
>   	},
>   	.probe			= mbigen_device_probe,
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
