Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9100FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:01:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4901920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pU3jKYKW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjp6fPye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O2bJfQxEQETcQFlhnAx3XSeQavljIu2PiEUatpk0xgM=; b=pU3jKYKW9F3H6x
	PmvH2Owm8YXZQlf9cNjkdq98pSLpcEYE2LczhMePmjgAuE5/q3p5AtmyxovAMJ8Wew1QSmt1wn8cL
	4JpWIukQ75yzZzjTRhZVmssKHojCG8M1yx3Arr5fdCM2bq3vjDAqIgJuC82mxUD1rBTru+N9hQnM5
	kE+DYNa7Xi0wvrWY0C45TH9kcSZmiyzfiNUjCrsVwj7H72bPaHXbPC3mhj15v7FFdMDHYGY4X722O
	W1BM5y+TkQiCezGayu+7I1Zl1WSpP4minJ8qRtbkTNUX+c1EeeAvNHWekoroo7pS51QPWi2xiA/Y1
	1jwGZVwkSsiunhfyH8tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUw9-0005bq-DQ; Wed, 05 Dec 2018 11:01:49 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUvn-0005AZ-Ue
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:01:34 +0000
Received: by mail-pl1-x643.google.com with SMTP id gn14so9887204plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 03:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fAwxirXvKSBwHD7F87FQNRm1Bs8VUKIJ1ixDohaxvyo=;
 b=jjp6fPye3+yWNPt145+nY0kGHOOdSMnqumE8d06LeJbKKU+Hxe1vctFtVfz66IomL/
 5tOM6q/6xliyE6EyvrgxxrE7p3kBJmLUBEa+kykNCxYMQDxKc63p/fITVzWhK2lUP5TK
 U+bbS7es4Etx0I30scYfPfMwtmhXEO9UfNqJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fAwxirXvKSBwHD7F87FQNRm1Bs8VUKIJ1ixDohaxvyo=;
 b=N7foBia9rFmUZewp+zBJZXDjNBt9KxRJBamau1vA899sK2dGrISag8glfs2T+FjiXO
 5ZWCSa2mMR57QaHUmMV2F/Qs0+ID649dzDxWESp8wycOL8aSI6+RdiW16tDtA9aMDTCv
 APnmlis//evi4MzNb0LwAh0zc8HFmVRL4aYh/DL3V+j8z05NvgN0RIZjqVYvbGUsqRUK
 G/cMPt6DMxnglz6Uqg4jspHisyMHU7hkZe3Oia/wEvgbX9C17EIimwEXkJc5i2uKD3aZ
 qXTkkyGmuuyrBx60Kg/uQFHTfELO6L0dV5lX6b3CV5CZCaNTfEAF1JU4gHFdBHI6OtmD
 +/YA==
X-Gm-Message-State: AA+aEWZ4tknHQfpdl+IAWHruUs8/Mfm0/7M371u3yOmnwHk+enow3Ylg
 QZNUiT3rNmT6Jp5JV5ms25aUtZ27lHzn3H1H/ust1g==
X-Google-Smtp-Source: AFSGD/Wk0zs4VhqhdwYbu2PyFWGf/M2ApBaccL6hKiY9HzccaDJKBrxcsNLKo6cKHPwSnn9CjE1s7A6FIsX17UlinCg=
X-Received: by 2002:a17:902:820f:: with SMTP id
 x15mr22731032pln.224.1544007676601; 
 Wed, 05 Dec 2018 03:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <20181205095557.GE1286@dhcp22.suse.cz>
In-Reply-To: <20181205095557.GE1286@dhcp22.suse.cz>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Wed, 5 Dec 2018 19:01:03 +0800
Message-ID: <CANMq1KCnpSUKoz83LcEgAkhCi8QVPH715xtgdQD23r-tYusrPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To: mhocko@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030128_090220_61807E1A 
X-CRM114-Status: GOOD (  20.67  )
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
Cc: Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org, Yong Wu <yong.wu@mediatek.com>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 5:56 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 05-12-18 13:48:27, Nicolas Boichat wrote:
> > In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
> > data structures smaller than a page with GFP_DMA32 flag.
> >
> > This change makes it possible to create a custom cache in DMA32 zone
> > using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> >
> > We do not create a DMA32 kmalloc cache array, as there are currently
> > no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
> > ensures that such calls still fail (as they do before this change).
>
> The changelog should be much more specific about decisions made here.
> First of all it would be nice to mention the usecase.

Ok, I'll copy most of the cover letter text here (i.e. the fact that
IOMMU wants physical memory <4GB for L2 page tables, why it's better
than genalloc/page_frag).

> Secondly, why do we need a new sysfs file? Who is going to consume it?

We have cache_dma, so it seems consistent to add cache_dma32.

I wasn't aware of tools/vm/slabinfo.c, so I can add support for
cache_dma32 in a follow-up patch. Any other user I should take care
of?

> Then why do we need SLAB_MERGE_SAME to cover GFP_DMA32 as well?

SLAB_MERGE_SAME tells us which flags _need_ to be the same for the
slabs to be merged. We don't want slab caches with GFP_DMA32 and
~GFP_DMA32 to be merged, so it should be in there.
(https://elixir.bootlin.com/linux/v4.19.6/source/mm/slab_common.c#L342).

> I
> thought the whole point is to use dedicated slab cache. Who is this
> going to merge with?

Well, if there was another SLAB cache requiring 1KB GFP_DMA32
elements, then I don't see why we would not merge the caches. This is
what happens with this IOMMU L2 tables cache pre-CONFIG_ZONE_DMA32 on
arm64 (output on some 3.18 kernel below), and what would happen on
arm32 since we still use GFP_DMA.

/sys/kernel/slab # ls -l | grep dt-0001024
drwxr-xr-x. 2 root root 0 Dec  5 02:25 :dt-0001024
lrwxrwxrwx. 1 root root 0 Dec  5 02:25 dma-kmalloc-1024 -> :dt-0001024
lrwxrwxrwx. 1 root root 0 Dec  5 02:25 io-pgtable_armv7s_l2 -> :dt-0001024

Thanks!

> --
> Michal Hocko
> SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
