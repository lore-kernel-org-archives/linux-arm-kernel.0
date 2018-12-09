Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E522081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ntg0KiBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E522081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBIOZqJBNZnm1xhgUQvZGEQg0L/xz0ADUiAwlKlexKo=; b=Ntg0KiBZ+XYp64
	jsi84tyxVWDqdvBKohD8JRYcjsKyvjaWnupJfqAUzuR1++PrCtX1ch/vAb8dYf6VYeZfFqXeDre/G
	fmLfbb35lR/ZVGHLnW6bLuZrqy9hkjG7gsP1sa/A4oOqL17fNe/kspJKIFQwegQltYq/2qBvGoTxX
	rJVIJTRcTsu++wpdj67lbBfEu9/GqnaBMsfRAMWcderEnZoPukruSNmJmsmt789q4ZKY981ukKBOu
	Lrhb1N5Sp6x9vXCV/BkQPI8rM2wVA52o9LF5/MO+Kb63MCYVJGC2KxsB87wghOzDx0Ut63K5on34z
	R1pVrdvzhFKRWekTnhag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVrAq-0000Fw-AN; Sun, 09 Dec 2018 04:58:36 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVrAL-00081I-46; Sun, 09 Dec 2018 04:58:10 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 60EAA141E1414;
 Sat,  8 Dec 2018 20:57:54 -0800 (PST)
Date: Sat, 08 Dec 2018 20:57:53 -0800 (PST)
Message-Id: <20181208.205753.909472854043389455.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH 4/6] sparc: remove not required includes from dma-mapping.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181208174115.16237-5-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-5-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 08 Dec 2018 20:57:54 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_205806_449951_0E5F828C 
X-CRM114-Status: UNSURE (   4.81  )
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
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com,
 linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:13 -0800

> The only thing we need to explicitly pull in is the defines for the
> CPU type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
