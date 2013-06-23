From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 23 Jun 2013 12:51:48 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiA1LzVdIEFSTTogZHRzOiBBZGQgZGV2aWNlIHRyZWUg?=
 =?UTF-8?B?c3VwcG9ydCBmb3IgcGh5Y2FyZCBwY2ExMDA=?=
In-Reply-To: <1371977061-9891-6-git-send-email-mpa@pengutronix.de>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
 <1371977061-9891-6-git-send-email-mpa@pengutronix.de>
Message-ID: <1371977508.741905381@f196.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Board files for Phytec PhyCARD-S "System on Module" and "Rapid
> Development Kit".
> 
> Based on patches from:
> 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>  - Original patch
>  - ARM: dts: Set partition offsets for phycard
>  - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
>  - ARM: imx27-phytec-phycard-S.dts: resize nand partitions
> 
> Jan Luebbe <jlu@pengutronix.de>:
>  - ARM: dts: Enable bad block table in NAND
> 
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
...
> +/ {
> +	model = "Phytec pca100";
> +	compatible = "phytec,imx27-pca100", "fsl,imx27";
> +
> +	memory {
> +		reg = <0x0 0x08000000>; /* 128MB */
> +	};
> +};

Memory at 0x0? Probably this should be 0xa0000000, where first
SDRAM bank is placed.

---
