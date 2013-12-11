From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 17:27:48 -0800
Subject: [PATCH v3 15/36] mtd: st_spi_fsm: Fetch boot-device from mode pins
In-Reply-To: <1385727565-25794-16-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-16-git-send-email-lee.jones@linaro.org>
Message-ID: <20131211012748.GI27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:19:04PM +0000, Lee Jones wrote:
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -346,9 +348,48 @@ static void stfsm_fetch_platform_configs(struct platform_device *pdev)
...
> +	/* Use device size to determine address width */

Since you're splitting this patch series up so much, shouldn't this
comment go in when you add the two lines below?

>  	if (info->sector_size * info->n_sectors > 0xFFFFFF)
>  		info->flags |= FLASH_FLAG_32BIT_ADDR;
...

BTW, even though it doesn't exactly make for the best (runtime)
bisectability (since your driver is not functional yet), this approach
to splitting your driver introduction into logical chunks does make it a
little easier to review. So thanks.

Brian
