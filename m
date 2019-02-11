Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E5C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336F9218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPC64TU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336F9218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CaO5hHrxuTOWMzasmOAeww4h35NDJ4MahOvA7xyf118=; b=HPC64TU5mgRZGp
	WDlI0yHgVSaYLeIh87pAqBfaB+HbVnPictH/IGBVku1Yo27vqKWfoq2qQe4hoATygi/u9alWKTO+4
	vlz3x9Kr8jSMDkFH1qZBlxIxFYwxOTUu8M0GC2/HCq8/qxRXIb1D1FK7z2HVvCdjUQWLXw6rD0S9p
	hEQJwhK+4c9CvVyHcs+lRVfHDfwN+Ha106QUHPW8ql0zFfJgjramodSpjNy6GfQVD/By7B4e9gLap
	EZGIv0JZUlb4Ih9eHdnqhPC6OvGff1stDJB90mMhUos7+DPPaV+N+TcjobIMrbh6xEIg2QuIorg0v
	K6FpVx+QL1Mw3wYMTqaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDzj-0004SK-V7; Mon, 11 Feb 2019 15:59:43 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDzh-0004Rc-8Z
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:59:42 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5762868DD6; Mon, 11 Feb 2019 16:59:38 +0100 (CET)
Date: Mon, 11 Feb 2019 16:59:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Message-ID: <20190211155938.GA27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
 <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de>
 <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_075941_446191_21C70DDC 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 03:08:26PM +0000, Robin Murphy wrote:
> Other than dma-iommu.c itself, none of them *require* it - only arch/arm64 
> selects it (the one from MTK_IOMMU is just bogus), and a lot of the drivers 
> also build for at least one other architecture (and/or arm64 with 
> !IOMMU_API).
>
> Either way, I have no vehement objection to the change, I just don't see 
> any positive value in it.

I've moved the idef back down below the includes.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
