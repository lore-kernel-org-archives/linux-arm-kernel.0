Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D9DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61F420873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kGXy0QPG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flecOUwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtyzsVgL2AO676VV0IROe2AQITzeshxGcxvEAm3KTgc=; b=kGXy0QPGyLofSA
	Jl9IhRjdhSjOwmYuva5r/9BewDl4G9AwtG62wAZE075297wHvyACgbEO9NeEkDaAKipx+VWggnTYB
	bvi/nKDafULYXqEqECrzGg8RJYtZk+afuHRG1VhmymhwSk48fRzx7U4T4/poR2rW+uKXPvCXNG/mT
	uZZJzE/fOuOP54JaYFtJDrgQcEaHEPCNDKwIujVrZPRJvUOwYkEaIugVK8b7M9V4GwpWW+kEHk03q
	5zIAGkDKkacP724Yu0Svk383c48VeOqxh9M7J4iw3BN541Wm1AYfcmggS+XRhZGPiwvhBfq4pRyip
	p7GTE21wIqwotN+vDPVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLsR-0002zb-4w; Thu, 13 Dec 2018 07:57:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLsN-0002yI-Pt
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:57:45 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 696692075B;
 Thu, 13 Dec 2018 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544687853;
 bh=ICWhwbMaKImiZV7MhribkZULvCL0qp5icy1lAFsJhW4=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=flecOUwbsY7cRG4F4nz8vHBQV5MuKtlkh/TijB7kadWBlvo9hqJVWEcG/x3fy1HK/
 lxjSVebNwEgL25uhoyNITo5D4H2HhWXkNXkJ6HE2uOQHTEsXB0ltYp71Q3227oSN4G
 oRxZ+ptqi4FMPhXe9tzN4BKIku/4yA2VcWX6Vhc4=
MIME-Version: 1.0
In-Reply-To: <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Wed, 12 Dec 2018 23:57:32 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_235743_873685_17FB554D 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Olof Johansson <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-12 17:07:52)
> The patch introduces CONFIG_MXC_CLK option for legacy MMIO clocks,
> this is required to compile legacy MMIO clock conditionally when adding
> SCU based clocks for MX8 platforms later.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index a47430b..8a9440a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            += davinci/
>  obj-$(CONFIG_H8300)                    += h8300/
>  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
>  obj-y                                  += imgtec/
> -obj-$(CONFIG_ARCH_MXC)                 += imx/
> +obj-y                                  += imx/
>  obj-y                                  += ingenic/
>  obj-$(CONFIG_ARCH_K3)                  += keystone/
>  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> new file mode 100644
> index 0000000..37478ba
> --- /dev/null
> +++ b/drivers/clk/imx/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for NXP i.MX SoC family.
> +config MXC_CLK
> +       bool
> +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)

Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
been in linux-next for a few days. Having such a config symbol is highly
unusual for arm64 code. Has that been accepted by arm-soc? I don't know
why it would be because we don't add SoC specific config options
anymore. I imagine it will be rejected and we'll need to have this new
MXC_CLK config be enabled in the defconfig instead of selected from the
arch layer.

Given all that, is there any damage if this is just a def_bool ARCH_MXC
right now? If it's enabled on the platforms that don't use it because
they have SCU, does it actually matter? Or we just get some code bloat?
If it's just some extra code, then even more reason to make a user
visible config option that can be selected in the configurations that
care to save some space.

> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 5c0b11e..f850424 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-y += \
> +obj-$(CONFIG_MXC_CLK) += \
>         clk.o \
>         clk-busy.o \
>         clk-composite-8m.o \

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
