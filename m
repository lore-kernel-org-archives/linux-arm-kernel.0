Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:56:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC02081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K/ZCjDCF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQEe6xsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC02081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DWdA7xhguFsqYV8czEmD0UjjtlpK4oNeExL0heOmqQ4=; b=K/ZCjDCF5mSJjU
	yBITpogqjPatdoEaNnnLhUUwZKRwuRbdMAesk+l4Y6c2372rdo7fAXfFmhS+2govZOooKrt4vOSpc
	Nywtl31TOIZsHh7kX/fjknh/Ix+DmPvw6bm5J7hpvuloGtf5IIg3Mu/JROJXe37runXKQQuuD7V0F
	9Bez/7oytLsPb2iZlr11SOmtWzgiZGFUKt1WP4pq20eDzOyysJ3NP60vvCTUAgrzpf04niUzdnkDO
	X+eBwFWp+FUBTT0loGDxBfNlmIL/Lb6iBrGaxPWNPQOI9+lxilzhr5nxtvJ6CJL5M0GI+lRUDbVrK
	myDzP8p8ekC7SKO+V+ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTXM-0006aE-VX; Mon, 10 Dec 2018 21:56:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTXJ-0006Zk-38
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:56:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A2492081F;
 Mon, 10 Dec 2018 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544478969;
 bh=RVvvfaRq2VkibiJbgy7GLb0+rHp/tsrl/UYuhPu1mOo=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=zQEe6xsUrRd1JK/xFdD+CpqxTTbUmJiDjscbrS9GXhx8xcdc7D4CneHAyWq/H6TnX
 A8frpr8GiNC1D7f8g0ry0Rupw8TyIZf4NBueGQkZcFucU1NzX9RYQVoTw5SzCTOliB
 4Bol5pxEcpDBQ/c4xPEdCblNywu/YvrZ+uVUuNdY=
MIME-Version: 1.0
In-Reply-To: <1543934041-12572-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154447896872.17204.13777399275077720705@swboyd.mtv.corp.google.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
Subject: Re: [PATCH V9 2/7] clk: imx: add scu clock common part
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-3-git-send-email-aisheng.dong@nxp.com>
Date: Mon, 10 Dec 2018 13:56:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_135621_154145_AF1AEE68 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-12-04 06:39:25)
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 43a3ecc..63e7b01 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -3,3 +3,7 @@
>  config MXC_CLK
>         bool
>         depends on ARCH_MXC
> +
> +config MXC_CLK_SCU

Is there any reason to make this a hidden option instead of making it a
selectable option? It can still depend on ARCH_MXC and ARM64, but
otherwise it should be compilable as long as CONFIG_IMX_SCU is defined
(this should also be a config we depend on here).

> +       bool
> +       depends on ARCH_MXC && ARM64
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index f850424..4abed37 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -20,6 +20,9 @@ obj-$(CONFIG_MXC_CLK) += \
>         clk-pllv4.o \
>         clk-sccg-pll.o
>  
> +obj-$(CONFIG_MXC_CLK_SCU) += \
> +       clk-scu.o
> +
>  obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
>  obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> new file mode 100644
> index 0000000..ec8a471
> --- /dev/null
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP
> + *   Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include "clk-scu.h"
> +
> +struct imx_sc_ipc *ccm_ipc_handle;

Why does this need to be a global? Can it be in each clk_scu instance
instead?

> +
> diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
> new file mode 100644
> index 0000000..09f381b
> --- /dev/null
> +++ b/drivers/clk/imx/clk-scu.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2018 NXP
> + *   Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#ifndef __IMX_CLK_SCU_H
> +#define __IMX_CLK_SCU_H
> +
> +#include <linux/firmware/imx/sci.h>
> +
> +extern struct imx_sc_ipc *ccm_ipc_handle;
> +
> +static inline int imx_clk_scu_init(void)
> +{
> +       return imx_scu_get_handle(&ccm_ipc_handle);

And then this can be implemented in the C driver so that ccm_ipc_handle
doesn't need to be exported into the header file?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
