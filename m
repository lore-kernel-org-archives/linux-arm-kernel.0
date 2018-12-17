Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6722C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:16:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9184C206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BmHAs1yk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGyPRsWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+woTrFgKw8Ln/cNGYVLRL+DH5lPvDSH95laIZw8f7bw=; b=BmHAs1ykTXuW0N
	iMs+rETeguoCvcoKa851OiHnL4BDNR5MD2586eFXCbl5Wu09P+RursXV8tPF3K9GwXqA6ICgMqvjN
	ISer2oBylqjeS3Jvg+mRw7JjVGEzeVT5y1dcLy1CHbSF27g5xAGPyccVgMjLIeNtMpHs9UpwS2iyC
	eLJPS9hBkJ5Mlyb7G0Vhzbra8gcky6TNzrxc8ZgyDyCVP1+VqmK486y8zzkc+S+0lL4fwOkS5sOGH
	3EV9b8LLbYbdJ3pefqd9EiqmzfKGXi67HJN16hmfnTt7yLd60sk9m4do7IqxZxvqwx9HnPH+ziQIS
	QCuIbzQ4ipwRAuEAE22w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzJ9-000609-1W; Mon, 17 Dec 2018 20:16:07 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzJ4-0005yS-Nz; Mon, 17 Dec 2018 20:16:04 +0000
Received: by mail-pl1-x644.google.com with SMTP id p8so6662545plo.2;
 Mon, 17 Dec 2018 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=3vyqNF2AY3a98If6IXFQYuTsTHWXYSwI0xNLA0HcJhQ=;
 b=fGyPRsWDJn6Kj0Fg0NK2CHb8lm2wpyJMPu69HAivJuYK13NTR/Fm7RG4BGWJRgANwN
 gqRaCCrlzg1HzxTnTO+mVE35R6zDT9HfArCP2PgcSIIpHCoVIQXu08QiSoaPOq4Kr/1H
 S4zhEkJ18wFGfdMipkVsQB9Q0iqB+paWWQ3FAQqCuZF4g9XpwJqNutc5OkaNi/21rzn7
 Z9h7IMPC7m2mUXOUlD5FxSEBkCRbYJfkPWwLwC7KVn+bOEBPWF47xpQVjstuw1u3EbnK
 4lUBPSqwiu4dYr91tYfWcSXSsKiowwIsgen2M8nfGYTCk8AN+KF9diFAXrSa0zOu7MON
 BkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=3vyqNF2AY3a98If6IXFQYuTsTHWXYSwI0xNLA0HcJhQ=;
 b=MA1gXk2TSXL7FGyCou8KYLMov2Dz5B3I+PSBpIyTlvC/P97r5HNU2w1vTxDbQCwfS8
 dFKBZy5u9gA8sjdo9Qhen7Eug/rcByTRbdhlmEPvcRYL/RpXXoCOOObBS83GYS6MWoeF
 fgVDmu57J7mjJ+ffIJhsm0llPDs5BV5s2Gtm1P2RegW295PK3mN6SV6P3P5aE4Xxx1hA
 PKMvXMT3KQo2EBK/o3Oju1G7dpqHFHTWQX92TX1Kl8AYQK5k0+8Jssb2XN76VkrB4Rtc
 /KuiNtNPsfeQv0cV7y7DkAr0spRBehv4Lmsp/TPBGYWV5qknfwD+tebmUqLxT4v6Izhi
 OhSw==
X-Gm-Message-State: AA+aEWY1yqkm9FoFYWGwVbZgJgYXhv99LbtRt1kalOmg8rezTB7J7B1o
 VG4haJzuBNMDNK1tCqjja6g=
X-Google-Smtp-Source: AFSGD/UwgNW1q7B1Tl/WOz2n048Sng10rkAssfluJ7vJAib6KbxfmhOWdEj5Pb0Em8FBTBItR70xVw==
X-Received: by 2002:a17:902:bd86:: with SMTP id
 q6mr13486898pls.16.1545077751326; 
 Mon, 17 Dec 2018 12:15:51 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
 by smtp.gmail.com with ESMTPSA id b68sm21569889pfg.160.2018.12.17.12.15.49
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 12:15:50 -0800 (PST)
Date: Tue, 18 Dec 2018 01:49:42 +0530
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
Subject: [PATCH v4 0/9] Use vm_insert_range
Message-ID: <20181217201942.GA31335@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_121602_782543_1F7D67FE 
X-CRM114-Status: UNSURE (   9.86  )
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

 arch/arm/mm/dma-mapping.c                         | 21 ++++--------
 drivers/firewire/core-iso.c                       | 15 ++-------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 19 ++---------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 ++++-------
 drivers/iommu/dma-iommu.c                         | 13 ++-----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++---------
 drivers/xen/gntdev.c                              | 11 +++---
 drivers/xen/privcmd-buf.c                         |  8 ++---
 include/linux/mm.h                                |  2 ++
 mm/memory.c                                       | 41 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 ++++
 11 files changed, 83 insertions(+), 97 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
