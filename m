Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFDC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:11:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3237920831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P6hQe5nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yDDvMp/6i5mtBz1gMXP0/yPLWNqYm7st6TF2kvJ4VQU=; b=P6hQe5nne/cONH
	hpvbzt9bs9RXYrPZVQAYnJrBkInV8AwG1DbBnf4Kaf5ntHqsuuuOB66dfiKkFjIjSRWdxfID3vzFd
	LP3Xu6FChUUt4Uirsy3LuEnohF3zApRwwLAaEUzkkiNWYmcvxM8FY2z9iO8k/z3UebTFDXSQlPMt5
	Xtaxoo1sPcyo7Kx9dggH4+ZJD5fUtIPwMWnPaHSw3sQ5Flfc0py/0i5fiRupinmbN+2MtZCRnvWZy
	lcCn8BbKcZ/Vwe69NYy6pHFOHj/0KzcKDhGeWzrPhpg1K0Qa8xPqeUEF2/gF92V4RFLLv5uHgB8Bm
	1WbllCgH2aYGPk1G+TMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVrNI-0005PB-Gg; Sun, 09 Dec 2018 05:11:28 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVrAY-0008HO-HG; Sun, 09 Dec 2018 04:58:25 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C0BE141E141D;
 Sat,  8 Dec 2018 20:58:07 -0800 (PST)
Date: Sat, 08 Dec 2018 20:58:06 -0800 (PST)
Message-Id: <20181208.205806.42785512174962944.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181208174115.16237-7-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-7-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 08 Dec 2018 20:58:07 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_205818_858322_F13EC488 
X-CRM114-Status: UNSURE (   4.95  )
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
Date: Sat,  8 Dec 2018 09:41:15 -0800

> There are enough common defintions that a single header seems nicer.
> 
> Also drop the pointless <linux/dma-mapping.h> include.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
