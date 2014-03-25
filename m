From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 25 Mar 2014 09:57:55 -0300
Subject: [RFC 01/47] mtd: nand: export useful functions from core driver
In-Reply-To: <1395735604-26706-2-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20140325125755.GD665@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 25, Lee Jones wrote:
> These functions are utilised by the STM BCH NAND Controller driver.
> 
[..]
> -static int nand_suspend(struct mtd_info *mtd)
> +int nand_suspend(struct mtd_info *mtd)
>  {
>  	return nand_get_device(mtd, FL_PM_SUSPENDED);
>  }
> +EXPORT_SYMBOL(nand_suspend);
>  
>  /**
>   * nand_resume - [MTD Interface] Resume the NAND flash
>   * @mtd: MTD device structure
>   */
> -static void nand_resume(struct mtd_info *mtd)
> +void nand_resume(struct mtd_info *mtd)
>  {
>  	struct nand_chip *chip = mtd->priv;
>  
> @@ -2776,6 +2779,7 @@ static void nand_resume(struct mtd_info *mtd)
>  		pr_err("%s called for a chip which is not in suspended state\n",
>  			__func__);
>  }
> +EXPORT_SYMBOL(nand_resume);
>  

The patch that adds the PM support for the driver makes no use of these.

Can you detail why do you need to export these?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
