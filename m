Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B34920659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZPoAm8g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nKW/mobI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2oAHB0M6m/dTZuMRCheUUSaxF514ZXl/fVqhWqVoJw8=; b=ZZPoAm8gxGptWHzEmNYFHG5Deu
	Ei7jc4owPpfvqitjBRiMW5c50jGXboLLvI76JmTC7lLaP0Q6T2lKXzB6DDcTSHuRiKC1cRNJgZbJD
	edE9Mij4lYfkjvwwf33vwJqDazutNf9f8Piimjllk9MezaFWxa08R89O3eWh5r3dmiZCdWQwfo1sy
	DdTNpfb1N8iIWRWGD4P1Ahkze4A46sXgjd0COyc7ozovct0lsSgOtYp15Hm50w1rgwA0tGZutasb+
	tDAugDddjwBZLKPyuGhXzgQbguVWlvQDiMyEhRaSj8Ds2lMXJKv8LV7nI8AFdPInlTiRorNUjSTrL
	bWFoXtFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUCP-0000bZ-B1; Wed, 05 Dec 2018 10:14:33 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUCL-0000aN-SI
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:14:31 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205101415euoutp0179cfb4fb6d0eac12b579a47ebf65750a~taDxDIQ0v1751017510euoutp01G;
 Wed,  5 Dec 2018 10:14:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181205101415euoutp0179cfb4fb6d0eac12b579a47ebf65750a~taDxDIQ0v1751017510euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544004855;
 bh=4Qvx1KCKZvwlBOI+tsDFgTYDAZcHhgPM85JYd5xBkcY=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=nKW/mobI265TFJd33mBcC4Zb+Xz/hXT6BGEdAaFyfU7ZLiHEVqMhgNHgNNZM2nRY/
 AuDjqg2gx9EEDStP0UlFrVScxgWBggKWq68cp1CUwBpEN+Z8WWvU2YUUosV8+e/PSC
 /Ajun9jygyfeykfFatcpMitJUwtxq4xKCV5jxKfE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181205101414eucas1p24a2e8d62730bfcdc18e853f29ff8b0de~taDwnOR-T1911919119eucas1p2B;
 Wed,  5 Dec 2018 10:14:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.A8.04441.6F4A70C5; Wed,  5
 Dec 2018 10:14:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9~taDv2RHeD1910819108eucas1p29;
 Wed,  5 Dec 2018 10:14:13 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-60-5c07a4f6a846
Received: from eusync3.samsung.com ( [203.254.199.213]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.05.04284.5F4A70C5; Wed,  5
 Dec 2018 10:14:13 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PJ900G82DRLDG70@eusync3.samsung.com>;
 Wed, 05 Dec 2018 10:14:13 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: fix lack of DMA address assignment in generic
 remap allocator
Date: Wed, 05 Dec 2018 11:14:01 +0100
Message-id: <20181205101401.3561-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181204142304.GC2618@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7djPc7rflrDHGLy6L2vxflkPo8XK1UeZ
 LBbst7ZYuecHk8Wmx9dYLS7vmsNmsfbIXXaLv0cDLQ5+eMJq8fLjCRYHLo8189YwenT9mMHq
 sXlJvcfkG8sZPXbfbGDzeL/vKptH35ZVjB6fN8kFcERx2aSk5mSWpRbp2yVwZZxa3MxecJuj
 4v9xjwbG5exdjJwcEgImEpOfXWHsYuTiEBJYwSjxd/8tFgjnM6PEjOXvmWCqNk/ZzAxiCwks
 Y5SYNqEcoqiBSWL19QZGkASbgKFE19suti5GDg4RASeJyzMVQGqYBTYwSXye+JQFpEZYIFbi
 9u9+sKEsAqoSz36dBbN5BWwk/q9/xgaxTF5i9YYDYMs4BbQlVrbvBbtIQmADm8T9LRNYIYpc
 JE5+OQj1g7DEq+NboGwZic6Og0wQDc2MEu0zZrFDOD2MElvn7IBaYS1x+PhFsEnMAnwSk7ZN
 ZwY5W0KAV6KjTQiixENizrpGdoiX6ySOHtvGOoFRcgEjwypG8dTS4tz01GLDvNRyveLE3OLS
 vHS95PzcTYzAqD397/inHYxfLyUdYhTgYFTi4ZWYwhYjxJpYVlyZe4hRgoNZSYR3hQ17jBBv
 SmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQZGVWcx122spqu+
 diUqddlsKp/pb6ziwKv7oTiTM2LFKuFXyz+2bgrWE9Kf2jZxhblR74rpjL3FrKmB+1c/XPos
 VF/sxAHunYcy37ldZHj244Xv1dvtgqsn1q0q2Vi1qcct8OKt+0eDf1b55p+oLitkPMOssSDF
 Lebhtr8/N/kkfTePiLCaW/ZLiaU4I9FQi7moOBEAkJVs1dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsVy+t/xq7pfl7DHGFyeq2nxflkPo8XK1UeZ
 LBbst7ZYuecHk8Wmx9dYLS7vmsNmsfbIXXaLv0cDLQ5+eMJq8fLjCRYHLo8189YwenT9mMHq
 sXlJvcfkG8sZPXbfbGDzeL/vKptH35ZVjB6fN8kFcERx2aSk5mSWpRbp2yVwZZxa3MxecJuj
 4v9xjwbG5exdjJwcEgImEpunbGbuYuTiEBJYwihx/+FpJginiUli/+JvzCBVbAKGEl1vu9i6
 GDk4RAScJC7PVACpYRbYwCTx485JsEnCArESt3/3M4HYLAKqEs9+nQWzeQVsJP6vf8YGsU1e
 YvWGA2AzOQW0JVa272UBmSkkoCVx763wBEaeBYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3
 MQLDbduxn5t3MF7aGHyIUYCDUYmHV3IKW4wQa2JZcWXuIUYJDmYlEd4VNuwxQrwpiZVVqUX5
 8UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhhj11pH7P6felspcbbImRum
 Fu83r3rJ28R32VW1//r0VHVf9qA3K+xsY35cXbCW42/SBwe92W8kpARsj2y/cLQ2XcYpO7bN
 ze3T74OXtU+3WP2T/T6J60muz8m3k7Z9fyzkNe3CWfEO99YWcaltt/TZuw0DlrAne0Xcyf3R
 krmh4ZDR1M2lbI+VWIozEg21mIuKEwGHTg7zMwIAAA==
X-CMS-MailID: 20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9
References: <20181204142304.GC2618@lst.de>
 <CGME20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021430_217651_9C4BA02B 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
 Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit bfd56cd60521 ("dma-mapping: support highmem in the generic remap
allocator") replaced dma_direct_alloc_pages() with __dma_direct_alloc_pages(),
which doesn't set dma_handle and zero allocated memory. Fix it by doing this
directly in the caller function.

Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap allocator")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/remap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 68a64e3ff6a1..8a44317cfc1a 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -223,8 +223,14 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
-	if (!ret)
+	if (!ret) {
 		__dma_direct_free_pages(dev, size, page);
+		return ret;
+	}
+
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	memset(ret, 0, size);
+
 	return ret;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
