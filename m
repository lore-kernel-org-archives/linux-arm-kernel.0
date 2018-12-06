Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:12:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3C92082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lW/NCnCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+yaXbS05fErYYwDJqJaAACTK6GFwneW1WUPvAOjwZU=; b=lW/NCnCs4KHZwE
	1zJeU3uKABdnHeUh8cwIvOSLzSBjLjeEdd3U2O89XYvHJ5Gs4JjFPT3SyCzXH5cKDjVn1GGWoOdGy
	b7DuXk1eHzCWhNv+uNaI5GzO/nIyc2gsc2ZUuEpYaJQP9jTWF1+4Ea/K83ndjreMez4cJL4k7f9n5
	v9zvcofawemK1KRXPAFk/JcT+JI6AZPhWCNb/rumBCcllfrtnzIJyqdt4RTO62OhOU6XfYFjkO01x
	QpW0GAajQxHYf9C/BYPpgLc+qF1yM6EXQrXuMxrNZNZMYX7hh/j2VKHLHHexOmw1Dl+oOBu3qNl1K
	1n4V/DgHKq0q0T9MOGGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUhHR-00024T-Gp; Thu, 06 Dec 2018 00:12:37 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUhHL-00022z-0b
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 00:12:35 +0000
Received: by mail-ot1-f67.google.com with SMTP id v23so20410807otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 16:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sRBJaTb1NcTx5xdS9WeLKqDV55sdxP7Eq42Mc/LQ4fA=;
 b=asV3HDD+y+9jUCW4gIJ0Y06et4WJi8eRElEkXKUXNahwlbJ1abgrrhj/Af8QHuYFOt
 jJ7xXhHCbj2tJGJ9ngnOstrNyqgzRb12z6o7hOaR8ihipkEWGV6jqkKdUjCpMJdvgda4
 Zn5PKRN168kEWkfwxMywCkUPfV5cpwHKnbnhItQ+D/BTU2Uu40xyYxsRM9HYiWZ7cpDK
 CS+NBpJu7brraT0KyvAkg2LD7QUIPDhBkwMP3VH9c2pbF1n8kdDbCpG+lCOY7k0vs8p4
 lq2x7azYQ8cp7Ys/kiHkUx7VKuoP2zlbCxtA9fFgFSiRMaTlPROvtLd3NkVoNuDTPLv7
 Y0ow==
X-Gm-Message-State: AA+aEWZw380Tr42iVWvvVQnWEXRT+yo2cjkPWYiRPF1oThcQlzPwr5QL
 jb6INOINLSy4/gwoVg0clqsZ2jI3tYw=
X-Google-Smtp-Source: AFSGD/XyJI07Tog9g7u9a+VIHGivVSbpfe/AcDCtT8mLHAIxfqbu3FrsCGklWeDrj/zaA+Si6B5ZdA==
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr16146192otk.221.1544055137598; 
 Wed, 05 Dec 2018 16:12:17 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com.
 [209.85.167.178])
 by smtp.gmail.com with ESMTPSA id h24sm6763573otq.11.2018.12.05.16.12.16
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 16:12:16 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id j21so19204693oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 16:12:16 -0800 (PST)
X-Received: by 2002:aca:68c4:: with SMTP id o65mr15469103oik.175.1544055136768; 
 Wed, 05 Dec 2018 16:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
 <20181005085505.29024-3-pankaj.bansal@nxp.com>
