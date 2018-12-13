Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF222087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DtdN4wz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF222087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qHL+4lgsUg6ETmSk5M2Me+Y4ZEs/R77BdNGXxgFukMU=; b=DtdN4wz3uAizdo
	22LUcWF3j7hyIuDCzyn17vQfBhiM5g8zlhQl53yjuuZjggKRz59/mtzwqu/fnm39BletIKX28Trqi
	xbLYripZc5QRKLLBkN8Gi7sSRa3YSorYBg91pTObQbxSGmbucTXP+DnJyoRdoHMB/ruFmzAJHOOi4
	uGLWtLeUhvup2Rc2CX4x0N/B+69OQipvJ7oEVWI7UIezkUhQ2ujVt5NSLe5D+47KGrRxz7D99i2bu
	/yvrvICuWVTY6jYY0zqffI2oSkwIGq4YsGBuTbT6AGy1PGaDX9TE8XeeVOJwQOaJnX9fu9qczkcYg
	P8oIou/mtc3VUbgqkrXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXJkJ-0005C8-HN; Thu, 13 Dec 2018 05:41:15 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJkG-0005Aa-7p; Thu, 13 Dec 2018 05:41:13 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 3047114B3CFD5;
 Wed, 12 Dec 2018 21:40:55 -0800 (PST)
Date: Wed, 12 Dec 2018 21:40:54 -0800 (PST)
Message-Id: <20181212.214054.1923431319770488052.davem@davemloft.net>
To: biao.huang@mediatek.com
Subject: Re: [v7, PATCH 0/2] add Ethernet driver support for mt2712
From: David Miller <davem@davemloft.net>
In-Reply-To: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 12 Dec 2018 21:40:55 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_214112_294680_3A972F83 
X-CRM114-Status: UNSURE (   4.98  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Thu, 13 Dec 2018 09:56:11 +0800

> Changes in v7:
> Add MODULE_LICENSE info in driver.

Biao, I said I need a "fixup" patch, not the whole series again.

I've already applied your patches, and you need to send me a small
fix on top.

This shows that you are not generating your patches against my
net-next tree properly.  If you were, you would see that I applied
your changes already.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
