Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB40C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7EE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aO9vKvN1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JeQN7cki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7EE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIZAaTrV7dXKntfEiGMQPSpIKJqdV1daQ1mCSsvLeTA=; b=aO9vKvN1PYziiP
	eV/38sc4O4DtPz2GjF/qCMxyS1HMkJ7EWFJb/zUattDWAuzw6f0+cdeEnYOCibmvGsM9wkXt5hNu3
	MhHMQB6XQwdOQ16bCjyf8vBWMw6DqdZiWW2Haf6bPeOrPNV2vzWKJGy4jPKtR1qALrOOAeJ1X6XAT
	7eQLACNbn8tI6J13gc8OL0f65GDOiPqETMb8gyxL9+b44p5LIc1sCmo2Ix1r2R1V0NrGhUimbM8TJ
	ETuRlDo5sQvy1ctT4ZxpWjj0atrjiv4ZAL5R2xj/xH2xtW++JsayOgtlUJOJDQgF2ETb0Rh/ni67d
	ug9+YAGNI9YbDdcS0n2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLxW-0005n1-1t; Thu, 13 Dec 2018 08:03:02 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLxR-0005jS-Mc
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:03:00 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so2404357ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EoIiB7t0sg6iJAPwEj4Js/iaR5JgIvLxPtOu5qkufY=;
 b=JeQN7ckiOiW4f9lpfNizP6DwENk0Q3Y/8/aDk9rAbZrRjDVcS6n23BqOaMl7NdePkW
 2kCQBUQ6nTot06irm9XwPFpVhBuSbNFK9d2/mG4JH7jQVSKVgekhuuWQCe4KdJsccfTv
 NywH2BngJHVIPC4T+6QknFvvcNaayloiAuMZHPnaydT+qK3Il18L7nM0+BRncfRW42jn
 T7qj7rZ10v6Ohvpi4tuPDNfZwRNeaI3nJnmu/S7otgQEPm09We9vxkWcWeEiyByonKkJ
 G1RW2CE9q/GAz1n0EU/Ucfv7U3AGXI0BnwkHx7nR2tktKpkxTe0NO7Vjfajlj8OWyjOe
 e2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EoIiB7t0sg6iJAPwEj4Js/iaR5JgIvLxPtOu5qkufY=;
 b=gYnf9QHw/5fJxKNweUEuuIns7mJGXBKKW8vNRsj1KwpC6EXUM5lWbWTJPRIa9mBIt3
 U3In1sB9/Y3Lxye0PaOkC+Uk0lGOO5lRw5oEoALTONZTun/JutgdVoxu1wf8RQ8oKZhI
 h5VDlkW6YuFzLXceFPIBZww3vuUoryq8hLMC69U9i0FmGvCcZHMaSbCXdCSXkamQzRzT
 rfUHuByIGpBaHVzfLh64rvN3gsXymDb90qk9hE9ltr4RSI2vISHFyWRWDtHXUsTtmDZ6
 She7L97oqQmuk5THQnwYBW1ksmuUyvNUzALAtC2YcmQcWQX9nTrmcwxL0FzPWeawFEc7
 Uo2A==
X-Gm-Message-State: AA+aEWZsvIV1TUidijXdwj/N4KafvQP8D5bj5ELqxWRvElBFuvGiJwWa
 W7pgz4QOxesMeYrrIlxb8+dlKR2HpHxE2jsfTnPE5A==
X-Google-Smtp-Source: AFSGD/U9Rk0VY/1NraQ3wTCjiG3nPTHd1U+iFwaUqElceNiFnhhO6sPh0tGSkSJRQnXr3MeWhjQbsrbxSZrZsK85C/M=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr22592849jak.10.1544688166628; 
 Thu, 13 Dec 2018 00:02:46 -0800 (PST)
MIME-Version: 1.0
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
In-Reply-To: <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
From: Olof Johansson <olof@lixom.net>
Date: Thu, 13 Dec 2018 16:02:34 +0800
Message-ID: <CAOesGMhFtawJLpHmXbxvs=z+S1jVW8n2VQVv1gMcWicrOxDWdA@mail.gmail.com>
Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_000257_877384_4464F9F8 
X-CRM114-Status: GOOD (  19.56  )
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
 Michael Turquette <mturquette@baylibre.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 3:57 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Aisheng Dong (2018-12-12 17:07:52)
> > The patch introduces CONFIG_MXC_CLK option for legacy MMIO clocks,
> > this is required to compile legacy MMIO clock conditionally when adding
> > SCU based clocks for MX8 platforms later.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index a47430b..8a9440a 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            += davinci/
> >  obj-$(CONFIG_H8300)                    += h8300/
> >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> >  obj-y                                  += imgtec/
> > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > +obj-y                                  += imx/
> >  obj-y                                  += ingenic/
> >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > new file mode 100644
> > index 0000000..37478ba
> > --- /dev/null
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# common clock support for NXP i.MX SoC family.
> > +config MXC_CLK
> > +       bool
> > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
>
> Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> been in linux-next for a few days. Having such a config symbol is highly
> unusual for arm64 code. Has that been accepted by arm-soc? I don't know
> why it would be because we don't add SoC specific config options
> anymore. I imagine it will be rejected and we'll need to have this new
> MXC_CLK config be enabled in the defconfig instead of selected from the
> arch layer.
>
> Given all that, is there any damage if this is just a def_bool ARCH_MXC
> right now? If it's enabled on the platforms that don't use it because
> they have SCU, does it actually matter? Or we just get some code bloat?
> If it's just some extra code, then even more reason to make a user
> visible config option that can be selected in the configurations that
> care to save some space.

On arm64 we generally add an ARCH_<family> and leave it at that. So,
ARCH_MXC would be suitable, but we shouldn't add more finegrained than
that.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
