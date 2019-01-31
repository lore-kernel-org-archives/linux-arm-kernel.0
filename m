Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD2C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:02:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D5A218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWGOi63s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLK1mCiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D5A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VdF/xrBx545JEyoEqaDwi3p8Wk2FCRUMt/amNJ7K/7A=; b=JWGOi63sCEOOJ6
	ZS+8/DM44Ok7XYduphSt8kRLc5BPDVKZQi7krFSZA1JHohZUKIZab122dkiDU149ZVKRgb5Nn2LZZ
	zXXjB0YokAl66JvHVbvHN74yg7MF1YOjF7LDcl63Q34Dph5Ve/URARu/NSa5nQDn+8lUZPgKvw/S2
	80Kq9uppUr943t+IuLdnYPTKyFPyLwjjPiNzK0LuLp0El+dxhuwW/3+m38bppYvCuJ9eTxCLTJYkM
	JCzqGreOVvncAkFKyoOoPmuhqVjY3sgps83lwZkuUxAI/1FDhuNDbEvPKpwhC5JSJfqdTUVRr9WFh
	TcapsrXGSOnSskPTxpAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2cS-0000oM-2s; Thu, 31 Jan 2019 03:02:24 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2cO-0000na-K4; Thu, 31 Jan 2019 03:02:22 +0000
Received: by mail-pf1-x443.google.com with SMTP id g62so779237pfd.12;
 Wed, 30 Jan 2019 19:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=21JlOZW7w0wGlQ1y8Y5t+ZogP9kpInVIgyeEdo29DZ4=;
 b=HLK1mCiE4dJ18NQVGULIPA8PiIQBws4yp45iUs2ySQEmrEgnAA/9srUZ4RyfZUPVBB
 1cO4YvLYxzKXCmtPQoWx9SlL7yM0nsYjzuAK+jUZJ41cXH/n/cajKPwrrtNroCLCvT+L
 gTlfXkP3sBrFbRX37yKy7ueR/aRnJQrJqkNWKTBFaSSn2y8edx5+l4K0+qZdTPiYk6rD
 DvAjFufGk5qn1qxwiwg5doR0KJWOlGK5OKTVMAYnWPER++voTOoBPAEyvk2B8hiJrJvb
 LctK6KjtdAlhs8txfTflbU+KWxPwpg/vlLc3M5LbIRWqlzewm8SPIu8ueDJef3Mq4tGC
 zMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=21JlOZW7w0wGlQ1y8Y5t+ZogP9kpInVIgyeEdo29DZ4=;
 b=o/L5AkHFG28K5bbxRE/xWlWXwF/yDczR6M/pVbhQN7WanUgCbOpPh0DyglxOUA2YD9
 RbzV6/Ybq3DxW6H5s6ThNCQQdCTTbpozv2zFcK6r64dUCNaRacdd4EC3e+eycTiSXTIL
 5mBgHHg+ZJLVrhYvYHcy3W1VkqmCaJzuVwkAkdadxAOWqoELe8JVMfGhOWyP6W0rsWuC
 SsGR83dY/KDBLLLA5uZGlrswzP60aTEng4rZMxpG3bTIlnNMU5oRk8grhoKo1boVngi/
 i989irW9g+4q8Fnw3aJBovpzUSCKMB7RnweZmYGS+2l5WebrQJQxXcfkROolCQLxHSzJ
 iy1A==
X-Gm-Message-State: AJcUukfZtE5la8F+ectgq+ow3rfQycomDBznWocmXEo/tvbAENZxQCl9
 tFONzWlSeLll2opMgWefdQpjCEXO
X-Google-Smtp-Source: ALg8bN5clhF3QoFQslXO5sN+wDZpJqdy7zBe18sX7y+qjCHp8D9i5kDDQHTQn9V7rPsgCAs2+L0urQ==
X-Received: by 2002:a62:4181:: with SMTP id g1mr33008551pfd.45.1548903739568; 
 Wed, 30 Jan 2019 19:02:19 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
 by smtp.gmail.com with ESMTPSA id h128sm4118706pgc.15.2019.01.30.19.02.17
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 19:02:18 -0800 (PST)
Date: Thu, 31 Jan 2019 08:36:31 +0530
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
Subject: [PATCHv2 0/9] Use vm_insert_range and vm_insert_range_buggy
Message-ID: <20190131030631.GA1868@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_190220_681864_C4A5C815 
X-CRM114-Status: GOOD (  10.32  )
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

vm_insert_range() is the API which could be used to mapped
kernel memory/pages in drivers which has considered vm_pgoff

vm_insert_range_buggy() is the API which could be used to map
range of kernel memory/pages in drivers which has not considered
vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

We _could_ then at a later "fix" these drivers which are using
vm_insert_range_buggy() to behave according to the normal vm_pgoff
offsetting simply by removing the _buggy suffix on the function
name and if that causes regressions, it gives us an easy way to revert.

v1 -> v2:
	Few Reviewed-by.

        Updated the change log in [8/9]

	In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
	to select a buffer, not as a in-buffer offset by design
	and it always want to mmap a whole buffer from its beginning.
	Added additional changes after discussing with Marek and
	vm_insert_range could be used instead of vm_insert_range_buggy.

Souptick Joarder (9):
  mm: Introduce new vm_insert_range and vm_insert_range_buggy API
  arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
  drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
  drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
  iommu/dma-iommu.c: Convert to use vm_insert_range
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
  xen/gntdev.c: Convert to use vm_insert_range
  xen/privcmd-buf.c: Convert to use vm_insert_range_buggy

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
