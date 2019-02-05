Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:55:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEEA217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0Otn4f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEEA217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8tOVzWbVIC/hXcU/DvhgsfR1Woe/U2iwvT9GCnwXKTQ=; b=K0Otn4f7vc2JZL
	IRcIiOnWiH8RGgwk6vgScuj9R3ikuEoEvx68r6mkkXixUpmdc/w8TmegOBKhTrUtBngP0nwf7CET4
	ECvRNDE3Kp7775Dfoo1b1g1ENlRmpjD6PwQGi/M21LmxQVJ5qFAkwoHtB02/faimPOKnhT3GiMgEu
	bp5isV4qKx8ObJL3Gs7M8Tw/k2+s5ap7b3evKkfvjP0gWs4ggnvaBPAZbSq4jMn4JfwBipeN+O4pm
	iv7eAZMkuVnBvnixqyXJQjOMZC5a8i9ygGyjA4ZNvGTjjQH79LH8EyF/C0Y2bMgflqkN+J56tJ/1c
	EVbufH8QgX9I+A3/RtJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr40S-0006ao-TI; Tue, 05 Feb 2019 16:55:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gr40O-0006aD-NK; Tue, 05 Feb 2019 16:55:28 +0000
Date: Tue, 5 Feb 2019 08:55:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
Message-ID: <20190205165528.GA20157@infradead.org>
References: <20190205163731.17864-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205163731.17864-1-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
> Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
> and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
> use the ARM page table library. Specifically, some ARM Mali GPUs use the
> ARM page table formats.

Maybe rename it to arm-io-pgtable.h to make the usage a little more
clear? 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
