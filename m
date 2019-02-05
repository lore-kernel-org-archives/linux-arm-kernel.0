Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3DC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:20:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D75A2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aKTEVU88";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Svkh4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D75A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r38lTMqI1M8O8sMFqx+2AsQMFsZtyfcwCyvq5E9l78w=; b=aKTEVU88EKpnSB
	IUl5lH7xWv5JZC/xKI74Ojmcwqwng4rEQeWB33y1ZNHLve8d1dQIsiv5Yk/LiFI0eP7tcSqT4fzXw
	PPVLgjvvz+gq8yRqYkVzcor+ksTbVAt30uwFEtmcmiC8VnaZMym8ZGxkrxylFBEOTWW2FVTLYRoba
	SriX2OYouDfCj2TJL3bUdOtPxoGD9+i/5PDHwNF0dQqYkptUVQ+mhQ9oUKWZNcBm+qicdN1lvBbFJ
	sctDvct+Q5NQx8fgjuf/G8ALtVi8bz3AVvVtxvz2Tw3rmBO1TRFSWnpWuFuwoJi2dScDL65Kc5kYa
	aqQqz/GPUhY4fuumG/zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4Os-0007Dj-MF; Tue, 05 Feb 2019 17:20:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4Op-0007DE-QM; Tue, 05 Feb 2019 17:20:45 +0000
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFBF5217FA;
 Tue,  5 Feb 2019 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549387243;
 bh=RVKkQCgUgR5Qyd/LL1WgnvBjFRtHkHFRHLH3NzMZ3OA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=K+Svkh4/U3prAkWj/+rCTAzhEBIFqhSQF5Xv8qLcxireB7gy5yAYZ9Gucm04LGSJe
 Wffq8l7SMpfY33Pihhv3yF9TNSLaQJ4IVV3VvGnKFevQ7XrVATj3G+w30XpMQYFUXH
 calCZd5HGsh+kL2URxLSp1XBF3t9n5UOM72bcRc8=
Received: by mail-qk1-f177.google.com with SMTP id o125so2556602qkf.3;
 Tue, 05 Feb 2019 09:20:42 -0800 (PST)
X-Gm-Message-State: AHQUAuaBWi2h9EGPR7Y3qvAkz1hpiTm2xWpiG4tIlXbTTzxq7NIxIUPR
 wLoKC4KjEpibZIKKIj0SrwgXuii2crGULkE5OA==
X-Google-Smtp-Source: AHgI3IYHPjzRFIhu6d0Ek1JFNDNkny/kaodqJ7VGGy7kJKCXUyYxS+FnewNRL00mALwjLoekjW3IOVMleHnuBv05kb0=
X-Received: by 2002:a37:5686:: with SMTP id k128mr4103413qkb.29.1549387242088; 
 Tue, 05 Feb 2019 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20190205163731.17864-1-robh@kernel.org>
 <20190205165528.GA20157@infradead.org>
In-Reply-To: <20190205165528.GA20157@infradead.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Feb 2019 11:20:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYC6OStkM+bcwhM5cA3fBcXQCiL_pVUE=sPoLrPHoVvQ@mail.gmail.com>
Message-ID: <CAL_JsqLYC6OStkM+bcwhM5cA3fBcXQCiL_pVUE=sPoLrPHoVvQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_092043_872044_C12C45F6 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 10:55 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
> > Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
> > and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
> > use the ARM page table library. Specifically, some ARM Mali GPUs use the
> > ARM page table formats.
>
> Maybe rename it to arm-io-pgtable.h to make the usage a little more
> clear?

I should drop the first 'ARM' in the commit message.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
