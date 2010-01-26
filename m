From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 26 Jan 2010 11:01:41 +0000
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
	<771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
	<20100125135628.GB26613@rakim.wolfsonmicro.main>
	<771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
Message-ID: <1264503701.3067.69.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-26 at 01:26 -0500, Haojian Zhuang wrote:
> From 2b5a73c336d2b5dc48c8cf1f2a804b6968659f78 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 25 Jan 2010 10:24:09 -0500
> Subject: [PATCH] regulator: enable max8649 regulator driver
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Can you confirm all the changes compared to the last version. 

> +static int max8649_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
> +       unsigned char data;
> +       int ret;
> +
> +       ret = max8649_reg_read(info->i2c, info->vol_reg);
> +       if (ret < 0)
> +               return ret;
> +       data = (unsigned char)ret & MAX8649_VOL_MASK;
> +       return (max8649_list_voltage(rdev, data));

Any reason why we have extra () here ?

Thanks

Liam