In-Reply-To: <20181005085505.29024-3-pankaj.bansal@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 18:12:05 -0600
X-Gmail-Original-Message-ID: <CADRPPNSuG_O9u3Jc_9jGxetb5y_h3VmAFgvGpz7sDSKXkuN09A@mail.gmail.com>
Message-ID: <CADRPPNSuG_O9u3Jc_9jGxetb5y_h3VmAFgvGpz7sDSKXkuN09A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsl: add i2c controlled qixis driver
To: pankaj.bansal@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_161231_112749_4B731593 
X-CRM114-Status: GOOD (  22.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, alexandru.marginean@nxp.com,
 Dongsheng Wang <dongsheng.wang@freescale.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Oct 4, 2018 at 11:03 PM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
>
> FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
> driver which is basically an i2c client driver to control FPGA.

Is this driver just used to print out the QIXIS version and create
platform devices for all the subnodes?   If that's the case, a
"simple-bus" compatibility in the fpga node would be enough.

>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig        |  9 ++++
>  drivers/soc/fsl/Makefile       |  1 +
>  drivers/soc/fsl/qixis_ctrl.c   | 75 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/qixis_ctrl.h | 20 +++++++++
>  4 files changed, 105 insertions(+)
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 8f80e8bbf29e..c355c2cbbd45 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -28,4 +28,13 @@ config FSL_MC_DPIO
>           other DPAA2 objects. This driver does not expose the DPIO
>           objects individually, but groups them under a service layer
>           API.
> +
> +config FSL_QIXIS
> +       tristate "QIXIS system controller driver"
> +       select REGMAP_I2C
> +       default n
> +       help
> +         Say y here to enable QIXIS system controller api. The qixis driver
> +         provides FPGA functions to control system.
> +
>  endmenu
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 803ef1bfb5ff..47e0cfc66ca4 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -5,5 +5,6 @@
>  obj-$(CONFIG_FSL_DPAA)                 += qbman/
>  obj-$(CONFIG_QUICC_ENGINE)             += qe/
>  obj-$(CONFIG_CPM)                      += qe/
> +obj-$(CONFIG_FSL_QIXIS)                += qixis_ctrl.o
>  obj-$(CONFIG_FSL_GUTS)                 += guts.o
>  obj-$(CONFIG_FSL_MC_DPIO)              += dpio/
> diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
> new file mode 100644
> index 000000000000..b94649fb9726
> --- /dev/null
> +++ b/drivers/soc/fsl/qixis_ctrl.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/* Freescale QIXIS system controller driver.
> + *
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fsl/qixis_ctrl.h>
> +#include <linux/io.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static struct regmap *qixis_regmap;
> +
> +static struct regmap_config qixis_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +};
> +
> +static int fsl_qixis_i2c_probe(struct i2c_client *client)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *child;
> +       u32 qver;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +               return -EOPNOTSUPP;
> +
> +       qixis_regmap = regmap_init_i2c(client, &qixis_regmap_config);
> +
> +       /* create platform device for  each of the child node of FPGA node */
> +       for_each_child_of_node(client->dev.of_node, child) {
> +               pdev = of_platform_device_create(child, NULL, &client->dev);
> +       };
> +
> +       regmap_read(qixis_regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
> +                   &qver);
> +
> +       pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
> +
> +       return 0;
> +}
> +
> +static int fsl_qixis_i2c_remove(struct i2c_client *client)
> +{

Don't need to cleanup the regmap created?

> +       return 0;
> +}
> +
> +static const struct of_device_id fsl_qixis_of_match[] = {
> +       { .compatible = "fsl,fpga-qixis-i2c" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
> +
> +static struct i2c_driver fsl_qixis_i2c_driver = {
> +       .driver = {
> +               .name   = "qixis_ctrl",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(fsl_qixis_of_match),
> +       },
> +       .probe_new      = fsl_qixis_i2c_probe,
> +       .remove         = fsl_qixis_i2c_remove,
> +};
> +module_i2c_driver(fsl_qixis_i2c_driver);
> +
> +MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
> +MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fsl/qixis_ctrl.h b/include/linux/fsl/qixis_ctrl.h
> new file mode 100644
> index 000000000000..00e80ef21adc
> --- /dev/null
> +++ b/include/linux/fsl/qixis_ctrl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+
> + *
> + * Definitions for Freescale QIXIS system controller.
> + *
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP
> + */
> +
> +#ifndef _FSL_QIXIS_CTRL_H_
> +#define _FSL_QIXIS_CTRL_H_
> +
> +/* QIXIS MAP */
> +struct fsl_qixis_regs {
> +       u8              id;             /* Identification Registers */
> +       u8              version;        /* Version Register */
> +       u8              qixis_ver;      /* QIXIS Version Register */
> +       u8              reserved1[0x1f];
> +};
> +
> +#endif
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
