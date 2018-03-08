From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 8 Mar 2018 12:15:22 -0800
Subject: [PATCH] ASoC: cygnus: remove redundant assignment to pointer 'res'
In-Reply-To: <20180308133249.22032-1-colin.king@canonical.com>
References: <20180308133249.22032-1-colin.king@canonical.com>
Message-ID: <576fbe04-bef0-171d-a1eb-40c6cbb2874e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good.


On 18-03-08 05:32 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer res is being initialized with a value that is never read
> and re-assigned immediately after, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> sound/soc/bcm/cygnus-ssp.c:1284:19: warning: Value stored to 'res'
> during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   sound/soc/bcm/cygnus-ssp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
> index abafadc0b534..b733f1446353 100644
> --- a/sound/soc/bcm/cygnus-ssp.c
> +++ b/sound/soc/bcm/cygnus-ssp.c
> @@ -1281,7 +1281,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *child_node;
> -	struct resource *res = pdev->resource;
> +	struct resource *res;
>   	struct cygnus_audio *cygaud;
>   	int err = -EINVAL;
>   	int node_count;
