Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45779C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5722087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ha1qoJjK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm0itLub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5722087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E2L+Oi/JqBSJljkt1vhV8JQejc8ZNIAEjAxoENz0kKY=; b=ha1qoJjKuxr84b
	PC06XhiZOqW7qtFS+ZNKvcNIgTYqEgYCZVorZpJ8NT92fBlzLHguefx+Ou3Sb8c2oJQtD7cgwSjxi
	qb+0IfuQkNkOG3vX+bLyHSChE9xyI0T1BQq2+qU+UlMkbW2UjTz5jDu3GenlxSJpeC9GLrqpo6aHT
	HzQUehTQDPCXnE9dU6l0iz1bxh/G0LcTWQXOifAuCtTZhd/GlmGI1oPwHtBqVA92gSCdMJaGmwGwn
	rf2Tj1E5WuW9TBLHzsUeEejrd8SawzECC3zphZGDBb3+XbwZJp3dziO7Qt9RDwyvgI9Idgtsjx+/s
	lT9NDYJW6bE9E+Vfee3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBWA-0006e4-DP; Thu, 31 Jan 2019 12:32:30 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBVm-0006V8-Gw; Thu, 31 Jan 2019 12:32:21 +0000
Received: by mail-lj1-x244.google.com with SMTP id u89-v6so2554043lje.1;
 Thu, 31 Jan 2019 04:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MUni9/6Z2lGMVz53wyw6zTg0RWZ4vyfLf6KBzYMBEmg=;
 b=rm0itLubnrxxq4PPU48BdkkmPOHGmoawlXX7TkirV4StzYrvbOIna0ghZQS2MZ2t76
 XhmHBOPccSIjpVoDYvh6YrtIBr5eW0+bdYyC3OkQ7c8WSywe3qd9fTk75H03Iczx/vz+
 ica0fn1RP61+8A8QOUdr2YeGNhb1x8j06LH67rCa56PhTSaWcsKMzCFrGAKWvu8izLO1
 r9n/88H88jlojH/9LggBml0yrFb/uQsNo2A7e1JgfSAEKysdVB90p+WDPw0Udz+KvqR8
 XIGDjJcmERRAXarrPQcdwF9vNp/LZDRJsdhZkxzMTILaiGDq0d2CfYCAzuog8UhXWLuy
 RKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MUni9/6Z2lGMVz53wyw6zTg0RWZ4vyfLf6KBzYMBEmg=;
 b=gTQGhjfGsYG3S82ZqYdFZZF3K6YjnKE+I3k/42KSX3FOmF7uSRpjLrcymCwIPN6uqS
 umOVwE0pcImWZUQgnLqZG6C9HXLkTjTXgyRkxGTeYg1CfxnfFYjDlP+FeaT6edcmz8di
 PWCNrB4sKTqG0l9TQdHXEuTzmTKl/k+izcmAViCmnhKDOOECnZpGaBWdrLEAclUK03Ls
 dZb3dSu1LYlTAIqhaHjHZUBRIlX0J/W5PS7aMeXNbdX2UgOCQjj2tVqWo+eOZb+xsit9
 NPV8410+pdPztYbW6bHBcjT3IsDVVMyLaUn3giuaZzHEn5K0L+vtaIeBv1rC/2uSJuX1
 UFSA==
X-Gm-Message-State: AJcUukd8SVO0JZsP5QX/ujMQjY6duoJdXgKddsX8pfdf4hCu/8agSDjC
 oLzTiWBtZzFhaR9BT+Bfkf3BefKso+ilaXAJbDY=
X-Google-Smtp-Source: AHgI3IYqaijPCAbpcAfqB4K9ZTYxFfKIZ7xmxN6niWa1cYJjdCHW8ay1HiYLvHZ4e1NWitw9Tq+lwpQUU40Nwq+GS9I=
X-Received: by 2002:a2e:5703:: with SMTP id
 l3-v6mr16102340ljb.106.1548937924232; 
 Thu, 31 Jan 2019 04:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <1701923.z6LKAITQJA@phil>
In-Reply-To: <1701923.z6LKAITQJA@phil>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 31 Jan 2019 18:01:52 +0530
Message-ID: <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_043207_019515_678CF1C3 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, iommu@lists.linux-foundation.org,
 rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 Juergen Gross <jgross@suse.com>, hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 5:37 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 31. Januar 2019, 04:08:12 CET schrieb Souptick Joarder:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating new functions and use it across
> > the drivers.
> >
> > vm_insert_range() is the API which could be used to mapped
> > kernel memory/pages in drivers which has considered vm_pgoff
> >
> > vm_insert_range_buggy() is the API which could be used to map
> > range of kernel memory/pages in drivers which has not considered
> > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> >
> > We _could_ then at a later "fix" these drivers which are using
> > vm_insert_range_buggy() to behave according to the normal vm_pgoff
> > offsetting simply by removing the _buggy suffix on the function
> > name and if that causes regressions, it gives us an easy way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Suggested-by: Russell King <linux@armlinux.org.uk>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
>
> hmm, I'm missing a changelog here between v1 and v2.
> Nevertheless I managed to test v1 on Rockchip hardware
> and display is still working, including talking to Lima via prime.
>
> So if there aren't any big changes for v2, on Rockchip
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Change log is available in [0/9].
Patch [1/9] & [4/9] have no changes between v1 -> v2.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
