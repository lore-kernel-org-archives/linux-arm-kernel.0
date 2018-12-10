Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2FD20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W7CchT2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2FD20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gkgqFrjUDfJOc8hFleKWtWhryCtC4sU/C+h87FLSfV4=; b=W7CchT2BYWTgUn
	bON1De+0TNqSnrcUSoxJ7Hl6WZUEmLO/aPtX1Nkim9eQZeD/55FDH2tmt/maVhEUrn5ChP1r7MBge
	pyBR+LsREh9oKnoFdtZljjy5hbsZVXXC/IR0phuxQTmfSgpluM9ufDEfImCbQ8UZMOJaUlm9cgoJy
	mOTEnQGVmusntuR3D4zCdLeswoTJ9zvcWo14xNxyApLApDK9xgCpnrgMQ65Inrief1RFDwQJaIhUW
	sHrhlr+vFveO+p04aKvtl4GSpW/mDeu4nhdga3AbVFoiI6InFUmGO12uIgihv34Qpm6FZERej8MXz
	jTNkSn1F/vD0hDU6jtTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRJ6-0000TZ-LW; Mon, 10 Dec 2018 19:33:32 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRJ3-0000SH-9i; Mon, 10 Dec 2018 19:33:30 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id E08C7147364BC;
 Mon, 10 Dec 2018 11:33:12 -0800 (PST)
Date: Mon, 10 Dec 2018 11:33:10 -0800 (PST)
Message-Id: <20181210.113310.460303100337934249.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181210192228.GB31178@lst.de>
References: <20181210163256.GA27331@lst.de>
 <20181210.101039.1882227517259366533.davem@davemloft.net>
 <20181210192228.GB31178@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Mon, 10 Dec 2018 11:33:13 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113329_341034_F5B9905D 
X-CRM114-Status: GOOD (  10.73  )
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
Date: Mon, 10 Dec 2018 20:22:28 +0100

> On Mon, Dec 10, 2018 at 10:10:39AM -0800, David Miller wrote:
>> From: Christoph Hellwig <hch@lst.de>
>> Date: Mon, 10 Dec 2018 17:32:56 +0100
>> 
>> > Dave, can you pick the series up through the sparc tree?  I could also
>> > merge it through the dma-mapping tree, but given that there is no
>> > dependency on it the sparc tree seem like the better fit.
>> 
>> I thought that some of this is a prerequisite for the DMA mapping
>> work and overall consolidation you are doing.  So I kinda assumed
>> you wanted to merge it via your tree.
>> 
>> I anticipate no conflicts at all, even until the next merge window,
>> so it could very easily go through your tree.
>> 
>> Let me know if you still want me to merge this.
> 
> These patches are purely cleanups I found while auditing the DMA
> mapping code, at least as of now there are no dependencies.
> 
> That being said now that I looked into it a bit more they do however
> depend on the ->mapping_error removal, so I'll take them through
> the dma-mapping tree.

Ok, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
