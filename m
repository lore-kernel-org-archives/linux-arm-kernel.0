Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6039C20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9PRBgNX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzhplasc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzhplasc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6039C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=PUnU1XmTp+mgiwpnnmB3R3+7VuvaSvFOpZNTybIN8x4=; b=X9P
	RBgNXJW8hFBjHZKMWOM8KUbUGX94/+QiaQLcqHuKVi3MyLKdYRCe12anfV8EAlyh1kFOFZRmWDjb4
	kJVCWXEWkUSuXqaLEoLRocpW/TVVRJ5pfcPm4tubRqj2Egacb1j/BV231fJaJ+k/p+Lkp/yVadH3r
	cNTYWEhy2cDTKFaYyjtUA9Zn9YeueFw1eGUlAZh6wqOt7vXt6QG2B+yA1rh/h8N6YTXGEOHBp9b5i
	L2DgpEirNhdr8kf7AiP1dwmoWXRroiLyElQfAR/WxcN561IQpW46wIlo+j86LWodEfCPxDRN7Jjln
	vuiOj3AnJPHdJ4Bg0wL8OJSO12M85rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3xX-0007A5-8N; Thu, 17 Jan 2019 09:27:35 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3xT-00079i-7P
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:27:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8E7616081E; Thu, 17 Jan 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717250;
 bh=ha3EEdy0k9HNUff6t9j+eSO2ILmrLR5UiUWmfVUPmZU=;
 h=From:To:Cc:Subject:Date:From;
 b=fzhplasc4Y4ORa3iZsE/ePbnHcgfqWwcg7KIsaMuCiw1+SUToPN2y7oUwk8P/TxoC
 doNOyalIjRmYZ5Qel6UiCDCyS0X4bkz1ZZrAXyvNsqHz4UYVuNzpusuJyRjDe6cw1d
 K3rMBxczeJYJVCzI+Z+yUyX5RdInM0IYKTUk1T2c=
Received: from blr-ubuntu-41.ap.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E25F6021A;
 Thu, 17 Jan 2019 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717250;
 bh=ha3EEdy0k9HNUff6t9j+eSO2ILmrLR5UiUWmfVUPmZU=;
 h=From:To:Cc:Subject:Date:From;
 b=fzhplasc4Y4ORa3iZsE/ePbnHcgfqWwcg7KIsaMuCiw1+SUToPN2y7oUwk8P/TxoC
 doNOyalIjRmYZ5Qel6UiCDCyS0X4bkz1ZZrAXyvNsqHz4UYVuNzpusuJyRjDe6cw1d
 K3rMBxczeJYJVCzI+Z+yUyX5RdInM0IYKTUk1T2c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E25F6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] iommu/arm: Add support for non-coherent page tables
Date: Thu, 17 Jan 2019 14:57:16 +0530
Message-Id: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_012731_288877_B4C24CB0 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tfiga@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As discussed in the Qcom system cache support thread [1], it is
imperative that we enable the support for non-cacheable page tables
for SMMU implementations for which removing snoop latency on walks
by making mappings as non-cacheable, outweighs the cost of cache
maintenance on PTE updates.

This series adds a new SMMU device tree option to let the particular
SMMU configuration setup cacheable or non-cacheable mappings for
page-tables out of box. We set a new quirk for i/o page tables -
IO_PGTABLE_QUIRK_NON_COHERENT, that lets us set different TCR
configurations.

This quirk enables the non-cacheable page tables for all masters
sitting on SMMU. Should this control be available per smmu_domain
as each master may have a different perf requirement?
Enabling this for the entire SMMU may not be desirable for all
masters.

[1] https://lore.kernel.org/patchwork/patch/1020906/

Vivek Gautam (2):
  iommu/io-pgtable-arm: Add support for non-coherent page tables
  iommu/arm-smmu: Add support for non-coherent page table mappings

 drivers/iommu/arm-smmu.c       |  7 +++++++
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
 drivers/iommu/io-pgtable.h     |  6 ++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
