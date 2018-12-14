Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A7C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9288720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFuB/oBt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCjYtzRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9288720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xjF/yjXviWHa3iyzyX6xcN3freUFB18iIH7rIFnNvNE=; b=rFuB/oBtfV25/L
	oGAOhnpmZIn6AcyzZkrWCrisWXRhsDKaiLuTvxt77bxda/uLplouGfKFgvJzjGC4YlqLsTM/9NMFe
	upvJ09tPXcollc5fi2JDYZQjPZkQv/3KHHcyw1dPKV04WWO3/A3mGeoVoEBrN/YmKl2FN+5hXxs8q
	wDRFdQsA47qrhKFapNx10dw9Ubjc57Q91ZHhKz/U9tdqBa9iOqmYQtiFKFwl388smSWTV8ySuyocM
	Srry+Ql4WFmG2KG3OgQGsfPcy417R7rdKInmZPIFl+nqeBZctxGp1BeHc6n+iQcrFIg2C/vCYvNCW
	wGeagMCs4kRWwLOEiZfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcL7-00075j-6G; Fri, 14 Dec 2018 01:32:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcL4-00074v-9g
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:32:27 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E409C2075B;
 Fri, 14 Dec 2018 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544751136;
 bh=5llEuIAoScurxG1Q85zNA8LC0l++qF8B7+Mb4v/syDk=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=OCjYtzRXiRdE6b5RIzpkYzUiItrlgHFmJ2G0G1fvZd9h9dzhXxAfekvCTKoV5kVRT
 YUONMHkEliVmXq57hc42+oLGz2OlbNwBG5DQZltJE9IzM712oMLyHvhS1HUGGt98Bh
 rplRjbM9dsvxOoGV5rFg1IIBZvp8zk/sT94MJr/I=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211128F59A987F3D94AAD8F80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211128F59A987F3D94AAD8F80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154475113520.19322.14425233247345284599@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 17:32:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_173226_408493_338A83DC 
X-CRM114-Status: GOOD (  25.61  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
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

Quoting Aisheng Dong (2018-12-13 04:49:07)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Thursday, December 13, 2018 3:58 PM
> > To: linux-clk@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> > shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng Dong
> > <aisheng.dong@nxp.com>; Arnd Bergmann <arnd@arndb.de>; Olof Johansson
> > <olof@lixom.net>
> > Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
> > 
> > Quoting Aisheng Dong (2018-12-12 17:07:52)
> > > The patch introduces CONFIG_MXC_CLK option for legacy MMIO clocks,
> > > this is required to compile legacy MMIO clock conditionally when
> > > adding SCU based clocks for MX8 platforms later.
> > >
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com> diff --git
> > > a/drivers/clk/Makefile b/drivers/clk/Makefile index a47430b..8a9440a
> > > 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            +=
> > davinci/
> > >  obj-$(CONFIG_H8300)                    += h8300/
> > >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> > >  obj-y                                  += imgtec/
> > > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > > +obj-y                                  += imx/
> > >  obj-y                                  += ingenic/
> > >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> > >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig new
> > > file mode 100644 index 0000000..37478ba
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/Kconfig
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# common clock support for NXP i.MX SoC family.
> > > +config MXC_CLK
> > > +       bool
> > > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 &&
> > > +SOC_IMX8MQ)
> > 
> > Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> > been in linux-next for a few days. Having such a config symbol is highly unusual
> > for arm64 code. Has that been accepted by arm-soc? I don't know why it
> > would be because we don't add SoC specific config options anymore. I imagine
> > it will be rejected and we'll need to have this new MXC_CLK config be enabled
> > in the defconfig instead of selected from the arch layer.
> > 
> > Given all that, is there any damage if this is just a def_bool ARCH_MXC right
> > now? If it's enabled on the platforms that don't use it because they have SCU,
> > does it actually matter? Or we just get some code bloat?
> > If it's just some extra code, then even more reason to make a user visible config
> > option that can be selected in the configurations that care to save some space.
> > 
> 
> It make sense to me. No actual damage as we support multiplatforms using both
> MXC_CLK and MXC_CLK_SCU on ARMv8. And for users who want to save one of them,
> they do can change via memuconfig later.
> I will make it a def_bool ARCH_MXC.
> Thanks for the suggestion.
> 
> BTW, as I also introduced SOC_IMX8QXP in Patch 4 and 7.
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> +obj-$(CONFIG_SOC_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o 
> 
> According to your former suggestion, I think we should remove it.
> So I'm going to make imx8qxp clk an user selectable configuration option which
> will select the common MXC_CLK_SCU. So a bit difference from former discussion,
> MXC_CLK_SCU will still be kept a hide option.
> 
> This way is mostly like how QCOM does and should work for IMX as well.
> 
> Then it will look like:
> config MXC_CLK_SCU
>         bool 
> 
> config CLK_IMX8QXP
>         bool "IMX8QXP SCU Clock"
>         depends on ARCH_MXC && IMX_SCU && ARM64
>         select MXC_CLK_SCU
>         help
>           Build the driver for IMX8QXP SCU based clocks.
> 
> If any issue, please let me know.

Ok, so a library pattern, where MXC_CLK_SCU is the library of code that
various SoC specific clk drivers use. Seems fine to me.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
