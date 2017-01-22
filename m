From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Jan 2017 18:12:10 +0000
Subject: [PATCH -next] ARM: 8641/1: treewide: fix error return code in
 hip04_smp_init()
In-Reply-To: <20170122164128.29381-1-weiyj.lk@gmail.com>
References: <20170122164128.29381-1-weiyj.lk@gmail.com>
Message-ID: <20170122181210.GM27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What does this have to do with patch 8641/1
("ARM: 8641/1: treewide: Replace uses of virt_to_phys with __pa_symbol") ?

Your patch also isn't "treewide" either.  Confused.

On Sun, Jan 22, 2017 at 04:41:28PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENODEV from the of_find_compatible_node()
> error handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/arm/mach-hisi/platmcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index a6c1176..f0fff21 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -279,6 +279,8 @@ static int __init hip04_smp_init(void)
>  					 &hip04_boot_method[0], 4);
>  	if (ret)
>  		goto err;
> +
> +	ret = -ENODEV;
>  	np_sctl = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>  	if (!np_sctl)
>  		goto err;
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
