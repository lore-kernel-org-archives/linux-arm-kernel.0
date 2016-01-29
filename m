From: joshua.henderson@microchip.com (Joshua Henderson)
Date: Fri, 29 Jan 2016 09:00:36 -0700
Subject: [PATCH 03/15] mips: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453868872-26300-4-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-4-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <56AB8CA4.7070803@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2016 09:27 PM, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/mips/ath79/setup.c           | 2 +-
>  arch/mips/jz4740/setup.c          | 2 +-
>  arch/mips/mti-sead3/sead3-setup.c | 2 +-
>  arch/mips/pic32/pic32mzda/init.c  | 3 +--
>  arch/mips/pistachio/init.c        | 2 +-
>  arch/mips/xilfpga/init.c          | 2 +-
>  6 files changed, 6 insertions(+), 7 deletions(-)
> 

[...]

> diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
> index 775ff90..77ecf32 100644
> --- a/arch/mips/pic32/pic32mzda/init.c
> +++ b/arch/mips/pic32/pic32mzda/init.c
> @@ -147,8 +147,7 @@ static int __init plat_of_setup(void)
>  		panic("Device tree not present");
>  
>  	pic32_of_prepare_platform_data(pic32_auxdata_lookup);
> -	if (of_platform_populate(NULL, of_default_bus_match_table,
> -				 pic32_auxdata_lookup, NULL))
> +	if (of_platform_default_populate(NULL, pic32_auxdata_lookup, NULL))
>  		panic("Failed to populate DT");
>  
>  	return 0;

I'll one-up just compile-testing for this.

Tested-by: Joshua Henderson <joshua.henderson@microchip.com>

[...]
