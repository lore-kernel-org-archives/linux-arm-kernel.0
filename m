Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA8C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:15:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8423121850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oIdZtrqN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3Xd7Mol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8423121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wBlQ85wMFSSxTNN3JhHc6cQoxwf6kCXX5sHeRrh9n68=; b=oIdZtrqNRSFML+
	f+erqD08IY8q8+I4ZwkJVk0g4ulgB2bdeT4VbJX0yMNULGkrXuurXtR4vjtT71Yg8BW+bSGYpLVYd
	m7ur/vbJELtJtbHP/aLCA0VCcPO1UoKItDlH0z+9Vc5dHHCQyGAdaqcq+/UfYQP2Z0xWTKtt69jGs
	KnzqHQsYaO91Rciu04JlZj33eAQ1Aa9Xfnj/FfQoY26bKI5Zc5sZH8qJAxGSudDEZYnAU5nlM9ylX
	emsXfJf7msxdCoyfihcuS55Sgyq/JItRUevea1awTT3TMnnmtmh0WiIxSUAjhFwuEb84OBl4Fitsf
	CxHd9fGxkc+6LCAX6Y/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbQ4W-0000hY-Ij; Mon, 24 Dec 2018 13:15:04 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbQ4Q-0000ci-N7; Mon, 24 Dec 2018 13:15:00 +0000
Received: by mail-pf1-x442.google.com with SMTP id w73so5790003pfk.10;
 Mon, 24 Dec 2018 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=6TaUtlS7TeG92dcvMBbOIZkMmLyB09aVGWNeeSIZ3pY=;
 b=d3Xd7MolqeTIJQoUjbD+4dweIgr48eZCrq7SBO35pR2Fitu8erEje+Llq96kKgTaNn
 XPfL1CGWAPc7da/LB62zDpZpORWDHnIR2BjFHRYQyp/+KXF3M0iEvByaht2KpWbLTUSF
 V5VIWYbIwhP1dfjMui59FMP3G4zVM2NSpfC3wkJA8wA1dfEWXoaUbndmy158JAQbEGV7
 1LyOQUqQV9Fgk9ZJ2ZCooYItc9QCHKk8jFkB0A+5yNHmPj3XbGdD3KOM6XxI3ib20uxc
 huNf3L3JPnlFZI3UEuFbedEqb1+lenfo3/eTH4iLnBykOZCUZ8fzgmdmLqU+O3hztuVF
 QY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=6TaUtlS7TeG92dcvMBbOIZkMmLyB09aVGWNeeSIZ3pY=;
 b=dBes2YfsxOd3HmZxRYLEMHGy3CoWkslcKBcLRid7bEzVVAesXh3wl4AoUjO5m7KYEZ
 qMtgUWU61jsfVDvKdk8mqinCScgvins0YXy+qBQICdep9e48oC7bylBX33IuxRndeIhO
 5Ge4NodLJtx9nEAd2cmht5bBCSkoLsMUSfQHJNQYhEtW+nZa3S3iP1cS8Yc3SwAp/5Mp
 dVPBE05BQOMcZNem2w1zoTUxfwOQrOunXKcrwBV4igfuVyyOZouLxBzIkK+BG6WeArUG
 6WLHPrp/Mo0lwdcyhBK44W8T1mXYYjSYmn8OH5E9tw4lJPW83d3OO7dYvI/sxv9eCmTO
 KZNw==
X-Gm-Message-State: AJcUukee0A6ybWFiGnKFQVoe4KiOQ2YZBfhpRE69qsgIi3P6A42m8LNH
 HGrntcDWNfeqNwNDR4wRuxM=
X-Google-Smtp-Source: ALg8bN7YE+bPCsEF6zRIwsShrpUAZIueHQ2KAFb4fOzxweLzlSCbHbZrB8/PRrputEX6DLtFQp2qqA==
X-Received: by 2002:a63:e40c:: with SMTP id a12mr12404213pgi.28.1545657287533; 
 Mon, 24 Dec 2018 05:14:47 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
 by smtp.gmail.com with ESMTPSA id q1sm49507262pgs.14.2018.12.24.05.14.44
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 05:14:46 -0800 (PST)
Date: Mon, 24 Dec 2018 18:48:41 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
 sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com,
 stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de,
 airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org,
 pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
 boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v5 0/9] Use vm_insert_range
Message-ID: <20181224131841.GA22017@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_051458_758927_B2E26F63 
X-CRM114-Status: UNSURE (   7.56  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

v1 -> v2:
        Address review comment on mm/memory.c. Add EXPORT_SYMBOL
        for vm_insert_range and corrected the documentation part
        for this API.

        In drivers/gpu/drm/xen/xen_drm_front_gem.c, replace err
        with ret as suggested.

        In drivers/iommu/dma-iommu.c, handle the scenario of partial
        mmap() of large buffer by passing *pages + vma->vm_pgoff* to
        vm_insert_range().

v2 -> v3:
        Declaration of vm_insert_range() moved to include/linux/mm.h

v3 -> v4:
	Address review comments.

	In mm/memory.c. Added error check.

	In arch/arm/mm/dma-mapping.c, remove part of error check as the
	similar is checked inside vm_insert_range.

	In rockchip/rockchip_drm_gem.c, vma->vm_pgoff is respected as
	this might be passed as non zero value considering partial
	mapping of large buffer.

	In iommu/dma-iommu.c, count is modifed as (count - vma->vm_pgoff)
	to handle partial mapping scenario in v2.

v4 -> v5:
	Address review comment on [2/9] and [4/9]

	In arch/arm/mm/dma-mapping.c, added the error check which was removed
	in v4, as without those error check we might end up overrun the page
	array.

	In rockchip/rockchip_drm_gem.c, added error check which was removed in
	v1, as without this it might overrun page array. Adjusted page_count
	parameter before passing it to vm_insert_range().

Souptick Joarder (9):
  mm: Introduce new vm_insert_range API
  arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
  drivers/firewire/core-iso.c: Convert to use vm_insert_range
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
  drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
  iommu/dma-iommu.c: Convert to use vm_insert_range
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
  xen/gntdev.c: Convert to use vm_insert_range
  xen/privcmd-buf.c: Convert to use vm_insert_range

 arch/arm/mm/dma-mapping.c                         | 18 ++++------
 drivers/firewire/core-iso.c                       | 15 ++-------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 14 ++------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 ++++-------
 drivers/iommu/dma-iommu.c                         | 13 ++-----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++---------
 drivers/xen/gntdev.c                              | 11 +++---
 drivers/xen/privcmd-buf.c                         |  8 ++---
 include/linux/mm.h                                |  2 ++
 mm/memory.c                                       | 41 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 ++++
 11 files changed, 83 insertions(+), 89 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
