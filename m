Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015DC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CA6222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWQBZ7xg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo+rn4+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CA6222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hMXss1BJ998sRWl1ZM8zDXmds7Wt0hgTyuz0BYQm+lQ=; b=EWQBZ7xgbmO1cQ
	Vkd3M2RhKFcrcUtvq2CEdQSkXy2LzsXFJ6PuBV5k+DC8/ZeQwKmenZDLZog3K5v4yAFEC7Ot57Cn2
	rSs85Rug8K6lpbUz3ErJd9yguSDZMbdanSJzM2Ci19/bkvviPPuP3NsBnLvHeqz2ReFJ4JzO0hatU
	co8qnnc13E+5Tae/fPk7MhMowY++DHFvy6TGDQfwj9bGBxOHcwRw90IRM1NTlIagwYrVO++EazKtb
	fjwzUaej8iQYOYNWlLOZWg05uhur2bRTd6kgq6KpmxOzYeDTzTJM24i2osz1aKNSX39CFY2rW/Wid
	gbEbBUcy8IsQig7QZ3yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtv1T-0004zg-VC; Wed, 13 Feb 2019 13:56:23 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtv1P-0004yX-N8; Wed, 13 Feb 2019 13:56:21 +0000
Received: by mail-pl1-x643.google.com with SMTP id s1so1191232plp.9;
 Wed, 13 Feb 2019 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=V2qFA0OcwjrK68risolzFdRV/D9+52UF5C3nMIQDVp4=;
 b=Wo+rn4+rpbWNXMXw8f961P6oxr28SV0R3AE2+Iuvqh7fxEkblbcFpBrThrdGUZASMo
 +obY5tWBT5FcDq1TCc2YALzjSj/RwS62oxijXHr27AMGgQQ5EAXv7KDXIR8qS+CriIzl
 v+ii3rGwru5TZogwAVIdxKFZ3HcsQXSMp2qyjqUotAp7B0lv2662QZR8uNlKx7/r97Wt
 Q1kF7Xrwhfuo0ODVWB5AEbZlo/SYZi2B7iswqgis9OVmaodYPCQ5gXnYca7KlKSYKhWN
 qJ16mA6TwoJHT3BVnzle1LT/35tmCVTvOSmsrJwpZE+NSxRv6QEEiAd7//aDbrQIA0zS
 /cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=V2qFA0OcwjrK68risolzFdRV/D9+52UF5C3nMIQDVp4=;
 b=XyX8iA4AjeslnQaML4NNra0xYOuJLovWEeo7onpWPvnDk+Mwo9N1SVeC8gKHyD7dUy
 DC8H+21yqmSaHbqdIPbUpjag0vNeAierwR9owRoS9PXSbq8JUxNjWif9e3bWzEug+QXG
 gSNzNdpSdk+7b0QA4NodLeFxQn7yCMFqRVaWsxBFYwHMLHKyb+bWXsG3V2IBVP9J0pfa
 t9i1HTdHGldeQ5pPqLtXshCRhoBZutMD78i1nb6pbQjmPS885lc5kH5tANvoiFHMg+/A
 YEc6D/OkI3u7FdJxhUoXUok+bQXpttKsAqzv78CIXs6IiLU4WyK4JK+GFWaoXRGpC8rv
 oZfA==
X-Gm-Message-State: AHQUAuYqAsJYER08kILe2x+qhe3Twgkm1hUjNpfT+DofooVil+s2s5n9
 2cb5Nfit015t37bMQVRjDxg=
X-Google-Smtp-Source: AHgI3IZ+SXZkfuwQeWGM2fq41k8bLY3tiDCzMWyTKTaAYfDA8NidP+PtWIWRFYBlC0duiJnXDlxZqA==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr683223plb.306.1550066178456; 
 Wed, 13 Feb 2019 05:56:18 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
 by smtp.gmail.com with ESMTPSA id y20sm26266582pfd.161.2019.02.13.05.56.16
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:56:17 -0800 (PST)
Date: Wed, 13 Feb 2019 19:30:35 +0530
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
Subject: [PATCH v3 0/9] mm: Use vm_map_pages() and vm_map_pages_zero() API
Message-ID: <20190213140035.GA21935@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_055619_774620_82AA4A1B 
X-CRM114-Status: GOOD (  12.37  )
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
be generalized by creating new functions and use it across
the drivers.

vm_map_pages() is the API which could be used to map
kernel memory/pages in drivers which has considered vm_pgoff.

vm_map_pages_zero() is the API which could be used to map
range of kernel memory/pages in drivers which has not considered
vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

We _could_ then at a later "fix" these drivers which are using
vm_map_pages_zero() to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function
name and if that causes regressions, it gives us an easy way to revert.

Tested on Rockchip hardware and display is working fine, including talking
to Lima via prime.

v1 -> v2:
        Few Reviewed-by.

        Updated the change log in [8/9]

        In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
        to select a buffer, not as a in-buffer offset by design
        and it always want to mmap a whole buffer from its beginning.
        Added additional changes after discussing with Marek and
        vm_map_pages() could be used instead of vm_map_pages_zero().

v2 -> v3:
        Corrected the documentation as per review comment.

        As suggested in v2, renaming the interfaces to -
        *vm_insert_range() -> vm_map_pages()* and
        *vm_insert_range_buggy() -> vm_map_pages_zero()*.
        As the interface is renamed, modified the code accordingly,
        updated the change logs and modified the subject lines to use the
        new interfaces. There is no other change apart from renaming and
        using the new interface.

	Patch[1/9] & [4/9], Tested on Rockchip hardware.

Souptick Joarder (9):
  mm: Introduce new vm_map_pages() and vm_map_pages_zero() API
  arm: mm: dma-mapping: Convert to use vm_map_pages()
  drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
  drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
  iommu/dma-iommu.c: Convert to use vm_map_pages()
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_map_pages()
  xen/gntdev.c: Convert to use vm_map_pages()
  xen/privcmd-buf.c: Convert to use vm_map_pages_zero()

 arch/arm/mm/dma-mapping.c                          | 22 ++----
 drivers/firewire/core-iso.c                        | 15 +---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
 drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
 drivers/iommu/dma-iommu.c                          | 12 +---
 drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
 .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
 drivers/xen/gntdev.c                               | 16 ++---
 drivers/xen/privcmd-buf.c                          |  8 +--
 include/linux/mm.h                                 |  4 ++
 mm/memory.c                                        | 81 ++++++++++++++++++++++
 mm/nommu.c                                         | 14 ++++
 13 files changed, 136 insertions(+), 106 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
