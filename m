Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B7C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D635620818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMtGN6UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D635620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ceMksI/oz/91GHGskplFJFiZC8RbVHZE69RcrMCYaqM=; b=VMtGN6UGVUvCX3wsbNWEab6Xn
	vVsvrC5un8vtC97K8Xs1t0vR5CAoCT0tR3lmbXliIg+qLhYlbF/2KSneOZVtzFM2z5BAF3FNSWeI8
	XPyo1FbaQFreEs0ZD96Yofot2sF38b7cPJT7dS3sZb3+DrVjrLuXA+MsywJxXv8noyrGLmKGU3OZB
	fwhfXRWkxzQ0opXwj8bHy81O1sdNqNxK6ZzsepRO2Dk4pjbQWM56kNrqn2F+SrEAHIYQv7LPpLWzV
	sg7Ja278EXd66RAwuaMVM1VG1AEG+Mzuhot0c4WRoY1Wh+dKDCnWY5JR8EPSwHTnYmoC/YcvPd6kY
	oc6e+/hMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4H3-00042l-Qf; Tue, 05 Feb 2019 17:12:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4H0-00042K-RY; Tue, 05 Feb 2019 17:12:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027C1EBD;
 Tue,  5 Feb 2019 09:12:36 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77DF33F557;
 Tue,  5 Feb 2019 09:12:34 -0800 (PST)
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
To: Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>
References: <20190205163731.17864-1-robh@kernel.org>
 <20190205165528.GA20157@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a6002b86-e18a-dd97-6dad-ab69e994678d@arm.com>
Date: Tue, 5 Feb 2019 17:12:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205165528.GA20157@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_091238_899300_F423FF06 
X-CRM114-Status: GOOD (  15.15  )
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
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/02/2019 16:55, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
>> Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
>> and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
>> use the ARM page table library. Specifically, some ARM Mali GPUs use the
>> ARM page table formats.
> 
> Maybe rename it to arm-io-pgtable.h to make the usage a little more
> clear?

It's not Arm-specific, though - the whole point of io-pgtable is to be 
an architecture-agnostic library of IOMMU pagetable code. It just 
happens that the only formats implemented so far are the Arm ones that 
already have more than one in-tree user each.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
