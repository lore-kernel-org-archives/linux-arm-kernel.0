Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:48:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0252075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iw13urdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0252075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GXyrAy3AYo1cNPPWIPgOKIwA5z1WD1F1T5/jcflgxuM=; b=Iw13urdbTUjSIl
	K5MUTr3CUKgQDi0l2MIBDa55FSUAQsqAByl6B3D1frcea/hKoIEzRUqj1d5YqNa6eRbjOSZBZfVk0
	EbMWElwKOTfvDIavY19+qctw67ghRkCQKVrgTDkBXlx/Yo1vbBqhwXSuAbgvx+79VMMdpfE3z2N9l
	60tMfFGFpNXDApPezhVlqtE+2Is9/NdrIKdPOiswhkfNNSTzvjae0lR+nAw1p2xzV1+UJ1zUo+DWj
	n2YfRWAXl70HuxFCSIbILgBk123ZovJccOHb99VPs2AozUAnehuCHN5VQPpALNz/p+wR10rKelW95
	LGqpau2YRSlfGyxBlgAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gragE-00005o-H3; Thu, 07 Feb 2019 03:48:50 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gragA-0008WT-TI
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:48:48 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DD18B14017AC1;
 Wed,  6 Feb 2019 19:48:41 -0800 (PST)
Date: Wed, 06 Feb 2019 19:48:41 -0800 (PST)
Message-Id: <20190206.194841.1230954195969874310.davem@davemloft.net>
To: helgaas@kernel.org
Subject: Re: [PATCH] net: Don't default Cavium PTP driver to 'y'
From: David Miller <davem@davemloft.net>
In-Reply-To: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 06 Feb 2019 19:48:42 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_194846_941873_79D94C0E 
X-CRM114-Status: UNSURE (   6.15  )
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
Cc: aleksey.makarov@cavium.com, netdev@vger.kernel.org, rad@semihalf.com,
 linux-kernel@vger.kernel.org, pombredanne@nexb.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 05 Feb 2019 14:47:21 -0600

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 8c56df372bc1 ("net: add support for Cavium PTP coprocessor") added the
> Cavium PTP coprocessor driver and enabled it by default.  Remove the
> "default y" because the driver only applies to Cavium ThunderX processors.
> 
> Fixes: 8c56df372bc1 ("net: add support for Cavium PTP coprocessor")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
