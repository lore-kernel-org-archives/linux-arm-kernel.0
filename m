Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED24C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01052084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XL2isrrH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aSU5E2C0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aSU5E2C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01052084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7W41+uSggmjUN9YgVIL7BT9lkBqcjnHjpSiAbSRlPx4=; b=XL2isrrH8NvWMJfj0dPNyKUKd
	fLyasBYPHJQFmmn75mxDzRzp0PBrccbA7mmgkVGX9RrvPNN6sjERctxq2MQ2uj0/sGTMdgP98Euwj
	eEi8haDR1KYu6Cg0b0/27mZf2Qwd9ev74P/DzZt/9qqdhw5lpfi/bqHqeGYpaGPa1U5BVePPFwb9Q
	rSvVIGXb3CNfe6+qSun0vXDrVJTPyhJpgOKq3CnbcXn4NN15haXdYFa5qOw5UMcW54734v8xEyPf+
	88EnhXpnYe3mbbG3lrdNR1AuT9yQo188gRFOMx8yYDuv2oDw/lHS7XGx2qRlQnJ/NsRVRf57MJcsR
	l6eZucHiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyzw-0004LJ-Kp; Wed, 12 Dec 2018 07:32:00 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyzt-0004KS-Ai
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:31:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 4770F602F8; Wed, 12 Dec 2018 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544599906;
 bh=EFOvIC798zKoREZ2sbl+bMzqVLeps+9+eeC67B8qELs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aSU5E2C0O4sjU9mXJrS5LDCTUrPd+QSlWQ46YGCIpGV2yHr7O2kGj42WIdLWQL+hL
 ujT7SlIOOIcHMzNi7zB7IxYzGskbvByaRjYaUFh5awTWar2HvHqlZfFD3v9wlTew+p
 hXQdTySgn7FSxmui27ck0MtwTGe8BZZnPXvQ6QRc=
Received: from [10.204.79.8]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cpandya@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4631060115;
 Wed, 12 Dec 2018 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544599906;
 bh=EFOvIC798zKoREZ2sbl+bMzqVLeps+9+eeC67B8qELs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aSU5E2C0O4sjU9mXJrS5LDCTUrPd+QSlWQ46YGCIpGV2yHr7O2kGj42WIdLWQL+hL
 ujT7SlIOOIcHMzNi7zB7IxYzGskbvByaRjYaUFh5awTWar2HvHqlZfFD3v9wlTew+p
 hXQdTySgn7FSxmui27ck0MtwTGe8BZZnPXvQ6QRc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4631060115
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH] arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing
To: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com,
 catalin.marinas@arm.com
References: <9bd208e9187db7a934428fe44ae0906028a8c9c3.1544469820.git.robin.murphy@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <9f6d3b29-7ca6-c78f-c4b6-f10dd318b1d9@codeaurora.org>
Date: Wed, 12 Dec 2018 13:01:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9bd208e9187db7a934428fe44ae0906028a8c9c3.1544469820.git.robin.murphy@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_233157_402759_39138D57 
X-CRM114-Status: GOOD (  19.57  )
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
Cc: hch@lst.de, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/11/2018 1:03 AM, Robin Murphy wrote:
> We need to invalidate the caches *before* clearing the buffer via the
> non-cacheable alias, else in the worst case __dma_flush_area() may
> write back dirty lines over the top of our nice new zeros.
> 
> Fixes: dd65a941f6ba ("arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/mm/dma-mapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a3ac26284845..a53704406099 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -429,9 +429,9 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   						   prot,
>   						   __builtin_return_address(0));
>   		if (addr) {
> -			memset(addr, 0, size);
>   			if (!coherent)
>   				__dma_flush_area(page_to_virt(page), iosize);
> +			memset(addr, 0, size);

For coherent case, we still skip flushing/invalidating dirty kernel
mappings. Isn't it a problem ?

Shouldn't it be,

--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -774,9 +774,8 @@ static void *__iommu_alloc_attrs(struct device *dev, 
size_t size,
                                                    prot,
 
__builtin_return_address(0));
                 if (addr) {
+                       __dma_flush_area(page_to_virt(page), iosize);
                         memset(addr, 0, size);
-                       if (!coherent)
-                               __dma_flush_area(page_to_virt(page), 
iosize);
                 } else {
                         iommu_dma_unmap_page(dev, *handle, iosize, 0, 
attrs);
                         dma_release_from_contiguous(dev, page,


>   		} else {
>   			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
>   			dma_release_from_contiguous(dev, page,
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
