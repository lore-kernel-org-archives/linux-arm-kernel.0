Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1586C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C9F206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qIgRIlZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g96k33tvJRJBzi//Wl9I4aDSO2Pnkewgv3UNmdLDwCc=; b=qIgRIlZrCy8/5j
	FBiXOLHTLLgNr7VSt+wJcVuuhiTOMmLo06Ze2H8u9s2xf361Z4I2CgTPQ8X6Dl0Sti1ccsgOj2X0k
	1Jn7gZffj/746FHl2qwZzVSZgwbFutwdxwx1S7AV54UAC5tBfhSKPJtxfJcawKt5jLxyquMSo9J0l
	gX3nyFLO1WPcRsTrPvIbN7dmykdGPbh/fho/yuB6eI1IMk7i0z5MmBQ+zUOAdat3sHvYYIGnEjUyC
	IdG8jJej6R6yUPh/YpUtHFr5zky11VQh2KNNdKrX7yUX+WSWY9n1U7DXzxlqqBmqsul1YCTFjzJUt
	jkf/wSoLbSMGHs3jo6Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxref-0008US-IN; Sun, 24 Feb 2019 11:09:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxrec-0008U7-9l
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 11:09:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72C7EBD;
 Sun, 24 Feb 2019 03:08:59 -0800 (PST)
Received: from MBP.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90AB3F575;
 Sun, 24 Feb 2019 03:08:58 -0800 (PST)
Date: Sun, 24 Feb 2019 11:08:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Xuefeng Wang <wxf.wang@hisilicon.com>
Subject: Re: [PATCH] Use flush tlb last level when change protection
Message-ID: <20190224110855.GA26770@MBP.local>
References: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_030906_345166_F3C92CA8 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 02:47:27PM +0800, Xuefeng Wang wrote:
> The protection attributes are only kept in last level tlb, so
> protection changing only need invalidate last level tlb, exclude
> the PWC entries.
> 
> Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
> ---
>  mm/mprotect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 36cb358..0c4303d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -287,7 +287,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
>  
>  	/* Only flush the TLB if we actually modified any entries: */
>  	if (pages)
> -		flush_tlb_range(vma, start, end);
> +		__flush_tlb_range(vma, start, end, PAGE_SIZE, true);
>  	dec_tlb_flush_pending(mm);

You are changing a generic file to call an arm64-internal function,
breaking all the other architectures, so NAK.

Do you actually see any performance improvement?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
