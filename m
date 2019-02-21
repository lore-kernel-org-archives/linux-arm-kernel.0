Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB5DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356702146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYEZvBGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356702146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lJqPCHhqedfq66+sXpFTMW7JPLiWpe/z2QYW1iydKZU=; b=gYEZvBGy3GMtqU
	Ebun1sr1JAT6J9MfUR4ZGD57RXxTS+y+BjCfVirYN9uWL8N06Qfe4X6H8L4GhRmgM6Y3Hw1js9LkI
	UxsL1gZCuiLqBweWao7xlzUl4nPrp2+f3gi3HwOXKtERzyoVlwg0GhhuHHdeCzBYqmoYj8TLunsk4
	qCf6EjqdeweBVnn+a+M6AdAYQABj0a77IjsLy8SsQrE0pJxZ+cbegFvs10WIlqecm+Ec+sJMq3cmb
	E+E98TxV6UBuIz9a6JKG4aPxUcXQzuyYJcPQ5ErVjmd9333CQQp/7wm8x5aCZCPfpxX8PVmoT85dd
	PWPNbYCYQhWJjKLlDV/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwd3Q-0000Dq-6s; Thu, 21 Feb 2019 01:21:36 +0000
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2
 (Red Hat Linux)) id 1gwd3M-0000DR-KT; Thu, 21 Feb 2019 01:21:32 +0000
Date: Wed, 20 Feb 2019 17:21:30 -0800
From: Darren Hart <dvhart@infradead.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20190221012130.GB5838@wrath>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-2-lkundrak@v3.sk>
 <20190111143635.GA21484@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111143635.GA21484@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, linux-arm-kernel@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 08:36:35AM -0600, Rob Herring wrote:
> On Thu, 10 Jan 2019 18:58:36 +0100, Lubomir Rintel wrote:
> > The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> > signals for handshaking. It needs to know when is the slave (Linux)
> > side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> > controller node) and when does it wish to respond with a command (the
> > cmd-gpio property).
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/cmd-gpio/cmd-gpios/
> > - s/ready-gpio/ready-gpios/ in the documentation paragraph
> > - Remove status = "okay" from the example
> > 
> >  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Rob, I saw you ack this patch in an earlier version. Based on your comment here,
is that ack still valid?

-- 
Darren Hart
VMware Open Source Technology Center

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
