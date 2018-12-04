Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AA72087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZEtwfLFl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLd7ADZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AA72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OYhVlBajqHvLVoFiGdkQ3+a4qHPviznES9+CjZXuvMU=; b=ZEtwfLFlNlJVDl
	zBo77nDEWPXNy5SZQo+FWKXbk49phWVTEAmUdZPp+kD3CYRV6bcMr8mbsHYiNxxYWk9XN57/P6gAX
	fKUO6lX9MenSEIlZSS+C/5HjUhAuPsx9yxb60gxgY1qo6gZjzMkxZUv3zQeOnZWSYFjubDZQRNILJ
	3Ia2tJCyYlCXmuIMgqN5kiYtLY9/SdrnOd86PeEoyyxka4Vr5HCcLZv2ou6rpUUyz+LFKUlFBDkyc
	YYw3HgVewcXlmHToqEpPW+B3nYfs66fxad7OWxoAuGY+98LdoBGtsgV6hd+bNqfotsIR0kOMBCfsn
	SXZbCzjp3rzsUS6RoyKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU79A-0007QS-7n; Tue, 04 Dec 2018 09:37:40 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU795-0007Lc-TS
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:37:38 +0000
Received: by mail-pl1-x642.google.com with SMTP id u6so8005720plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 01:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jxu65MuZDQD/oVINYAKaqUGGlfdLXfq3cyugvKlk2g0=;
 b=FLd7ADZXlJwebvf6xsGa/j3V2NISFRiwJB5Yj/hrHrjyFRHTJOsF/LSez61ktQ//yB
 qMy/EV/wforoDAgd5BJjZvpmJmC8GlvBOYRcgcMYrzUjWNE74AW77gBQJOAJFnXCRV/P
 byamuJgG1WMWSIoydjhNvtzOdbSGfH4/5nick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jxu65MuZDQD/oVINYAKaqUGGlfdLXfq3cyugvKlk2g0=;
 b=CTefcAv6QkJZUVJb7dunLytJKb5yLbzVPT4B7NSGZMwRxFK93zUqB0XhnyhA5ByyYJ
 vRDjXoO/RWw9Oe7Gbb3skxceei6yA8rylSTb725Zru10sYVp/eQljhfbV3PUvavstmR1
 DQqRgry3VdlqebAwewLiny3wJXXY3ttqSvWHinm3yw7ba1aGcPFFxOnl0jcpYlT95DdJ
 KiRKapsCbBRBbKqypRvbdTwwlCul/70s0xjzXJBFf0KxJgFP0VDMz/BqqZTfk0asfZb/
 dpguF2sJKIE/1IQZDrAZFIXSss76XwPDZrTDb7ZXUD7lHvzHddpsJjHx835wVcIjtAuc
 eTaA==
X-Gm-Message-State: AA+aEWb/dwE7eFNFHcq1ZgScZya7CXwzoJOQXCc/BGV14IAkR1yi6+e5
 jiapA1izQuwrkwHosr8/s0+woMsrAbNbhVzQDTmmMQ==
X-Google-Smtp-Source: AFSGD/XhXwuY1hCeC1u1hxNWTk/mj0L2cH5JbyBoVnyXaus0mNQGN3obQJCiQDPbY2MEbBR/WUQwXKH2kl0lsf7tydA=
X-Received: by 2002:a17:902:b68d:: with SMTP id
 c13mr19379871pls.102.1543916244988; 
 Tue, 04 Dec 2018 01:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 4 Dec 2018 17:37:13 +0800
Message-ID: <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To: Robin Murphy <robin.murphy@arm.com>, Christoph Lameter <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>, 
 Michal Hocko <mhocko@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 hch@infradead.org, Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_013735_996722_C9D515C2 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: Levin Alexander <Alexander.Levin@microsoft.com>,
 Huaisheng Ye <yehs1@lenovo.com>, Tomasz Figa <tfiga@google.com>,
 Joerg Roedel <joro@8bytes.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Daniel Kurtz <djkurtz@chromium.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Yong Wu <yong.wu@mediatek.com>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Nov 11, 2018 at 5:04 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> This is a follow-up to the discussion in [1], to make sure that the page
> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> physical address space.
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html

Hi everyone,

Let's try to summarize here.

First, we confirmed that this is a regression, and IOMMU errors happen
on 4.19 and linux-next/master on MT8173 (elm, Acer Chromebook R13).
The issue most likely starts from ad67f5a6545f ("arm64: replace
ZONE_DMA with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number
of Mediatek platforms (and maybe others?).

We have a few options here:
1. This series [2], that adds support for GFP_DMA32 slab caches,
_without_ adding kmalloc caches (since there are no users of
kmalloc(..., GFP_DMA32)). I think I've addressed all the comments on
the 3 patches, and AFAICT this solution works fine.
2. genalloc. That works, but unless we preallocate 4MB for L2 tables
(which is wasteful as we usually only need a handful of L2 tables),
we'll need changes in the core (use GFP_ATOMIC) to allow allocating on
demand, and as it stands we'd have no way to shrink the allocation.
3. page_frag [3]. That works fine, and the code is quite simple. One
drawback is that fragments in partially freed pages cannot be reused
(from limited experiments, I see that IOMMU L2 tables are rarely
freed, so it's unlikely a whole page would get freed). But given the
low number of L2 tables, maybe we can live with that.

I think 2 is out. Any preference between 1 and 3? I think 1 makes
better use of the memory, so that'd be my preference. But I'm probably
missing something.

[2] https://patchwork.kernel.org/cover/10677529/, 3 patches
[3] https://patchwork.codeaurora.org/patch/671639/

Thanks,

Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
