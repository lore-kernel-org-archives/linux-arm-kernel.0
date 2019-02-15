Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8222AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:36:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5392D21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qvqE5tP9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CknEENK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5392D21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OYIdWn9Df+MyZfujvIwAkRLBDaUwpgSwiAlne0bEaBk=; b=qvqE5tP9sl0qeS
	BmKgvWi+XTVOivNbPPou8Kt9bqDFEcMLJ8B5Ji+EP/+WIcQ90J7NqiKqhPSNNu2PgQnzmiMFFm8of
	WGE7iLzOzy7zlTG5wlxNGdgMzUnQq49Qq1Gd9z7jea4LsZQDDxhEB0pXtQjNql1B07WL7P0YuWSXr
	H0dxzVSck6l9xLPNHCQMN5dUnOOnZnzPwy2ln2GtnF+HNwlqqGU9AwqU8ZZl5ihiHgpAj8vnruuQ0
	behdGNeT/tM+W4+ZUw8nHKAKNW9NtN2ebptL5qBU3WTtcVZiMfsKuU2lHr5oUxNdrKapzhngCCnFZ
	P6Xdd7PMreD6nNh8TuOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guTN1-0004Zm-Eh; Fri, 15 Feb 2019 02:36:55 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guTMx-0004Z2-Ku; Fri, 15 Feb 2019 02:36:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id g6so4074338pfh.13;
 Thu, 14 Feb 2019 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=ybJ6FRmizCH+Ysla/KYM0KU4CJcaZTaDUg0Dc25IXgc=;
 b=CknEENK4WWQ15y3wJPfIxhUzIaUUiVppnBDGCGYaHDjVrtgl0kyqkNGqsjGZvo+yVL
 d4sh6wqoe+z/JuZevryqfNRHbo9vH2xm13dggmJG78gI3QkLRRoQvPJvUO5NGBv2qsb6
 1mxG6i+IgqvE8AQdCpqd15C0+yqMcgVFcU8mCPdE0SdXGCSLfuyRINJeS8SyxIgOCMU6
 jpkV7ZqePbD0McFyHLHqfNjptby50fXpYVBmGptpQJYIXjF4d22rudV9nc0PELTXp4AR
 Ei5KrURLyx69ritVapzRYgIFX+mYJ/EejNawVddqxsBS+Wht7f5qAQSdVHAnhrs8Cgjb
 LNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=ybJ6FRmizCH+Ysla/KYM0KU4CJcaZTaDUg0Dc25IXgc=;
 b=cSrT7hv8Y59zjouHEYc/l9TtK0fw8xogkFvVmNEKZto04hwSK3fSJHYBimWKrKw3Oi
 LUrHXZoVFwVhjTNAXfjuY2abDtvfe+7OKCVggFldp553t5vssP8gjPsOmZ0JW1N5rT2w
 6kmD08M8+La/948jm5MAE5LkaY/Mo2mJAftuhKSq33zn+HfTfsi6Mm724MbCVY1/RkQj
 Tv4AyJQiRsOE+VaaQndvg6ZWo4Qj0GXE8XLfLxwlGXWIbK4tUGW1RU2lN5qOw985gLDO
 3YYRSXZyTIYFopwRxT2mQdUSuxTS96Aq5LfXpRzeftspC/UuqU/wSyj5ehOJlTWkH2yf
 5nlA==
X-Gm-Message-State: AHQUAub+JLy3DMXmakXjQAQ3MqJIgwhFWfQIN2GwVPkT3pIAg/7j1mMP
 U18Ch/VToPeJaG53SAmuGDM=
X-Google-Smtp-Source: AHgI3IYtCM+dhZI2FfJRnUme1duZ/3d7ZuNv03wmI45ynR22iAVUN9tbmQqTQ2AjvRjC5MO6GHyrEA==
X-Received: by 2002:a65:6149:: with SMTP id o9mr3081509pgv.315.1550198210461; 
 Thu, 14 Feb 2019 18:36:50 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
 by smtp.gmail.com with ESMTPSA id i8sm8817908pfj.18.2019.02.14.18.36.48
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 18:36:49 -0800 (PST)
Date: Fri, 15 Feb 2019 08:11:05 +0530
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
Subject: [PATCH v4 0/9] mm: Use vm_map_pages() and vm_map_pages_zero() API
Message-ID: <20190215024104.GA26331@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_183651_713439_6417C341 
X-CRM114-Status: GOOD (  12.41  )
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

v3 -> v4:
	Fixed build warnings on patch [8/9] reported by kbuild test robot.

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
 drivers/xen/gntdev.c                               | 11 ++-
 drivers/xen/privcmd-buf.c                          |  8 +--
 include/linux/mm.h                                 |  4 ++
 mm/memory.c                                        | 81 ++++++++++++++++++++++
 mm/nommu.c                                         | 14 ++++
 13 files changed, 134 insertions(+), 103 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
