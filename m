Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17400C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D285021773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4Rv/Yd3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="csw6EXJq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SUgsPHZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D285021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UpvOUN3LTFpKM9wo3k3o87D2wh6fu13OpyqGaH82Xfg=; b=U4R
	v/Yd3W+6h2w3evctSrl4KAYAXUH759KSofxPvx1mq1+V0pq/LqrkvgTQ+bYft2Ie5wowQV5Z6vv89
	9ajtG8/tsEECasl195B1xny0YSVXNPd3YvUgqMaJw0ieuIu8rnK5Z0pEIRhdhdPQyfhp4Yt5SpH4Y
	tCnSMw5mryGyt1D7OJh8Rc8T+szgltSwcowcJVbVlXvuvVLq2GJXbbP9BKNFysx+uiW/jof6FVw1+
	cToNaQNPGz2A0P3ZjVIeJKFZR3wyN0VLuQfCFJ8QWgcw1xHg9MyZykH4P3CVj66uhd5u/V2STLnhg
	rtTMaKZm3lm1g1H7+gpfxLgZXI7JGSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSWu-0000fH-Ph; Mon, 21 Jan 2019 05:53:52 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSWr-0000es-SB
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 05:53:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8EE5260866; Mon, 21 Jan 2019 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050028;
 bh=2DBDGwUlWjS1IStdYezKwR/C6qSSDYrOCCPTeQbHBPs=;
 h=From:To:Cc:Subject:Date:From;
 b=csw6EXJqFlaJcz/mDGAS8bmthO41fNyf81CtfIqM6mpjIYfCQafOUM1Ux6H18YF1R
 7KHF2r+ex1f6a/rLHZjvwiThQ81Rq4h6gVivUbBR6CXpGkTLeBrZh/KcD/Q47+bZHA
 ovPMT91+u1L8Xx5cfCU9OYKBpVqYrzxuxhufkuSk=
Received: from blr-ubuntu-41.ap.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 220F060237;
 Mon, 21 Jan 2019 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050027;
 bh=2DBDGwUlWjS1IStdYezKwR/C6qSSDYrOCCPTeQbHBPs=;
 h=From:To:Cc:Subject:Date:From;
 b=SUgsPHZFTLtAvaxvBOLZIasN0cZOSNphdom2Imladlv5KpMymgB2QkWB/LdMuzsx0
 y1prPUyk4LHw+cOVlWa8C7jO4gsARYgK3Y4nrqHp/M1GQGRvEByjVEQJQ6pIbJ9Wp2
 wDOTDQZYXNml2oZTIx+7Z9XRj1+CyZFY92ZBAa/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 220F060237
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
Date: Mon, 21 Jan 2019 11:23:32 +0530
Message-Id: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_215349_948974_C58E44E9 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Qualcomm SoCs have an additional level of cache called as
System cache, aka. Last level cache (LLC). This cache sits right
before the DDR, and is tightly coupled with the memory controller.
The clients using this cache request their slices from this
system cache, make it active, and can then start using it.
For these clients with smmu, to start using the system cache for
buffers and, related page tables [1], memory attributes need to be
set accordingly. This series add the required support.

This change is a realisation of following changes from downstream msm-4.9:
iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]

Changes since v2:
 - Split the patches into io-pgtable-arm driver and arm-smmu driver.
 - Converted smmu domain attributes to a bitmap, so multiple attributes
   can be managed easily.
 - With addition of non-coherent page table mapping support [4], this
   patch series now aligns with the understanding of upgrading the
   non-coherent devices to use some level of outer cache.
 - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
 - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
   stage-1 mapping.
 - Added change to disable the attribute from arm_smmu_domain_set_attr()
   when needed.
 - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
   level.

Goes on top of the non-coherent page tables support patch series [4]

[1] https://patchwork.kernel.org/patch/10302791/
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
[4] https://lore.kernel.org/patchwork/cover/1032938/

Vivek Gautam (3):
  iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
  iommu/io-pgtable-arm: Add support to use system cache
  iommu/arm-smmu: Add support to use system cache

 drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
 drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
 drivers/iommu/io-pgtable.h     |  4 ++++
 include/linux/iommu.h          |  2 ++
 4 files changed, 43 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
