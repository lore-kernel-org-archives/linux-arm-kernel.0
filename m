Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DF920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXVve1jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DF920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8urfihmSYHIekodlOYu6s9ek9iw48xD31KiWL7GOdFU=; b=GXVve1jkhdJT3o
	UtZZPSc6PG9bPC5jMO955uYnygSl/LKSFd+6ui+f06toA0qbc0kXzCTpHIIAuUkUgnJTv8sXTTv1L
	c5quPP/pkTuIWCh2lYaEIYA60bg70DB+VXwN+xUz8MH2dJdG4RGGy4T4FRTQ22K0Jef8kppJzCj6V
	fGT2e6GGFlJ3AYkTGjro4S94HZ4AbzspSKdzRgq3jYQ7pYeiFtgCVWSiDQ9yYKzRC+qusgio27EkY
	nsnd1DOyBQ8Ffu4BCHZZfVylvDIexnRM3ukMj+/1kyRqcxoNQeCoP05L0kWYVvc/S9bJz37HogBDd
	38Lx+XvFFx/JqucHpi3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJ3F-0008Id-Ki; Fri, 07 Dec 2018 16:32:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJ2g-0007Lp-Cd
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:31:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE6F15AB;
 Fri,  7 Dec 2018 08:31:41 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D6393F575;
 Fri,  7 Dec 2018 08:31:39 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de
Subject: [PATCH 0/2] Refactor dummy DMA ops
Date: Fri,  7 Dec 2018 16:31:33 +0000
Message-Id: <cover.1544199754.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_083154_702513_01A71BB6 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: linux-pci@vger.kernel.org, catalin.marinas@arm.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, will.deacon@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, gregkh@linuxfoundation.org,
 bhelgaas@google.com, lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Tangential to Christoph's RFC for mitigating indirect call overhead in
common DMA mapping scenarios[1], this is a little reshuffle to prevent the
CONFIG_ACPI_CCA_REQUIRED case from getting in the way. This would best go
via the dma-mapping tree, so reviews and acks welcome.

Robin.

[1] https://lore.kernel.org/lkml/20181206153720.10702-1-hch@lst.de/

Robin Murphy (2):
  dma-mapping: Factor out dummy DMA ops
  ACPI / scan: Refactor _CCA enforcement

 arch/arm64/include/asm/dma-mapping.h |  4 +-
 arch/arm64/mm/dma-mapping.c          | 92 ----------------------------
 drivers/acpi/scan.c                  |  5 ++
 drivers/base/platform.c              |  3 +-
 drivers/pci/pci-driver.c             |  3 +-
 include/linux/dma-mapping.h          |  1 +
 kernel/dma/mapping.c                 | 54 ++++++++++++++++
 7 files changed, 63 insertions(+), 99 deletions(-)

-- 
2.19.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
