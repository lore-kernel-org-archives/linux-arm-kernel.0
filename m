Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:04:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1F420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jlrVarLv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRyPqZxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uh2MWazHMWh3L7HCnML6MkeNndkBKujjwgpxMrePje8=; b=jlrVarLvmAFAC+
	v2hBVizCc7kYutP6qqjIEQnI9Si8khwaV0X4tzRKyeSbYWJVVjVzxsteeAYYYkpm6QA2s956kpn6M
	nfeyaH/S7xhrMrDPGT8RJIIzJEEHZjiVzbRZyx81BMUShnUol8FXrqnc8UxsAsdzSjGGpGZdMs0LO
	+8kwZa6CYl9QNv9G2NME/E0dCTp81H3M1SPgyCk/L+5RcG6HMlwokGYdwKtQcz+J2omDlZNLpIali
	Ns5EjwPXkp9meqJLi/vacQbdAQ5qL5gLAwgtRQDrB5CKx8BeGyumreZZtEDQ0W+fPL9GsFeo12j7B
	n1rNKThwZ1j8Oq/MCrfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXZ5l-0005nT-2f; Thu, 13 Dec 2018 22:04:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXZ5h-0005ln-FH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 22:04:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A38E320811;
 Thu, 13 Dec 2018 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544738650;
 bh=oFbVQf52DmAIyJr+d31487v9PZakzmy0brakd4X3SRk=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=dRyPqZxyRpxuNzYDZakK0/cp3yuCvuPdKK91bOinJT3mJ8GV6eqyBzG2Y7ckignJB
 tAKHyRzVnA1GpaA4boOiluc9rjgDF81EJFhN/ZN6sC0dsqCrdClhCsyngdq1z02LZ1
 Z2y7O2/6gcpr/fkyMHrFS9QexgnVl8beKTEY84Tw=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Daniel Baluta <daniel.baluta@gmail.com>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
 <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154473864987.19322.9053094167554135382@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 14:04:09 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_140421_520943_BA7D5B7E 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-13 08:51:18)
> [...]
> 
> > > --- a/drivers/clk/imx/Makefile
> > > +++ b/drivers/clk/imx/Makefile
> > > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> > >  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> > >  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> > >  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> > > -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> > >  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> > > +
> > > +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> > 
> > Nit: Do we want to keep CONFIG_ sorted?
> 
> IMHO It might be okay to make MX8 (ARM64) a new group to start
> To get a clear separation. (Slightly not sorted due to VF610)
> Anyway, it leaves to Stephen to make the judge.
> 

This is fine to split the two if they're not related. Just have a
comment indicating this.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
