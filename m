From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 18 Oct 2018 22:34:26 +0200
Subject: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <20181018223426.5bfa23a1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2018 13:09:05 +0800
Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> +static int meson_nand_bch_mode(struct nand_chip *nand)
> +{
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nand_ecc meson_ecc[] = {
> +		MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
> +		MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
> +		MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
> +		MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
> +		MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
> +		MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
> +	};
> +	int i, ret = 0;
> +
> +	if (nand->ecc.strength > 60 || nand->ecc.strength < 8)
> +		return -EINVAL;
> +
> +	for (i = 0; i < sizeof(meson_ecc); i++) {
> +		if (meson_ecc[i].strength == nand->ecc.strength) {
> +			meson_chip->bch_mode = meson_ecc[i].bch;
> +			break;

			return 0;

> +		}
> +	}
> +
> +	return ret;

	return -EINVAL;

> +}
