Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C9CC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:29:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A68020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FbuxXcFC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHC4Ckq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A68020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Wgh+9GKF5HaFWQ10SN5cQGDMPRsDz0ZqvBhh+qaKQM=; b=FbuxXcFCS0OCdg
	MTgLXgJz9rkACVAeF3vOiqUPRLPPmcqQUd/uMLCp+9L8tyHyNdbadzelVfwQ+9SYsU3V4vyNfRI0s
	EIFvgZGd+BZ/1UG7zOzX1v4h3fc/jS/+x8wi0xW8uv4jXReK3TmE3hun10aG/cG0bVoQ0mrSiQRe1
	hH1w7eogFs3SLPPBErQ49dhmCG9h3XTvuZmUKfT22J7XLtIXbYnrAf5ZSoHIO9K0ZJl+yyH7R7F90
	rWXWTo/gVXBL1H+dTJzgHe4DLqJA/XcuRD3kX0KohDQSkwqiKuv0Abpm+orA2jvplbEeHQzKujBqF
	pnvD+aVcEvA8EvscilSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnj0-0006mI-PH; Tue, 11 Dec 2018 19:29:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWniw-0006lT-Da
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 19:29:43 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A595520811;
 Tue, 11 Dec 2018 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544556571;
 bh=iAKGauz5venGJniqKpfQh1ww9S96BOAIqJNhWGEqkM4=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=UHC4Ckq0ul06nJ20RJo0GI5OkfK+3TmEoAyE4pun7Mt6RJmt8zbPMFefQ2jjwY48Z
 5uc81231NOn17o0yrHfOBD1xNo56NEG+s378anfWQ0cH9GEjN8gpXxtSQq8KVsXayM
 fu2vngJQiUttgQlm1dkC7OZP+P29KSN6OZ7CmPjk=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
Date: Tue, 11 Dec 2018 11:29:30 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_112942_491937_DB1E3DCC 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-10 18:36:29)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Tuesday, December 11, 2018 4:55 AM
> [...]
> > Subject: Re: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
> > 
> > Quoting Aisheng DONG (2018-12-04 06:39:22)
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index c12a05c..303082c 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -570,6 +580,7 @@ config SOC_IMX7ULP  config SOC_VF610
> > >         bool "Vybrid Family VF610 support"
> > >         select ARM_GIC if ARCH_MULTI_V7
> > > +       select MXC_CLK
> > >         select PINCTRL_VF610
> > >
> > 
> > Instead of select can we break this dependency on the arch Kconfig and
> > have:
> > 
> >       config MXC_CLK
> >               def_bool ARCH_MXC && !ARM64
> > 
> 
> Thanks for the suggestion.
> One little problem is that we also have LS1021 supported under ARCH_MXC which
> does not use MXC_CLK.

Ok. So then your change is also limiting the compilation of
drivers/clk/imx/ to only the platforms that select it now, instead of
all ARCH_MXC like it was done before.

We can also have def_bool <big list of SoC platforms> if that helps for
the optimization that this patch is making.

arm-soc has generally pushed against having so many different arch level
Kconfig options because they make for unwieldy Kconfig fragments that
may become conflicting. Instead, the options for the different SoCs are
removed and we just have one for the platform and rely on defconfigs to
pick the right drivers. 

Why can't we do that here?

>  
> > > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > > 5c0b11e..f850424 100644
> > > --- a/drivers/clk/imx/Makefile
> > > +++ b/drivers/clk/imx/Makefile
> > > @@ -1,6 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > > -obj-y += \
> > > +obj-$(CONFIG_MXC_CLK) += \
> > 
> > Because this changes to obj-$(CONFIG) we should change the
> > drivers/clk/Makefile to have obj-y for this Makefile instead of depending on
> > ARCH_MXC.
> 
> We also use ARCH_MXC for ARMv8 SoC clocks.

Yes, and? I'm suggesting drivers/clk/Makefile have an obj-y +=
drivers/clk/imx/ and then decide to compile or not compile the MXC_CLK
"core" bits based on CONFIG_MXC_CLK config option.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
