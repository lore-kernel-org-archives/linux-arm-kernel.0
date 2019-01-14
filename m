Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1079C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3E5206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fKlHCVbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3E5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2lT68hVX+hGNynx5TTMIalndhESJTlUh1iIaPrEFR7c=; b=fKlHCVbHW1+x0fPAgy6fDOva+
	GbUtESeurxJJdpoWwDqN3+zWk5JJBQDvyZpBvbXLBv6CSiRRqf9mFjeIkOGUVjq2FdM8wGVUcg+ay
	puwqmSEtWmFfY6bZOCcKF8gTNjihZdfVqVQtz/UqeOv6J6eZosUHCaN41y2HOqWc8Ph193Z7T+wG0
	kFK63u7Qvpx/Icto7qrpU+h+1ZArq4/VB7YGhMHvXsxQkzKQDsNntzzyxd5pzyam+l4xtI9WGZJEI
	4JaADJKHbt1EXFF6ttrIdQvad9GnHGjqIgYrfdOOH6na+LPlax3JMNx1cD71Up+T53uS/vSb6dH0h
	lM5yfgHIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5Fq-0004ie-UW; Mon, 14 Jan 2019 16:38:26 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Fn-0004iI-Sg
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:38:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BEEEA78;
 Mon, 14 Jan 2019 08:38:23 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0FCD3F5BD;
 Mon, 14 Jan 2019 08:38:21 -0800 (PST)
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
To: Thierry Reding <treding@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Date: Mon, 14 Jan 2019 16:38:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114160902.GB9218@ulmo>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_083823_926226_C86FF3BB 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/01/2019 16:09, Thierry Reding wrote:
> On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
>> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>>
>> That patch broke IOMMU support for devices, which fails to probe for the
>> first time and use deferred probe approach. When non-NULL dma_ops is set
>> in arm_iommu_detach_device(), the given device later ignored by
>> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>>
>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Can you point out exactly what drivers break because of this change? We
> need to find a solution that works for everyone. Reverting is only
> marginally useful because somebody will just end up wanting to revert
> the revert because a different driver is now broken.

At first glance, it sounds like what we really want is for 
arch_teardown_iommu_ops() to completely clear any ops that 
arch_setup_dma_ops() installed - does the below suffice?

Robin.

----->8-----
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..1e3e08a1c456 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
  		return;

  	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
  }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
