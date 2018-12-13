Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:13:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396A320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L12wsl+h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sscv4wFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396A320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MDgAiHVcCmSjgIPPJTZggc0wZocH5dVfu0osKecw7G4=; b=L12wsl+h0OZY5O
	eMZYxAgDWM2U1+Sr553DCbi7hByegsg1ekQJbjJPyekrwWBWErgH1TtCAwxp3i8yuda2IJCkNm1G2
	rrCZhLG6aMoFhGcROEDqE/dM519rGj7DnOMO29gOfml6NBIfWT/7Dzu9uT50ij1PmwDvswTtNYTNi
	644I2ExCURT7zlbSE5pSUs5XqFj6Mn/evf/JCYDcQ3GDjjLM6LCES4s0WXJKbaf5IFxHtaT9gVr21
	6VOpY5eUkh9Fk8njPrUx5o0hO7YcM0ZTFwpyHE3pkI4xH8uJIWCDzqqG3/Ip8QFwHQih4uOEdTivN
	O9W/UvhrGr6JRDPsSouw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXM85-0001N2-Gw; Thu, 13 Dec 2018 08:13:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXM82-0001Kj-DF
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:13:55 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83D9E20672;
 Thu, 13 Dec 2018 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544688823;
 bh=hdSxwL6L48BawQk84aJlwPIeau5JWl7HwWdpz6eEVcY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sscv4wFdgL2IdKX8eV/BP7/OwMEOne7iu887Yt2xkGBYEr+4Hn9+ZfZ06aCAQF0KP
 N+JJHp5XctJ3Y6rfVX4w4u8gUTo8hs+MNsqbUlPD8oLItZdRj5or/9zmRwASP/S83i
 CYxm1QVRCWQGDbNGF7v/RfYGf1Mv8IjlZuAkrGJw=
Date: Thu, 13 Dec 2018 16:12:41 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Message-ID: <20181213081239.GB12458@dragon>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
 <CAOesGMhFtawJLpHmXbxvs=z+S1jVW8n2VQVv1gMcWicrOxDWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOesGMhFtawJLpHmXbxvs=z+S1jVW8n2VQVv1gMcWicrOxDWdA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_001354_481351_08B56EDB 
X-CRM114-Status: GOOD (  20.19  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 04:02:34PM +0800, Olof Johansson wrote:
...
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index a47430b..8a9440a 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            += davinci/
> > >  obj-$(CONFIG_H8300)                    += h8300/
> > >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> > >  obj-y                                  += imgtec/
> > > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > > +obj-y                                  += imx/
> > >  obj-y                                  += ingenic/
> > >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> > >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > new file mode 100644
> > > index 0000000..37478ba
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/Kconfig
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# common clock support for NXP i.MX SoC family.
> > > +config MXC_CLK
> > > +       bool
> > > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
> >
> > Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> > been in linux-next for a few days. Having such a config symbol is highly
> > unusual for arm64 code. Has that been accepted by arm-soc? I don't know
> > why it would be because we don't add SoC specific config options
> > anymore. I imagine it will be rejected and we'll need to have this new
> > MXC_CLK config be enabled in the defconfig instead of selected from the
> > arch layer.
> >
> > Given all that, is there any damage if this is just a def_bool ARCH_MXC
> > right now? If it's enabled on the platforms that don't use it because
> > they have SCU, does it actually matter? Or we just get some code bloat?
> > If it's just some extra code, then even more reason to make a user
> > visible config option that can be selected in the configurations that
> > care to save some space.
> 
> On arm64 we generally add an ARCH_<family> and leave it at that. So,
> ARCH_MXC would be suitable, but we shouldn't add more finegrained than
> that.

Olof,

I'm just about to send pull request for i.MX8MQ support, which
introduced SOC_IMX8MQ option.  It sounds like we should rework the
patches to get SOC_IMX8MQ killed?

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
