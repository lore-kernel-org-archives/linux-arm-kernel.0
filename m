Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3AC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BCC20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8xHm0TA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/tndmL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BCC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WyV5Bri2r8vQ5pgmKk/UOXeNbu8gBJK6WPTNrQY+TeI=; b=W8xHm0TAaV3E12
	q15JWYALMv17/AglwTGYJjeH655EvTZP/FKJG0+sLrgGbfPA1Qi2DwA1QbvE7zvDOSsyn840MJSEh
	UZ5nP/GDK1aMIM1ATi/X2AYI2K24Dplmb4E9elTXMYPijjDjP1mUIHd/CeVUVlAmU7usTB0lsAQPK
	GvOoU+jRIxmiBwlRVLnhLgttuhGpiEVbxrwiAnY8hiouoG8GWoVsS02KQnSO+AkvM0oeSDcqgtUar
	QkPkqwn+eckE0zHNpxnshGvBi83dMtcIed6aB6BiovZUwgFPFf2EfKEV8uL97lDJ7hnxbtxcERHNq
	1ibDLD1HM/ZgIVa4b/qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTL0f-0008Lm-1t; Sun, 02 Dec 2018 06:13:41 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTL0a-0008Kd-Qh; Sun, 02 Dec 2018 06:13:38 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so4266402pgp.13;
 Sat, 01 Dec 2018 22:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=QkWGefk1uOV7uhsAtF573lEHHJSsrTRZEoJ/EEqbupA=;
 b=M/tndmL+7unpD7Cz+MMnYUMmmLKKNQl2BcHQL30JGC2EvipOkXmc7nP92Ecrfl8h+j
 nPudgrN4aT+LEP6HoeYYSZr/o7m3KVuiIv8x7vDJqnzHd9shZNkfBUeDVPPBncdU8F/p
 oTA9DYBsya674xroQ9+qG49yr/zZ/k5vxL/QJUwE7Bg0XVW53OCRmpTLPny662uFmuic
 8B4+FQF4OlxnAVuwkhb96Sm25HTS1UsMqufynVfnoz24ZZvhF/ROhv5TxeaNYetXD+sF
 zK/2UojyJVWVHGae0s8Qclnm/vtcbyXp2swTYWdf9EdnUZCyyxpn44GxcU7K3iQD6Uwl
 6paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=QkWGefk1uOV7uhsAtF573lEHHJSsrTRZEoJ/EEqbupA=;
 b=SiyKp0LytDSMIm7Evok7ofAIF2LbHYJdkjIlnE1xJeLC/WNTBT4rtLYg0roERqzoyM
 20/M044QDKUFFPH55Up9wIwEMKAbNqRa+Hwf+lbOu7tuqpbik2i9g44Re60ayZzR1jeU
 T/7B6tH1/eSgfktBVCKC9wnbiVnx5jYIJZBIZD/2qMHWByquqnTPi29YYibfPjWgs2ME
 R3UjnKDrShM1AHbTDOP5vb5A70UlC2t00pa2BXhUTTiFEUKQGJhlN89Dd4BRi9PsjtR7
 KdHFQK3cMT0Pdgj9M+1rouoOJiNGpY35ZpS+TpEHoOl8jDFL8rF6EUc3GfKYtnUZBNYd
 QzbQ==
X-Gm-Message-State: AA+aEWZrazM8iSaTOiVgWQKNvliz+AAslttktaR94+CvQOSLFxnYmn+4
 hvbqOAXJ6f2NfX3oGe+ityU=
X-Google-Smtp-Source: AFSGD/VadVkIzzhs3ZrvwCPB7PLdPaDENychA8ssT0abv5PurP9XiiGYd+5YwEv4HTNWB3Yc/RO8mQ==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr11586637pfl.196.1543731204982; 
 Sat, 01 Dec 2018 22:13:24 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
 by smtp.gmail.com with ESMTPSA id d80sm33964454pfm.146.2018.12.01.22.13.22
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 22:13:23 -0800 (PST)
Date: Sun, 2 Dec 2018 11:47:07 +0530
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
Subject: [PATCH v2 0/9] Use vm_insert_range
Message-ID: <20181202061707.GA3070@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_221336_909288_64DF0558 
X-CRM114-Status: UNSURE (   9.00  )
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

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating a new function and use it across
the drivers.

vm_insert_range is the new API which will be used to map a
range of kernel memory/pages to user vma.

All the applicable places are converted to use new vm_insert_range
in this patch series.

v1 -> v2:
	Address review comment on mm/memory.c. Add EXPORT_SYMBOL
	for vm_insert_range and corrected the documentation part
	for this API.

	In drivers/gpu/drm/xen/xen_drm_front_gem.c, replace err
	with ret as suggested.

	In drivers/iommu/dma-iommu.c, handle the scenario of partial
	mmap() of large buffer by passing *pages + vma->vm_pgoff* to
	vm_insert_range().

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

 arch/arm/mm/dma-mapping.c                         | 21 +++++--------
 drivers/firewire/core-iso.c                       | 15 ++-------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++----------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 ++++--------
 drivers/iommu/dma-iommu.c                         | 13 ++------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 +++++---------
 drivers/xen/gntdev.c                              | 11 +++----
 drivers/xen/privcmd-buf.c                         |  8 ++---
 include/linux/mm_types.h                          |  3 ++
 mm/memory.c                                       | 38 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 +++++
 11 files changed, 81 insertions(+), 98 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
