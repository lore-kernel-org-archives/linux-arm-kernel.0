From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 24 Apr 2017 18:09:30 -0700
Subject: [PATCH v3 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <1489651362-17077-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1489651362-17077-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170425010930.GA120971@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 09:02:40AM +0100, Boris Brezillon wrote:

> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> new file mode 100644
> index 000000000000..f71b9e5d7d9d
> --- /dev/null
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -0,0 +1,2198 @@
[...]

> +static int
> +atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
> +{
> +	struct regmap_config regmap_conf = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.val_bits = 32,

You assigned val_bits twice. Is that just a harmless mistake, or did you
mean to set something else?

(sparse and other tools complain about this)

> +	};


Brian
