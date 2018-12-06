Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45444C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:34:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52AD208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P7r32hvw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="davkmg1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ieDM+1SUDyRnbYUHIpnWXhFaPlfBn24xctRWpsf95oc=; b=P7r32hvwocABKj
	w126kWJQQdJvKGx+Mtw+RyfvLFOEsTdl6vydx70T9y8qtv1pZSJKMxrdrr8BTDjkHX7kosuzDk/or
	aYaCKzBpD6+HqnQuz1PemDU8brIzeaBFtlDcPGr06x9ghDCWgvRWeGdl7AxoDZgMIx1r3dOUtB1ww
	Ewi+SYNFkpibzvqfa20UzDDZd+BHKKg+3BbagWWs4dafIo4Tyrq/3AvrWv77ynNeY4Bx19cba7aHq
	u2d/mFQeyoMnY3DRha/zRyw3yKP9NgWPIayzXAKLfTdWzIut1KMWbEKU5pLtzRA3rQWZVkC20azj9
	JnSkISEPn+1dX8WuOCEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyTL-0001Z6-CI; Thu, 06 Dec 2018 18:34:03 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyTH-0001Y8-Mr; Thu, 06 Dec 2018 18:34:01 +0000
Received: by mail-pl1-x641.google.com with SMTP id t13so539967ply.13;
 Thu, 06 Dec 2018 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=//xM5ckHQpjH8DRY7QjxQr9OahBeTL/2OYhSA/2ZlVM=;
 b=davkmg1rht5+CKYgw8LgltjJ8cvgRpcvOtjPkNdysxNTmHbV7OvchtIoVQymYDgKTz
 ZQuAz513k8SnYKXR4Bd3jxCfrxiBLQFcHMpmTADwHEyZ5v3h6mKWIWpro9HOf/FhdhIO
 pq4A04jwaORyVvTOXpgO/5jxEBR/QNHfHJo38BYfiMw+CuQvRyUdois//LrihhvKbkUC
 IwbNje16unuPJk5Iy+JnYzEmgRIP3vzqLH+2EBbhZYK0rPgXANen8CrSLHkgl2GabRvE
 JWEntG18tba6aGPTFpcj4sfRCohVeAKRRalaqTEow7MOE778mEZF+co4fXCA/Ie1LAH4
 m62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=//xM5ckHQpjH8DRY7QjxQr9OahBeTL/2OYhSA/2ZlVM=;
 b=C+caqZMASGXX3xl4C8j3LLs8wCZMpC3Ni8GGX8qPKKIswI+aewHx1Tb+n3jZeOm/t1
 /AJSosfn1sdodYQJ4H244dYOj1JaOF/hBqEDMtdwZ0t6rKOfZOmEShK73rawmgxMMZia
 cX9SPE+D5yH59Aw7eI1tUpcSIaQHqsjt+7wzo9cRLxxoeD4rXCpyGWU+Ug7PAvDVsQI4
 hbDcYQrDPfLONcf1g51ZjgFNViTsNBvL7vMisDRnNG1FPVH7BDXjKkX5ekfa1N/t1ypP
 Dh6Gb9f/p+9wa7G3THDXieQKvzpvffwg1TqHy8QnOYY5QxwcNd9H5igdvTFWiseWLogd
 K0FA==
X-Gm-Message-State: AA+aEWbmyu/to/L+K1bpapDvdQm2xjjsH91s71ydf4ztymQBa7tceAKE
 p1J1cfSANXxJtjsgrANzZ2U=
X-Google-Smtp-Source: AFSGD/WNnGiapTEJ46Ed5/Z/wawNX1AN/JF1DLHSpN0c5ocfxsOQRaK395FOtJYxrGm5y2+oYNYISQ==
X-Received: by 2002:a17:902:e10a:: with SMTP id
 cc10mr14834670plb.165.1544121228581; 
 Thu, 06 Dec 2018 10:33:48 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
 by smtp.gmail.com with ESMTPSA id g65sm5281319pfa.63.2018.12.06.10.33.45
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 10:33:46 -0800 (PST)
Date: Fri, 7 Dec 2018 00:07:33 +0530
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
Subject: [PATCH v3 0/9] Use vm_insert_range
Message-ID: <20181206183733.GA17240@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_103359_771129_8FB8AECF 
X-CRM114-Status: UNSURE (   9.14  )
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
 include/linux/mm.h                                |  2 ++
 mm/memory.c                                       | 38 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 +++++
 11 files changed, 80 insertions(+), 98 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
