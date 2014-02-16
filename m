From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 16 Feb 2014 18:22:44 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NF0gYnVzOiBpbXgtd2VpbTogc3VwcG9ydCBDUyBHUFIg?=
 =?UTF-8?B?Y29uZmlndXJhdGlvbg==?=
In-Reply-To: <1392559381-30842-1-git-send-email-shawn.guo@linaro.org>
References: <1392559381-30842-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1392560564.725313659@f356.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 16 ??????? 2014, 22:03 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> For imx50-weim and imx6q-weim type of devices, there might a WEIM CS
> space configuration register in General Purpose Register controller,
> e.g. IOMUXC_GPR1 on i.MX6Q.
...
> +static int __init imx_weim_gpr_setup(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct property *prop;
> +	const __be32 *p;
> +	struct regmap *gpr;
> +	u32 gprvals[4] = {
> +		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M) */
> +		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M) */
> +		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> +		01111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> +	};
> +	u32 gprval = 0;
> +	u32 val;
> +	int cs = 0;
> +	int i = 0;
> +
> +	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");
> +	if (IS_ERR(gpr)) {
> +		dev_dbg(&pdev->dev, "failed to find weim-cs-gpr\n");
> +		return 0;

Only one comment:
You do not use these error codes in the probe(),
so let's declare this function as void.

---
