From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Apr 2017 04:02:03 +0200
Subject: [PATCH 1/5] mtd: nand: gpmi: unify clock handling
In-Reply-To: <20170421010755.18025-2-stefan@agner.ch>
References: <20170421010755.18025-1-stefan@agner.ch>
 <20170421010755.18025-2-stefan@agner.ch>
Message-ID: <66b18c07-54f1-a532-5fce-e1759c5d3488@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 03:07 AM, Stefan Agner wrote:
> Add device specific list of clocks required, and handle all clocks
> in a single for loop. This avoids further code duplication when
> adding i.MX 7 support.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

[...]

> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> index 4e49a1f5fa27..2e584e18d980 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> @@ -130,6 +130,8 @@ struct gpmi_devdata {
>  	enum gpmi_type type;
>  	int bch_max_ecc_strength;
>  	int max_chain_delay; /* See the async EDO mode */
> +	const char * const *clks;
> +	int clks_count;

const int ? :)

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
