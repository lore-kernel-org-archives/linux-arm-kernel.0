Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E7220700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENNpXR7O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2mlhkbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E7220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7rt28Rs4bfAE128u66JAxeKGj6a/Y0mdShKuMb0lufo=; b=ENNpXR7OWMV2OK
	oLOdOriWYXgz5pDwLrwSwqDsknOHSX6yY9542T0PrDD4a66ewJCSNPnDVsgq3wM9gmJTYgzHmV/SD
	Wz6wXdHsTLsJnfTpgRsKanPL8kXPGRa/syoGIIs2Q5VSsKTAVTQB4Xy8oIBdK3Y84SML2gy6umkil
	b0QwVcBp00I6kU3w5AC+dE1XMF4RH6J9nLCzVIjsXYGdvuXKRGuZegwJ0MYJf0+Oyp1HpbfXfDgif
	m1vgndtfM5gQoyQnFBIJIspUL6etuOd0QjhQT3VrUVE0+oSaQBIagMIyer8e4ZHt9LHuKu8DKX81L
	ltn/y2UkAO2AC/ogHOGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqcO-0003Kz-TL; Thu, 06 Dec 2018 10:10:52 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbZ-0001BV-IS
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:19 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so11562620plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kAZFAsMe6hZyGv5RzFXOQY01K5owXwcpa6Gj4RdYfLU=;
 b=A2mlhkbXkZpjgEqBQ4YZbuwMAkvlehsRCIJxTI4iYiC7c3WzDU7YIuPN1ycIh139sG
 Qu0+cHE1dO3bTwd+nGj0d/2zo1pZbuo1B6Bkvi3mp9MSml+d3wgsbbGJyG9t0mqcyHpV
 uae8CJ1VoR4cn2g8bJdsBtQzeobY0KSnxdww4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kAZFAsMe6hZyGv5RzFXOQY01K5owXwcpa6Gj4RdYfLU=;
 b=Io+p+wjoHDX7KdqwTbcJ8yHaJAReAfbibPy2cEkRia4bsI3rc9yEbTvBcnIYi9cpNx
 VUZ5GWZV5mQo+4TQFvJODfLEyQOUNCQnalADx96Dv4AigOhxS0WWhPCTmGIoE78uD3sG
 23icQf2dHSYbvPy6o0vZMs9QOCVjzwTDU14jZ+A+H1TQwWqAgbyeIYtGXqJeV8jjpPad
 snyfV8TB8z3pLkRYjljdUgciROSkVu6AO7G5p42HwpJPWxq+JbNNlZnyX7UBPe8jK/hy
 n5uNBYvSfyp8gMUFkl64V//2IdrqDg7ED1aT2aCQfCoKodvkrpZD3ZLWxgxRvrZdOrE4
 emUw==
X-Gm-Message-State: AA+aEWamEGWf7vW9UVFsK1HQgLU04Vebf6e79yPv8WNFunX0czg0SnKP
 7Q/EbGN7Ldc7+Lj7ms+zvi+oBRH2WSwgv4N6LFQgzw==
X-Google-Smtp-Source: AFSGD/WZ4ET0u3SIXj0I70/iJWZ/4hF3pE8zGA7spHW4T7hjjyD/ZR7zhHTFbEFplrLbmhPL+KKze90vJfs9uCvUt+k=
X-Received: by 2002:a17:902:b68d:: with SMTP id
 c13mr27666751pls.102.1544090990437; 
 Thu, 06 Dec 2018 02:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
 <CANMq1KAL7TcVa4xF8=NdK2cs0VakEq5i6MyCvfmYTGCmJ78-ag@mail.gmail.com>
 <09f56edb-2dab-c023-2164-dd7b5cef6afb@suse.cz>
In-Reply-To: <09f56edb-2dab-c023-2164-dd7b5cef6afb@suse.cz>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 6 Dec 2018 18:09:39 +0800
Message-ID: <CANMq1KAJ7YvbpUvRqP0zEWY1_pC-TvHMZYn4FUj4A9Bpmv_jxg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To: Vlastimil Babka <vbabka@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021002_701422_D20DA90A 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 5:37 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/6/18 4:49 AM, Nicolas Boichat wrote:
> >> So it would be fine even unchanged. The check would anyway need some
> >> more love to catch the same with __GFP_DMA to be consistent and cover
> >> all corner cases.
> > Yes, the test is not complete. If we really wanted this to be
> > accurate, we'd need to check that GFP_* exactly matches SLAB_CACHE_*.
> >
> > The only problem with dropping this is test that we should restore
> > GFP_DMA32 warning/errors somewhere else (as Christopher pointed out
> > here: https://lkml.org/lkml/2018/11/22/430), especially for kmalloc
> > case.
>
> I meant just dropping that patch hunk, not the whole test. Then the test
> stays as it is and will keep warning anyone calling kmalloc(GFP_DMA32).
> It would also warn anyone calling kmem_cache_alloc(GFP_DMA32) on
> SLAB_CACHE_DMA32 cache, but since the gfp can be just dropped, and you
> as the only user of this so far will do that, it's fine?

I missed your point, this would work fine indeed.

Thanks.

> > Maybe this can be done in kmalloc_slab.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
