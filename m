Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439BA2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WfohhDou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BA2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CXQo72e14+1QHdx5Swpivo5mJviI680GzbNOXEx42jQ=; b=WfohhDouNldLux
	9/+0agWg5a/h3egCjyuq5rC6Ca2FWpK2iuhwSnsQEJH90hT4Utgbf1bPJHtDLzh0QJVaN9xnpljCx
	Ursqia3UdmKvbtUOCGzpQIEY48bSYP5+CqnKmDstHvckTnY5FxsvULsbz0G7Re0UqwUjDUHPtz5aJ
	Lqtg48prn91RxirR/CaJN9C527FhlbHN9OWK+2/24WlvBIvHnnV6AcVK4gBXiKoxMfdq9Qkxy5rGv
	fNyCEYYGvHFCFW55uIT58Nvp4KbD8Qv21ZrCmrgXI1RQo098nt3wrpAYYTNVwEeBJDXHJa+TpgBUc
	/xMVa/2M33dnhApy/QaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1jj-0004Pw-SU; Fri, 28 Dec 2018 23:40:15 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1jg-0003BL-Gx
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:40:14 +0000
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net
 [24.6.170.16])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5B4DB49;
 Fri, 28 Dec 2018 23:39:59 +0000 (UTC)
Date: Fri, 28 Dec 2018 15:39:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-Id: <20181228153958.40cfb7a9b446225d73c585cd@linux-foundation.org>
In-Reply-To: <20181228084834.GA8658@lst.de>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
 <20181228084834.GA8658@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_154012_590033_34782929 
X-CRM114-Status: UNSURE (   9.17  )
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
Cc: sfr@canb.auug.org.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, shijie8@gmail.com, robin.murphy@arm.com,
 Huang Shijie <sjhuang@iluvatar.ai>, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 28 Dec 2018 09:48:34 +0100 Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?

That symbols from subsystem foo should be called foo_*.  Not uniformly
observed by any means, but it is a thing.

> The old name certainly looks more sensible to me.

It does read better, but it's rather a standout in this case:

q:/usr/src/25> grep EXPORT_SYMBOL lib/genalloc.c
EXPORT_SYMBOL(gen_pool_create);
EXPORT_SYMBOL(gen_pool_add_virt);
EXPORT_SYMBOL(gen_pool_virt_to_phys);
EXPORT_SYMBOL(gen_pool_destroy);
EXPORT_SYMBOL(gen_pool_alloc);
EXPORT_SYMBOL(gen_pool_alloc_algo);
EXPORT_SYMBOL(gen_pool_dma_alloc);
EXPORT_SYMBOL(gen_pool_free);
EXPORT_SYMBOL(gen_pool_for_each_chunk);
EXPORT_SYMBOL(addr_in_gen_pool);
EXPORT_SYMBOL_GPL(gen_pool_avail);
EXPORT_SYMBOL_GPL(gen_pool_size);
EXPORT_SYMBOL(gen_pool_set_algo);
EXPORT_SYMBOL(gen_pool_first_fit);
EXPORT_SYMBOL(gen_pool_first_fit_align);
EXPORT_SYMBOL(gen_pool_fixed_alloc);
EXPORT_SYMBOL(gen_pool_first_fit_order_align);
EXPORT_SYMBOL(gen_pool_best_fit);
EXPORT_SYMBOL_GPL(gen_pool_get);
EXPORT_SYMBOL(devm_gen_pool_create);
EXPORT_SYMBOL_GPL(of_gen_pool_get);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
