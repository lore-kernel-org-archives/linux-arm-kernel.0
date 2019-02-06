Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7A0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:55:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729C1218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBnBq3i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729C1218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CzJdSlw1bp4neS+h09p64ufD6eGGBLar6xwZfntSZVM=; b=TBnBq3i/XyRgNV
	KQx9n6GsWpN1ualO5UcFU+lJlko3xllDBGZo+I8eUbRUj/I1Sp2zBRa59wkBT9lI23Lw3w9F91BML
	Edfq6TkQEcWBjxf9zjNpgTFiX0OqBzCFZFYiJEW2Rgju9ZPZXX6lJv98smlD6E+QsiWjUAaknjBeF
	C7DDQHwQZmmQNAtwdh0RtuVHsa/qkMu5DTGVoj15toX0xdSVq7YF0bMb+zAztRaQV0wmKvaqni4dR
	MXeToNmePyKeTa7/+koFCZMPqeqrW6w9KDtbx1KtCtH762w+gaABAM4aoC29BiWHJbcEBhWJ6ZyUe
	AEkbTDOMSqvB9GKMZUUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grH7Z-0002rO-Bd; Wed, 06 Feb 2019 06:55:45 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1grH7V-0002qe-DM; Wed, 06 Feb 2019 06:55:41 +0000
Date: Tue, 5 Feb 2019 22:55:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
Message-ID: <20190206065541.GA860@infradead.org>
References: <20190205163731.17864-1-robh@kernel.org>
 <20190205165528.GA20157@infradead.org>
 <a6002b86-e18a-dd97-6dad-ab69e994678d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6002b86-e18a-dd97-6dad-ab69e994678d@arm.com>
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
Cc: Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 05:12:29PM +0000, Robin Murphy wrote:
> On 05/02/2019 16:55, Christoph Hellwig wrote:
> > On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
> > > Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
> > > and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
> > > use the ARM page table library. Specifically, some ARM Mali GPUs use the
> > > ARM page table formats.
> > 
> > Maybe rename it to arm-io-pgtable.h to make the usage a little more
> > clear?
> 
> It's not Arm-specific, though - the whole point of io-pgtable is to be an
> architecture-agnostic library of IOMMU pagetable code. It just happens that
> the only formats implemented so far are the Arm ones that already have more
> than one in-tree user each.

Oh, ok.  I always thought of it as an ARM thing, but then I missed the
intention behind it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
