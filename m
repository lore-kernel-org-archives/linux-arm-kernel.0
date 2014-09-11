From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 11 Sep 2014 12:20:30 -0300
Subject: [PATCH] mtd: nand: atmel_nand: retrieve NFC clock
In-Reply-To: <1410446617-29572-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410446617-29572-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140911152029.GA16666@arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 11 Sep 04:43 PM, Alexandre Belloni wrote:
> @@ -2276,6 +2280,16 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	nfc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(nfc->clk)) {
> +		dev_warn(&pdev->dev, "NFC clock is missing");
> +		return 0;
> +	}
> +

The binding documentation makes no mention to a clock.

Anyway, with or without the docs I think this patch breaks DT backward
compatibility.

Or am I missing something?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
