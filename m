From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 11:08:08 -0800
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page
 I/O support
In-Reply-To: <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105190808.GR20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing on this patch:

On Tue, Nov 05, 2013 at 09:55:29AM -0300, Ezequiel Garcia wrote:
> @@ -437,7 +487,7 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
>  
>  static void handle_data_pio(struct pxa3xx_nand_info *info)
>  {
> -	unsigned int do_bytes = min(info->data_size, info->fifo_size);
> +	unsigned int do_bytes = min(info->data_size, info->chunk_size);

After this change, you no longer are using fifo_size globally (you only
use it locally in pxa3xx_nand_detect_config() to set the chunk_size).
Perhaps you can drop the field?

>  
>  	switch (info->state) {
>  	case STATE_PIO_WRITING:

Brian
