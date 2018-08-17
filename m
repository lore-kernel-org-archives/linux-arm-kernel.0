From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 17 Aug 2018 10:46:57 +0200
Subject: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <20180719094612.5833-3-yixun.lan@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
Message-ID: <20180817104657.7a1da2c4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

I know I said I would finish reviewing the driver, but I didn't have
time to do it, so feel free to send a new version addressing the
comments I already made.

On Thu, 19 Jul 2018 17:46:12 +0800
Yixun Lan <yixun.lan@amlogic.com> wrote:


> +static void meson_nfc_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +
> +	if (chip < 0 || chip > MAX_CE_NUM)

			^ chip > meson_chip->nsels)

> +		return;
> +
> +	nfc->param.chip_select = meson_chip->sels[chip] ? NAND_CE1 : NAND_CE0;
> +	nfc->param.rb_select = nfc->param.chip_select;
> +}
> +

Regards,

Boris
