Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FE620659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/JT4jRh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ds7LUbS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FE620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=rssnG1Ckj6T67U8fj1DOYTUSJDniHADgaTC3eXH4q4k=; b=t/
	JT4jRhIYE+jxf7YbV1MPBvDhNXUsnDZcSA9SGGD6nd8oV5C1THcvhlNuLbbupQT6Fd+o1NiNt89BD
	BMaYUng2U8kAhYa05S6oh54BfLxK4cbDmx//9oLwdThhzhq3nMmq9bad4w47CxVHADZHD7nVllLCG
	R7okuzL+692EfHw2H+5FQxeAEr+n3QtEqMsMg4uEG0DF2/WiIqWQ8tQfnB5tdIwWOGiPC+zEFQH9V
	ziTyzmFCF3fkOsPriw/OhzJf9ALwiGXOv9nE/aNv+rl+IMw8aqyBwsXfg8ugh6Y3WKyXKEhptDP8P
	C/7T0efl5lNAv8Cu4qcbxJQ2LT/BIYuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2Ch-0001KL-FY; Mon, 14 Jan 2019 13:22:59 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Cd-0001JV-0P
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:22:57 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190114132251euoutp013de5b0f4cbdb32ef2bbfdc9ae5ebc9f0~5ub3H1B8V3180331803euoutp01V;
 Mon, 14 Jan 2019 13:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190114132251euoutp013de5b0f4cbdb32ef2bbfdc9ae5ebc9f0~5ub3H1B8V3180331803euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547472171;
 bh=9Bm0/N1nu1c2zVgkFwc9NC/6S40YahbeYi8Y9hJdpn8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=ds7LUbS+N8MBZCQhPXU5gj9cW6iLiyWcSnffHIxX7y3YIrVvtLJU8PCcntU2rjW8I
 Agkw1y8QYj0r6eqpJLAu9sGvlttuTFL9Tx73kop2/2mGonyG1zQk8SKkS9WrG25vT+
 j+88NmPji2DhszSojOFqEtbXVyhVlEW0jBziyyrQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190114132251eucas1p2c124d49896a18f2698f10ac5872f18c0~5ub2oRgIb0783807838eucas1p2f;
 Mon, 14 Jan 2019 13:22:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.9E.04294.A2D8C3C5; Mon, 14
 Jan 2019 13:22:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594~5ub1snaKf0787207872eucas1p2K;
 Mon, 14 Jan 2019 13:22:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-0c-5c3c8d2a6da0
Received: from eusync1.samsung.com ( [203.254.199.211]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.13.04128.A2D8C3C5; Mon, 14
 Jan 2019 13:22:50 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PLB005UJP5UV920@eusync1.samsung.com>;
 Mon, 14 Jan 2019 13:22:50 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Revert
 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Date: Mon, 14 Jan 2019 14:22:40 +0100
Message-id: <20190114132240.12125-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7djPc7pavTYxBhP2WVpsnLGe1eLl8g5G
 i5WrjzJZLNhvbbHp8TVWi8u75rBZrD1yl93iUv9EJouDH56wWrSt/sBqcfs3nwO3x5p5axg9
 Ll+7yOyxeUm9x+Qbyxk9dt9sYPP4d4zdo7f5HZvH+31X2Tz6tqxi9Pi8SS6AK4rLJiU1J7Ms
 tUjfLoEr4+uHRYwFN/kr7qz4zNLAuJm3i5GTQ0LAROLB9AuMXYxcHEICKxglDsy4zA7hfGaU
 OLa2hQWuat9xNojEMkaJjmeboKoamCSW/53NDFLFJmAo0fW2iw3EFhHIkph/cQ4rSBGzwCUm
 iSMnt7KDJIQFYiVeNT9hBbFZBFQlOnvmgDXwCthKHD74ihFinbzE6g0HmEGaJQRWsElsOrWd
 GSLhIvHjw3xWCFtY4tXxLewQtozE5cndLBANzYwS7TNmsUM4PYwSW+fsYIOospY4fPwiWDez
 AJ/EpG3TgaZyAMV5JTrahCBMD4k7J8GqhYAO3THlOeMERokFjAyrGMVTS4tz01OLjfJSy/WK
 E3OLS/PS9ZLzczcxAqP39L/jX3Yw7vqTdIhRgINRiYdXYrZ1jBBrYllxZe4hRgkOZiUR3jIn
 mxgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjBNn6dWZ
 b+h0nX29S8jrvDT79YhCXxbpFu+Xj3Je3938KjeG87ai8NHPYp+Pre1rMJOx2LVHK/KjfqJr
 jVt16P6zrc90HDcb39+7bN9C61bV/b2znkd/LeBvY7tz79yWGZWOP2Y0XamZuvaOur5x6p4r
 T1YuNlS+LPFPPGTKbdmN9kyfmY5/1FRiKc5INNRiLipOBABfMId72gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsVy+t/xy7pavTYxBis+s1psnLGe1eLl8g5G
 i5WrjzJZLNhvbbHp8TVWi8u75rBZrD1yl93iUv9EJouDH56wWrSt/sBqcfs3nwO3x5p5axg9
 Ll+7yOyxeUm9x+Qbyxk9dt9sYPP4d4zdo7f5HZvH+31X2Tz6tqxi9Pi8SS6AK4rLJiU1J7Ms
 tUjfLoEr4+uHRYwFN/kr7qz4zNLAuJm3i5GTQ0LAROLBvuNsILaQwBJGiRkHzbsYuYDsJiaJ
 6y0bmEASbAKGEl1vu8CKRASyJHa++soEUsQscIVJomnGMUaQhLBArMSr5iesIDaLgKpEZ88c
 sAZeAVuJwwdfMUJsk5dYveEA8wRGrgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECw2vb
 sZ9bdjB2vQs+xCjAwajEwysx2zpGiDWxrLgy9xCjBAezkghvmZNNjBBvSmJlVWpRfnxRaU5q
 8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGiBlHPXN2fF1z+tkKM2Xd92dWi6oJ
 uXTFMhyTPMN/YfXUVa/lw9rl7j7LWtghUx6qsvS59S+WvJ67e24eSDEVPvrurpjLCrkZ6oqR
 axg2x5xR+cBvfc5B6n2qUPVfTiPZwgXrZVdNbZx1puXjQWahKquCcybnPH/ILvx60UTA+7/9
 8yuPzjZsUmIpzkg01GIuKk4EABk0V8ArAgAA
X-CMS-MailID: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052255_360667_1F238A7B 
X-CRM114-Status: GOOD (  14.63  )
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
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Russell King <rmk+kernel@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.

That patch broke IOMMU support for devices, which fails to probe for the
first time and use deferred probe approach. When non-NULL dma_ops is set
in arm_iommu_detach_device(), the given device later ignored by
arch_setup_dma_ops() and stays with non-IOMMU dma_ops.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3c8534904209..5827a89b7de1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1145,11 +1145,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
 	return __dma_supported(dev, mask, false);
 }
 
-static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-{
-	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
-}
-
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
@@ -2294,7 +2289,7 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
+	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
@@ -2355,6 +2350,11 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
+static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
+}
+
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
