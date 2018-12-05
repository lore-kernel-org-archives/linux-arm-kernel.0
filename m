Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8982C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD6E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sEn4nFAq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLarozb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD6E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9F/LLg7RllnYmO/ugCwdGrud92zmLkMT1jkv00PwpCE=; b=sEn4nFAqJVGd6q
	TN5m1UUaDIi28bqDw2Nm9EyehO1bgwinnxYBi5SOKuIVy6FgN/YeaZEZTxKHM9yPPm90Gh1xkE1c/
	5rBMKTTpYFT6spHO6WDxg/So/r5ePg7dvaZE2W5adAitzeaNn+yOzoRihAlgutpoHH/gPPtGmEHhM
	BpV2MreFQkdKLNwa83zrCKxNMcLe1XI8VriWkmqv4dfqU8veT4icZ8QbJ5rUh5JnmRm+EIFUgFLgF
	TW0TvQWCEISatgYwsGL5ARWhD6xulrT/pi9pgCxjXou03fzZb0VUqznHpNoqYyZY4cyeNBEzYllcT
	AgKe1m5sClhvo15YRrzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQ3S-000672-55; Wed, 05 Dec 2018 05:49:02 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQ3N-000650-0E
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:48:59 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn14so9501410plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jlAgOUx+d9y4Koxz93q6parhhjhH4dXwDaeTxxP4nP8=;
 b=JLarozb1MoFj2iMfg32xnjapXOlEmjo9r3TV0J+hBfRbOOmqKETxBnc00LeEsw+vm0
 0lGXJEwWat/3MZeQfKcHirJYh9v82fkKBNOqII0K95iE5kfWgDpEV8M/zzzbjq3VhxYF
 04YxrC5+/zPLkcH+nofCQ656iGKoites41d8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jlAgOUx+d9y4Koxz93q6parhhjhH4dXwDaeTxxP4nP8=;
 b=Z15pAcvDBdnYN25Q/UOH2BY3ZYO8Pyz2SBcgZOJ8Na34H2/1W4W6YZugPEuMOrvQrA
 awC7RizXD/s7z6b/wJyDjTVvO4aTesAw+4xf6aJF8Kk3mH0CF4fh7ipctHDgQ2ThpMzu
 Mojl0007D2cWk/GBg2Zq5z7NcvDA1upHqeeZwmWAARIHPj4fO/2Hp7eX9XrC0Wc6Ctck
 98J89LT2C8UPhh+HOIlj4PNuC/Yb0ou1JjQjTJ9oNeaJRqTAGOoQZ4ClhvgUF+OnxqQ9
 DurwerLu+DAwvM6QbjqgRUVmknBwU/BtTlKLu4KDvJR4PvlV7R2PDYgn1nKpQNfEC3HP
 eHsA==
X-Gm-Message-State: AA+aEWZyOa16pmMtr7FLDLPZCfXC2NAOcUJjPyqw4gjLwd4vF82GMgZY
 K9/1hrd10B0vY3WG8XG2aJwNtA==
X-Google-Smtp-Source: AFSGD/XGIJEFyfrfyg8OULqJMVs+IAQFRiR6jXi3pWWWNF4H9mhmgzh0A9r92Lrx+0cfo5I3yXVu/g==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr3053408plp.36.1543988926074; 
 Tue, 04 Dec 2018 21:48:46 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id 4sm30806513pfq.10.2018.12.04.21.48.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 21:48:45 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Wed,  5 Dec 2018 13:48:25 +0800
Message-Id: <20181205054828.183476-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_214857_047216_2E0DBFF6 
X-CRM114-Status: GOOD (  13.43  )
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

Nicolas Boichat (3):
  mm: slab/slub: Add check_slab_flags function to check for valid flags
  mm: Add support for kmem caches in DMA32 zone
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 Documentation/ABI/testing/sysfs-kernel-slab |  9 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c          | 20 +++++++++++++----
 include/linux/slab.h                        |  2 ++
 mm/internal.h                               | 22 +++++++++++++++++--
 mm/slab.c                                   | 10 +++------
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 24 +++++++++++++++------
 8 files changed, 70 insertions(+), 22 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
