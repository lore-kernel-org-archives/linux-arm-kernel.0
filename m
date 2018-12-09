Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C9C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244D82081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfVt3IZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244D82081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TOBYrxmk+KV8UiwBqBp80VPA0eDsT93BKsCIfLTdo0M=; b=VfVt3IZNE8betF
	7O8H0F8U+K0QAT1UhEigUf+p9ZvfdCwrIZA2b3+AekYuExggUeew9uTx15PDJE+n1565MVNc8/yju
	4FaZERUQLCNeRE2eNMLUWbtR5whVdXC64oHaW3ZACM4DLN6wEt9mypdwQGkc/rcLUV78p4Z0VEgQt
	Hyh3n5IfC0cJ3xtV8YW4rKl5iFgYE/Dx8mxU70dyZTitp3y+2StnCbAG0ZEfEzw+hk6vH6SMtP9qx
	hKmSJxrd6lApSnv1poF6QP13YsMYKDXhkFGZ0xRwd4SiVcYKHvqJKDrl77HxvDmdxZYHkxspwcvc/
	BXZHw1pHxMp3oByIsVsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVrAJ-00089W-0q; Sun, 09 Dec 2018 04:58:03 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVrA6-0007zC-RN; Sun, 09 Dec 2018 04:57:52 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F18C141E13FF;
 Sat,  8 Dec 2018 20:57:34 -0800 (PST)
Date: Sat, 08 Dec 2018 20:57:33 -0800 (PST)
Message-Id: <20181208.205733.639997534873546175.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH 1/6] sparc: remove no needed sbus_dma_ops methods
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181208174115.16237-2-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-2-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 08 Dec 2018 20:57:34 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_205750_970955_7BADF418 
X-CRM114-Status: UNSURE (   6.57  )
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
Date: Sat,  8 Dec 2018 09:41:10 -0800

> No need to BUG_ON() on the cache maintainance ops - they are no-ops
> by default, and there is nothing in the DMA API contract that prohibits
> calling them on sbus devices (even if such drivers are unlikely to
> ever appear).
> 
> Similarly a dma_supported method that always returns 0 is rather
> pointless.  The only thing that indicates is that no one ever calls
> the method on sbus devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
