Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC180C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78998218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XKqbAiht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78998218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tuhvyjx92oV+UkxtioJBYVBymz/pRGLoGg4OsvPsgSA=; b=XKqbAihtxqJqRH
	FUikQhrCnmPV2RnNGVLHM29MLqmYOKdmq59Sqy52GAkvouK9cjEm6XZxIFoBr2Gl4s1tEK3vJncJb
	0x5ttW4YJbLtN6oSFHOZ6cEAHCrcgTRGT0c8W3TJUjEV/cW8GhLtTTIin/0S55WWCKOrPm+mSSgY1
	TEiyOKxPytZ1zBp3zEOyveruYwf2ViTD3XXRSeviyZA0BFi8SgwWoTsnWvxWX+LlWWPrlYGkJVdPP
	6C9HX3nHr3XQdWuyzL99YEuq8GTqcNobfk32kZbY1kyFFhS0tIc5qAeZuCiy14h+eQbkeI+VP0ZIs
	Y66HILo1jEIhgxg9ouRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grTLq-00035m-3q; Wed, 06 Feb 2019 19:59:18 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grTLm-00033n-RW
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:59:16 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id C08661400C9AD;
 Wed,  6 Feb 2019 11:59:09 -0800 (PST)
Date: Wed, 06 Feb 2019 11:59:09 -0800 (PST)
Message-Id: <20190206.115909.1678532321505448811.davem@davemloft.net>
To: rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next 2/6] phy: armada38x: add common phy support
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1grLTg-00061F-Hc@rmk-PC.armlinux.org.uk>
References: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
 <E1grLTg-00061F-Hc@rmk-PC.armlinux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 06 Feb 2019 11:59:10 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_115914_886622_13B1A894 
X-CRM114-Status: UNSURE (   4.96  )
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
Cc: andrew@lunn.ch, jason@lakedaemon.net, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, gregory.clement@bootlin.com, kishon@ti.com,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Wed, 06 Feb 2019 11:34:52 +0000

> +static int a38x_comphy_probe(struct platform_device *pdev)
> +{
> +	struct a38x_comphy *priv;
> +	struct phy_provider *provider;
> +	struct device_node *child;
> +	struct resource *res;
> +	void __iomem *base;

Reverse christmas tree here please.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
