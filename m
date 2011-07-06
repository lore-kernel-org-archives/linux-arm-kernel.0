From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jul 2011 09:53:31 +0300
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309771536-10597-4-git-send-email-leiwen@marvell.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
Message-ID: <1309935216.3149.72.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem is that in this patch you change  struct pxa3xx_nand_platform_data,
and in the next patch you amend the platform data declarations, which means that
the kernel will not compile between patches 3 and 4...

On Mon, 2011-07-04 at 02:25 -0700, Lei Wen wrote:
> +               dev_info(&info->pdev->dev, "There is no nand chip on cs %d!\n"
> +                               , info->cs); 

Nitpick - keep the comma at the first line.

-- 
Best Regards,
Artem Bityutskiy
