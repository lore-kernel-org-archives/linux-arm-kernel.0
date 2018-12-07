Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37168C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B8720838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+/EpYed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B8720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c5Wwi6KVYpGgLBbjR5akEta/uv4axhSkt4STo6psZH0=; b=i+/EpYedUjPn/6
	tnG9uof83wkD46MUdu6PWRTb/33ePnuZHRgCdYKk54q8zYgecqqxAeFWn7fS5iPXonjUtbMG0ODC7
	hP06gM9QV6OawLkhsrKWZ7Ob6lRVDvsQuCg1AcaYJf4smyGLL05Q3lfdyHc2sTaQ73x6jJdaMGXUw
	Opx18jK6thcBlfQP94GX+iWKLkWedBK02YnniTfbucZ4ephiuq7ILIjZVggkqv9v2bZConupaQDzK
	2c/7VMIdAOpuoLMjT6nmCR2fVivJV0EXREdD5BRW02VAAVoK7lOYOdJQdXHTlxrTXgtNDSjYzErFz
	7n6ezGzFg8oTE/gcWrZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV8wD-0002qm-4J; Fri, 07 Dec 2018 05:44:33 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV8w8-0002qF-Iw; Fri, 07 Dec 2018 05:44:30 +0000
X-UUID: d8ebf40d5dd2418b8e511b6b63ee64b3-20181207
X-UUID: d8ebf40d5dd2418b8e511b6b63ee64b3-20181207
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <guochun.mao@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 615148597; Fri, 07 Dec 2018 13:44:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 7 Dec 2018 13:44:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 13:43:59 +0800
Message-ID: <1544161439.8955.3.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for
 parsing partitions
From: Guochun Mao <guochun.mao@mediatek.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Fri, 7 Dec 2018 13:43:59 +0800
In-Reply-To: <20181206153610.26db522c@bbrezillon>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
 <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
 <20181206153610.26db522c@bbrezillon>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_214428_851321_9FD043B0 
X-CRM114-Status: UNSURE (   8.85  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-06 at 15:36 +0100, Boris Brezillon wrote:
> On Thu, 29 Nov 2018 14:29:54 +0800
> Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > From: Guochun Mao <guochun.mao@mediatek.com>
> > 
> > Replace mtd_device_register with mtd_device_parse_register for
> > parsing partitions and add ofpart support.
> 
> What's the problem with the default partition parser table [1]?
> 
> [1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdpart.c#L793

No problem here.
This patch can be dropped.
Please help review others.

Thanks.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
