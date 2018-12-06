Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115FF20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q9szsKaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115FF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgTTVjuH6a6NyFQWDDzY7JguzPaT1/n6rhBKpva8Obw=; b=Q9szsKawG3Ba1A
	5vxKidYJ5pO8ipgES+LHOKy9KFVNclzISQeQk8N2RRRjFCJmRX6Q5IXcTjGWDRHek+HXpVw9dSdbj
	tVCxoUC3SJgHj6wa5B0hqif+LkDe4cEQv45RselTf8ak4RcVqiWE35ZP/vk/D2pVauWmL4sk41xm0
	R+zo9bbzBFN8XQHaxKusGrcIRFMErb3vqpvLASSRbD9LWYZXpKJ3riGsZZIHC+By0cb8kz3v0919n
	AsS+spQ0MslvmJHwjuwit+6oy/yo6NCOrq1Gniwz129w+XjIB+4jrJd95ZYXv94wmJyH8ZzaiooIk
	oliC7hxmGl/Q+JcCBCJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUulh-0003bN-PC; Thu, 06 Dec 2018 14:36:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUulb-0003aY-88; Thu, 06 Dec 2018 14:36:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8D38620745; Thu,  6 Dec 2018 15:36:27 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 139DA20CC5;
 Thu,  6 Dec 2018 15:36:10 +0100 (CET)
Date: Thu, 6 Dec 2018 15:36:10 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [RESEND PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for
 parsing partitions
Message-ID: <20181206153610.26db522c@bbrezillon>
In-Reply-To: <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
 <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063640_035920_7E297817 
X-CRM114-Status: UNSURE (   6.45  )
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
Cc: devicetree@vger.kernel.org, Guochun Mao <guochun.mao@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 14:29:54 +0800
Ryder Lee <ryder.lee@mediatek.com> wrote:

> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> Replace mtd_device_register with mtd_device_parse_register for
> parsing partitions and add ofpart support.

What's the problem with the default partition parser table [1]?

[1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdpart.c#L793

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
