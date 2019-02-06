Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C97C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE1E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C9tscord"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jk5DLRUGGE/lXji/ym/ScHV9FjEGOrWShf9rF5L/a7w=; b=C9tscordhe9biKuJuJy5kr6qB
	Zw4wK7wHyK7CDtBpIVPPbKoEIbVgaQxwjIWiW8FzZleCPjr4agQSKKnh1p6ywCS0dkxDD5jHp7FCC
	LdX9N1gZkGV3GAUk/7IU+6VrGidzeNuUdS8Nm5+pwwuKd+UIr2MZQH6X72cvRbZuHEEaIjwTzMLCS
	l78AGc4Ik+kKPhYwL2DxXl02gjvdF6/nqb4yHuMclsWobq9Bkfiv5aRRk2s5Or4fU5msnXUz7kQGH
	iRyD0VIE+e4+2tzMAweeoo2t6rSe5BLxi+7kQnbuzKvk6OAHQGpHwSDwzMuEL1MLHKHCrTbHOg2iZ
	f676K4C5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOoU-0000dh-Oh; Wed, 06 Feb 2019 15:08:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOoR-0000dG-52
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:08:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D29280D;
 Wed,  6 Feb 2019 07:08:29 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B8A3F675;
 Wed,  6 Feb 2019 07:08:27 -0800 (PST)
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
 <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
Date: Wed, 6 Feb 2019 15:08:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161305.GI6532@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_070831_191621_96A84926 
X-CRM114-Status: GOOD (  19.90  )
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
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/02/2019 16:13, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>>> includes unconditionally so users can rely on it, and add a missing
>>> comment describing the #else cpp statement.  Last but not least include
>>> <linux/errno.h> instead of the asm version, which is frowned upon.
>>
>> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted
>> from the arch code as a fresh-faced noob yet to learn the finer details, so
>> ack for those parts. The forward-declarations, though, were a deliberate
>> effort to minimise header dependencies and compilation bloat for includers
>> who absolutely wouldn't care, and specifically to try to avoid setting
>> transitive include expectations since they always seem to end up breaking
>> someone's config somewhere down the line. Admittedly this little backwater
>> is hardly comparable to the likes of the sched.h business, but I'm still
>> somewhat on the fence about that change :/
> 
> As far as I can tell almost all users of linux/dma-iommu.h require
> CONFIG_DMA_IOMMU to be enabled anyway..

Other than dma-iommu.c itself, none of them *require* it - only 
arch/arm64 selects it (the one from MTK_IOMMU is just bogus), and a lot 
of the drivers also build for at least one other architecture (and/or 
arm64 with !IOMMU_API).

Either way, I have no vehement objection to the change, I just don't see 
any positive value in it.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
