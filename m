Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BEE20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eI1yAtRt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcVfzmJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BEE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Brd1fqQJCehMVVg/NH5497DS9uXvI7wmOigq1YTkxUA=; b=eI1yAtRtY/WQsd
	OlkvUwXdlLBx4FnYaQPbg40TzJjYAR7MqdmJE6QlMdZnaivik4ZyN7KvZK0M5LPjczrX1ZSOyoA3O
	Fs9sM0CE9KADCDuqMePRxueBT16XUlzb4MrAAwD7CPk1ESdk5mp0CyGJgqNVQsUk4bYlEoRxmydeX
	mkJtgHn9dt8TYSWzPW6Po2WUUkItl3nCI9YaR16v2pvbH7AaNpWnm25EWAuzS5DdaHqo9zkOEjU7q
	2+If4pYK4vcoHCTJt4MeqPK5h5se2VVLDq0puCVOtrXNkQqN9DSETC+9QzW8DSQpUCt2OLtNQVmvo
	QXe1p2YInIEUMthMdM9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV9Ra-0006ML-Ed; Fri, 07 Dec 2018 06:16:58 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV9RW-0006Ks-GF
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 06:16:56 +0000
Received: by mail-pl1-x643.google.com with SMTP id 101so1342774pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0c5TwVzNQByEy77pUWPEdeXOYrHk4jt+G/hzOekHJCQ=;
 b=PcVfzmJqil1ER6ETqQmWE3iKBzMtkyDLcVLJipUgki9aPhKVan32hAkinPkqxMqDJn
 qR2i80l2WEe77rk9hqvk28wVkOK9yJ9JZGEUSF2nE3Y+dwvn+fsPRfjaCWSAmHYMpi9l
 UPwhuK69lFsLO/BkvtANeKTheYzMjEEjsK3YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0c5TwVzNQByEy77pUWPEdeXOYrHk4jt+G/hzOekHJCQ=;
 b=j0ml2ynQ0ddY/HWamq6EQMgC0Wle9S+T+xrmC9a0FdtfQNmua5F9N/7xLkoB4eUP8h
 bOV4mE9JmN1jjKnJ0NbZJFRTMaAwDYses+1ukDN0MXKjD+vXOEpZEQHErGwIoWXCsJtj
 I+MK+YMzd9raQxOSjgGbK3NIT2jYZCYsDkXqaj/VPTk53hNpnCNzw1qhiQiKc6V1xFIb
 u0rJOIgNcK6HSTvlY38vmxkSVgFGtyz9ZvtrhNOU5RNoazqjkDohYjMgKxHm2zawDmqz
 3aBc4yPt1tOyrvu1VChbOlnhLFYYhrMB4wGNw/N0sSfC8OrzAbZylFaXEpgJRCwmhWAH
 m/6Q==
X-Gm-Message-State: AA+aEWbSRlV66E1LOFsz5wkrjtSWcPvSDfWW902qbTIF2Et2PuIOtTAx
 NwRK1hPJqWuUa49+bwvXT9KpD5NA0LOZow==
X-Google-Smtp-Source: AFSGD/X68YoSqVEGI1CVXHS7YbOnx86KMdmPwJZrPG/RK8TbxmXYI1s8ov2wAQa5mffy8bTb2sKMEA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id
 o12mr952993plk.291.1544163403311; 
 Thu, 06 Dec 2018 22:16:43 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id z30-v6sm2995944pfg.41.2018.12.06.22.16.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 22:16:42 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v5 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Fri,  7 Dec 2018 14:16:17 +0800
Message-Id: <20181207061620.107881-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_221654_538256_C3DF0F5D 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org, linux-arm-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is a follow-up to the discussion in [1], [2].

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For L1 tables that are bigger than a page, we can just use __get_free_pages
with GFP_DMA32 (on arm64 systems only, arm would still use GFP_DMA).

For L2 tables that only take 1KB, it would be a waste to allocate a full
page, so we considered 3 approaches:
 1. This series, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2 page
    tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable to reuse
    freed fragments until the whole page is freed. [3]

This series is the most memory-efficient approach.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031696.html
[3] https://patchwork.codeaurora.org/patch/671639/

Changes since v1:
 - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
 - iommu/io-pgtable-arm-v7s (patch 3):
   - Changed approach to use SLAB_CACHE_DMA32 added by the previous
     commit.
   - Use DMA or DMA32 depending on the architecture (DMA for arm,
     DMA32 for arm64).

Changes since v2:
 - Reworded and expanded commit messages
 - Added cache_dma32 documentation in PATCH 2/3.

v3 used the page_frag approach, see [3].

Changes since v4:
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH v4 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH v5 3/3, so that maintainer can decide whether
   to pick the change independently.

Nicolas Boichat (3):
  mm: Add support for kmem caches in DMA32 zone
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
  mm: Add /sys/kernel/slab/cache/cache_dma32

 Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 drivers/iommu/io-pgtable-arm-v7s.c          | 19 +++++++++++++++----
 include/linux/slab.h                        |  2 ++
 mm/slab.c                                   |  2 ++
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 16 ++++++++++++++++
 tools/vm/slabinfo.c                         |  7 ++++++-
 8 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
