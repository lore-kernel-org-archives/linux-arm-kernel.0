Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F14C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:41:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4895820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b/xsqrkC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1u00QRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=srh9cKi1gk1nTxBNqr65haDwPnaQnn6O1+wVfHKT858=; b=b/xsqrkClqKVnd
	XlRalgu8xipZclJZn8/kTbBiEbMfqzWYhGULFXl6CBxLzjSIF57aHzrP817+HoqTqzlfdEKmndAAc
	2RvHnjcERw0GUX6QnZrT+zM9Bs1uLU3awVoB9bMpP8KNWSiY/lg2o0zMQ1RHyDdiM3Zw6ntQ6sUZk
	UIwQBejqWK01v23LNYVPhlxe0ExoYFiRBxdhoWyjUgyMjNrF1HoTWRcOePGXS/JhhA0yszWqBUF3W
	xrxW5NHOwKCOvDDxmyiiwNfDwlHArYQPJqNF1LYeKCzqczJGPsafa6GXeHjZZrHhVM/c4kr1pxI3k
	bdaDnDxZ2ZSg6JKJuXCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcTN-0002Hj-Nb; Fri, 14 Dec 2018 01:41:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcTL-0002HP-58
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:41:00 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2CB4120811;
 Fri, 14 Dec 2018 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544751647;
 bh=/gSiA2Gkx2E9oWtiyY/A0VSuOD1fUOWydXg0c+8sMEY=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=I1u00QRqpWv7e8qNNfyf20IF3Sxn2wfmaUTbSlbSn1ZLPKS63QGiSm+Ngkr5rLwsa
 TSj4pZzrZNw+i2hqYn6jBPXqSF9hl7RApevpgFGM8hAVF7sFKUvGkmKRreXrtUqAMH
 oSIOPOT070UNj0KexVu3hcS9jChZho9AiQBuTBEs=
MIME-Version: 1.0
In-Reply-To: <20181214010101.GA13243@dragon>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
To: Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
 <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214010101.GA13243@dragon>
Message-ID: <154475164638.19322.6542937629598212543@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 17:40:46 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_174059_276956_B7AC1874 
X-CRM114-Status: GOOD (  13.46  )
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

Quoting Shawn Guo (2018-12-13 17:01:02)
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
> 

Fine by me. Please resend this patch with the final decision.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
