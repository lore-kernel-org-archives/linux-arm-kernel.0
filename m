Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605FEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:02:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB8120892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bEjrEN1V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsHNEtN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB8120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dIxXR5Xt4BDO994KmULY6zBamWt46JD0OFXUvkXd3DM=; b=bEjrEN1VYkhooI
	G3lNI+dYqh5XZWT2sW6cylWnq9dYjgIA7F4Mz/SS9ojgwAO9VQL0jmy+PQVtQGrOs1IxR4m2FnUel
	mqXvDmYAUuUV2+mppMuCLglya7Sla7dQMYEJiej2ddDH8x6D1yMMZ22P2fjTH1CEloRYAaGcHhhtO
	m/YzLciXmbsAWcliVA8gp06Pfjlm3YDleqqQMBtRYX8QKA1/BhBXRn5vGaqtj83IVIHQOfhJnEarE
	VCQL/0upNnyGpinO0VAhzmdqDdnW/n5+q8R+PwZfAesUpjQ2WJquqXafN+KROduqeYGSeVP7ggaWi
	9mcUd29nh4UiJvuLj+Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXbrt-0004V0-2e; Fri, 14 Dec 2018 01:02:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXbrp-0004UG-PJ
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:02:15 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 802842080F;
 Fri, 14 Dec 2018 01:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544749323;
 bh=HJ0ED45XoTcHsaXKzDy/1nHCihraOcFc6jN+JVeybfc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nsHNEtN4p/h1tSq93wsvH9bKEVANwwB38JlXRp6xGYnk5IvQ1vqgb8auRq0PdEGar
 Bz6d6gfK2u0E8AMdCLjRICAon8lBSdGj/i/xkmJy1/CECOyXEMkjZXgbkwcn/mtpp/
 dLAlVYW/FtXUQEyoyY4b6WVdy7MXQI7Cl/qo88vA=
Date: Fri, 14 Dec 2018 09:01:02 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Message-ID: <20181214010101.GA13243@dragon>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
 <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_170213_878262_0184D53A 
X-CRM114-Status: GOOD (  11.43  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
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

On Thu, Dec 13, 2018 at 04:51:18PM +0000, Aisheng Dong wrote:
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

I think Daniel is suggesting that we put CONFIG_CLK_IMX8MQ prior to
CONFIG_SOC_IMX1, so that all CONFIG_CLK_xxx options go before
CONFIG_SOC_xxx and the list is still naturally alphabetically sorted.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
