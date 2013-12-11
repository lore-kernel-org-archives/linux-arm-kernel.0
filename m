From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 17:37:47 -0800
Subject: [PATCH v3 22/36] mtd: st_spi_fsm: Provide the default
 read/write configurations
In-Reply-To: <1385727565-25794-23-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-23-git-send-email-lee.jones@linaro.org>
Message-ID: <20131211013747.GJ27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:19:11PM +0000, Lee Jones wrote:
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -28,6 +28,33 @@
...
> +/* Default WRITE configurations */
> +static struct seq_rw_config default_write_configs[] = {
> +	{FLASH_FLAG_WRITE_1_4_4, FLASH_CMD_WRITE_1_4_4, 1, 4, 4, 0x00, 0, 0},
> +	{FLASH_FLAG_WRITE_1_1_4, FLASH_CMD_WRITE_1_1_4, 1, 1, 4, 0x00, 0, 0},
> +	{FLASH_FLAG_WRITE_1_2_2, FLASH_CMD_WRITE_1_2_2, 1, 2, 2, 0x00, 0, 0},
> +	{FLASH_FLAG_WRITE_1_1_2, FLASH_CMD_WRITE_1_1_2, 1, 1, 2, 0x00, 0, 0},
> +	{FLASH_FLAG_READ_WRITE,  FLASH_CMD_WRITE,       1, 1, 1, 0x00, 0, 0},
> +	{0x00,			 0,			 0, 0, 0, 0x00, 0, 0},

^^^ This line has an extra space in it, that throws off the table
alignment.

> +};

Brian
