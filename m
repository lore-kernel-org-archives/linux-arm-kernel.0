Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D66C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:22:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7C82081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="td3fuBxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7C82081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=punHqvyEshSp5wRrQj4Cs07aG1yEtB2ADv20irKNeXI=; b=td3fuBxPGiz5Ik
	Fi9UyugmMZeYVZUWLhHTMSMuehGE/iwI2CZifFtB2DYgzJZWJ8YI2JqfZyrtjmWK+meGbuQsmqMqR
	7Jzkcpsbb9XE8aREIfzyxjIhtLVawVxmWmYZ6S5rm2Q4BLSPlad1dpk/MJJvpHLUuMxv8C2mNMlwE
	sdNroyCaau/v7N/D3LJWJ0dzBDS47MrX7NLMhvGCoQ1ZHQKnFfkny6/zW85qj1p2dSHCo64VboiHd
	ya0F7bAh+YDuXxToZ8XDo05vme/Bchu8RqZznevxD/DvBSTUdbs8ATyBgQFmLJd+TtQT9a/q/Df1R
	fsLmoeD9WH6ozt2xRegA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWR8e-00036i-9i; Mon, 10 Dec 2018 19:22:44 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWR8a-00035b-NF; Mon, 10 Dec 2018 19:22:42 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5C23F68DD2; Mon, 10 Dec 2018 20:22:28 +0100 (CET)
Date: Mon, 10 Dec 2018 20:22:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-ID: <20181210192228.GB31178@lst.de>
References: <20181208174115.16237-7-hch@lst.de>
 <20181208.205806.42785512174962944.davem@davemloft.net>
 <20181210163256.GA27331@lst.de>
 <20181210.101039.1882227517259366533.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210.101039.1882227517259366533.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_112240_906617_2993E8C6 
X-CRM114-Status: GOOD (  12.78  )
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
 linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:10:39AM -0800, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 10 Dec 2018 17:32:56 +0100
> 
> > Dave, can you pick the series up through the sparc tree?  I could also
> > merge it through the dma-mapping tree, but given that there is no
> > dependency on it the sparc tree seem like the better fit.
> 
> I thought that some of this is a prerequisite for the DMA mapping
> work and overall consolidation you are doing.  So I kinda assumed
> you wanted to merge it via your tree.
> 
> I anticipate no conflicts at all, even until the next merge window,
> so it could very easily go through your tree.
> 
> Let me know if you still want me to merge this.

These patches are purely cleanups I found while auditing the DMA
mapping code, at least as of now there are no dependencies.

That being said now that I looked into it a bit more they do however
depend on the ->mapping_error removal, so I'll take them through
the dma-mapping tree.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
