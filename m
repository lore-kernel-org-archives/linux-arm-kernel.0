From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 22 Jul 2018 11:31:06 +0200
Subject: [PATCH v4 32/35] mtd: rawnand: tegra: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-33-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-33-miquel.raynal@bootlin.com>
Message-ID: <20180722113106.45c11ecb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:24 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> +	chip = &nand->chip;
> +	chip->controller = &ctrl->controller;
> +	chip->controller->ops = &tegra_nand_controller_ops;

Should be moved next to the controller initialization.
