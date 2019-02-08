Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C33C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2537E20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fJq14iCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2537E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k9WKWIioTQkOQrp3tQFJDSGtmM36/3t25rj63rYuiH0=; b=fJq14iCPYyvgjy
	WWanzl0ZLoG58qKfO3B9N/HmRA7yiDW+XpWtWrIthyP0ZQkHX2ZzYjTk2poIy8OvNyghG7F+Emhb5
	oGAIRMgt0nx7O+F4QVegS6rimLuz6/cFIW63wCvYMIHhMaE/B+xc0k69Vug6CUzDGWvHi7SUtv6Sr
	v2z/Cfo+kH8zAWmsPJvtoJVEX6kwkr/gupvj1tKn2adYo/F1N9yJAdTGVJsyFw8kWRpWVVwBmNYs1
	ApjdEiIrbRDdVf71q0fD4UqPq5qCQ2gWM7pVYWNYKVIEp0ucRAJ2VCJY1p3XEv9vZajr7PudA/KKj
	4EBs5TWUL/HCwwb0yJeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsFSC-0008GS-Eu; Fri, 08 Feb 2019 23:21:04 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsFRr-0007xz-31
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 23:20:45 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 3DC9E149C25B4;
 Fri,  8 Feb 2019 15:20:42 -0800 (PST)
Date: Fri, 08 Feb 2019 15:20:41 -0800 (PST)
Message-Id: <20190208.152041.1940768604724106089.davem@davemloft.net>
To: nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 3/3] net: macb: add sam9x60-macb compatibility string
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190206175610.26773-3-nicolas.ferre@microchip.com>
References: <20190206175610.26773-1-nicolas.ferre@microchip.com>
 <20190206175610.26773-3-nicolas.ferre@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 08 Feb 2019 15:20:42 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_152043_690374_341D9808 
X-CRM114-Status: UNSURE (   5.87  )
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
Cc: devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ludovic.desroches@microchip.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Wed, 6 Feb 2019 18:56:10 +0100

> Add a new compatibility string for this product. It's using
> at91sam9260-macb layout but has a newer hardware revision: it's safer
> to use its own string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to net-next.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
