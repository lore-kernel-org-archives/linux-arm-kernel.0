Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E2C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10FB2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJfP/fMN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSXX1g+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10FB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nqLwWII8BBEZ71ZivE4rMj3f2NQ2AkA/cB10Tv4CIxk=; b=cJfP/fMNyyjsE2
	NZi8OWdmFAG8FKZkoc/cCqF/kLjWI7kwhCHAA3zSwdHBkX49k7njlvqPV2Ja4sHzvdbIeBh1sqdf6
	CAeLCG907DQnXq57GoJW2zT1N6GB2Ql9kNT7UtrlaataxNJND3xXNUtzeCDBhXHUmMeUE+Xvq6geb
	6evtkP8DsRK32SVSxxawsB1TTAMXXi2n6SRt5qP/3KU/AXA3y2gbNYWrC4kYdKWve+qe+4AbcNBpz
	AYVY6MJHoxkYyIA/QeIkPnCul50YQGIRcjcwdx7RNjVvRBCWAn5iWaIDzr8p8PLY1OmIvGrCb2/Z7
	XVSDEMiA9IfwCJCJya/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXu6t-000748-R5; Fri, 14 Dec 2018 20:30:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXu6q-000730-39
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 20:30:57 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6ECA62080F;
 Fri, 14 Dec 2018 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544819445;
 bh=T/Kz7SQK7e/vpcoFtwwgemH7d/aZrtFdxpZmdl05Q7w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jSXX1g+YKKt0l2EjofPGUwxuMIjAWquw8WWBrqI5MVxBKOT6HP1OB8FMCFiXp0CRA
 vsEuvbXTARog6vLvgbCY4AKoQd6Dl5PhAv6+BG2tzZ7+6bx8s1ZsPp7o1ncbe0eTAR
 oTEWqzn7vQhXD1HrZTG4Oa8Ra3NJaKvqkUMvUvjY=
Date: Fri, 14 Dec 2018 14:30:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
Message-ID: <20181214203042.GC20725@google.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206073545.10967-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_123056_156224_64C7D3CC 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+cc Gustavo for fallthrough annotation]

On Wed, Dec 05, 2018 at 11:35:45PM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.

> @@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 tmp;
>  
> -	if (imx6_pcie->variant == IMX7D)
> +	if (imx6_pcie->variant == IMX7D ||
> +	    imx6_pcie->variant == IMX8MQ)

This style looks like a maintenance problem: the code below is probably
IMX6-specific, and you should test for *that* instead of adding to this
list of things that are *not* IMX6, because that list is likely to
continue growing.  There are more occurrences below.

> @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->variant) {
>  	case IMX7D:
> +	case IMX8MQ: /* FALLTHROUGH */
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;

I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
this looks wrong.  It's the IMX7D case that falls through, not the
IMX8MQ case.

The recent annotations added by Gustavo are at the point where the
"break" would normally be, e.g.,

  case IMX7D:
    /* fall through */                    <--- annotation
  case IMX8MQ:
    <code>
    break;

But in this case there's actually no IMX7D-specific *code* there, so I
suspect the annotation is unnecessary.  It's obvious that IMX7D and
IMX8MQ are handled the same, so there's really no opportunity for the
"forgotten break" mistake -Wimplicit-fallthrough is trying to find.

If we *do* want this annotation, we should spell it the same as
Gustavo has been, i.e., "fall through".

Again, more occurrences below.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
