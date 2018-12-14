Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C76C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A920B206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPPxgW8q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWR+VrTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A920B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wv/tA+BUXBQKKcm2hNMaLRLI7A72cQzSFnPFohMcVjM=; b=GPPxgW8qhGKtc8
	rXpHgJEG0V+mE+NEiPX8FNqICL1N5KX1tSypu3BbRPTdAgI3dap7bhyNS2zcDxG3WaN29ykqGucRi
	yHBGo7uOS7rxhnbtxXZ8WQAKPFVZHqrswC10la77TsAirjzD7+zsvsRYXQpeFQncEKnkmpJuCQ26s
	CC3lEJYwiiNa/iF5wVuzbcgAHDAb8+i56xHxoQyVa/HFF8qzFgVXLCurI020RP9smW9Pd8JMzUmUN
	SquoBoZABlF1VGMS4HW0IawgVjYjQnwXSJTCb1mILdpqZqCSQKR6n3+0vM+erN/RBzXpQgwEqIecZ
	XF7I+9N8jDOSC1taZKtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoCL-0004qq-Jx; Fri, 14 Dec 2018 14:12:13 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoCI-0004ps-OP
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:12:12 +0000
Received: by mail-ed1-x542.google.com with SMTP id o10so5026355edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lOHfZAhHLVpxi/tMQLzkDV/TIgSG0ZS7mbtAEjInM2A=;
 b=tWR+VrTqybd0uVGRyW5uPuxi/51ijeGmBVaN8Uq/9XdIydPiX8MYkJKaikuzX+Q+If
 VD7ve2GvuSGiuo80t/SvbOZ3C5HCOxcXIhMfIkG8Luq32ead3eYDfVcAELiT351DK80p
 MO32VvUH1UipcKwMFeVCLmyDsLeBr58EDus9LcnbyHGAY+iJQmuGpqFCM65y77abuSyx
 2Q1FG1n/YXZuiWFsrFDXoVCcEBhhVWUcQavqqPua6S7S5MwW5S36Br11VYV4CLTb+gNQ
 eM1osuJUdqzCKi8aPizB4ihPNMUHXahAgrSyjzXCt35B2N6XNVHavNDooGcXlxOt2HqO
 11Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lOHfZAhHLVpxi/tMQLzkDV/TIgSG0ZS7mbtAEjInM2A=;
 b=uGiWAsqTV+J6XRzG1SpNyhhQNgaDxspoasy/TSe08nqXwdMnpU/3wQ1o4iAD5I9MFC
 02QWCjFOA7mWjO1Tqv6qog8tPUFASkt1qWKgXadeVwBiXcP81RDqR+xnptc2dKg4F3r4
 Ef/W809HiUu1oR2ru6NNX5aRnJtKfJ3IxVfwi3tW9KmK28p9b5GQrBKAi7EwzF7a6aJC
 sXZpuunrXJgEgw09xrZ1RYdODzuBc2h30p2s7vBybvb3nklrYzxdbFZKpgUBtGM7cESJ
 VzSDhayiw4HOt+KyYqT9/I4goNy80h+VFR7zu5H6ZB9iQxsnOQ3r1woP/JN7bEG/5yxM
 pISA==
X-Gm-Message-State: AA+aEWarP06QSfCEyaOjX+2+2RXVNSN4Ibr8k/9pIWzo8NYlmC+c4KVW
 kqchc4GT9HX/ASGwMnIpa6d06LCEd/PjwOcaEdEgOw==
X-Google-Smtp-Source: AFSGD/XeDodsmoR5pS6Lgq1o5XT4tgeJBwzJcbyfjFmTcDcnx3zYZA19TxkEbnmtjSqc862ho+XTYebzeK1KH4SjPMs=
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr3139376eds.265.1544796717889; 
 Fri, 14 Dec 2018 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
 <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214010101.GA13243@dragon>
In-Reply-To: <20181214010101.GA13243@dragon>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 14 Dec 2018 16:11:45 +0200
Message-ID: <CAEnQRZB_fEeASWsBye0HSn=tUBe31DugO42f3Z1GNYR4PNHXWQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_061210_801129_77C4E74A 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 3:02 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 04:51:18PM +0000, Aisheng Dong wrote:
> > [...]
> >
> > > > --- a/drivers/clk/imx/Makefile
> > > > +++ b/drivers/clk/imx/Makefile
> > > > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> > > >  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> > > >  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> > > >  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> > > > -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> > > >  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> > > > +
> > > > +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> > >
> > > Nit: Do we want to keep CONFIG_ sorted?
> >
> > IMHO It might be okay to make MX8 (ARM64) a new group to start
> > To get a clear separation. (Slightly not sorted due to VF610)
> > Anyway, it leaves to Stephen to make the judge.
>
> I think Daniel is suggesting that we put CONFIG_CLK_IMX8MQ prior to
> CONFIG_SOC_IMX1, so that all CONFIG_CLK_xxx options go before
> CONFIG_SOC_xxx and the list is still naturally alphabetically sorted.

Yes, that's correct.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
