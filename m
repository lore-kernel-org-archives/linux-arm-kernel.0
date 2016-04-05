From: msalter@redhat.com (Mark Salter)
Date: Tue, 05 Apr 2016 09:50:43 -0400
Subject: [PATCH v3 04/14] c6x: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1459835982-26473-5-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
 <1459835982-26473-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459864243.10130.17.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-05 at 13:59 +0800, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Acked-by: Mark Salter <msalter@redhat.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Acked-by: Mark Salter <msalter@redhat.com>

> ?arch/c6x/platforms/platform.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/c6x/platforms/platform.c b/arch/c6x/platforms/platform.c
> index 26c1a35..8412334 100644
> --- a/arch/c6x/platforms/platform.c
> +++ b/arch/c6x/platforms/platform.c
> @@ -11,7 +11,7 @@
> ?
> ?static int __init c6x_device_probe(void)
> ?{
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_default_populate(NULL, NULL, NULL);
> ?	return 0;
> ?}
> ?core_initcall(c6x_device_probe);
