From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 11 May 2015 19:10:56 -0300
Subject: [PATCH v5 05/12] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <555128F0.30702@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/11/2015 11:58 AM, Antoine Tenart wrote:
[..]
> -
> -	/* calculate flash information */
> -	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
> -

[..]
> @@ -1732,6 +1669,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
>  		host->mtd = mtd;
>  		host->cs = cs;
>  		host->info_data = info;
> +		host->read_id_bytes = 4;

Are you sure this is correct? The value is set according to the page
size before this patch.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
