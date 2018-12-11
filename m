Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DAC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1A620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THPgodv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1A620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7qJ4qNArNV18nBXNr7epfKUByqh+fG8qVJmZOKSsA4k=; b=THPgodv3jwV19S
	nB2LC2avgODIF5ThYRABME/2v4w+FjVP8efP9zRs3nk0NxKxHzXe/aDFieZFbZkd+huDQcAjLA+wA
	WvupRwpc0w/ozLPR26F5iefpKi4ICZlp2Zd4doi9BckPVydtcVSG86qIGMUFK5RilRg3x2kN6RLZQ
	XWiw8Aa1RzeeNbLpZBgVeOD3c+PjlPGLzP0Ku65WHDs8cOk7a+JqsWV/MpRQyAGjqjZn5KoIoGR7A
	pNSHqqSXLjYtwsVXjg5WpVByHYq6h+CyEIoeRIa8mwNUsVYOVRRhxW2pD5qS1C2rUWa/P547XVEOU
	dKFa/2hA6/KWd81IUR5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWoKe-0006Vj-OX; Tue, 11 Dec 2018 20:08:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWoKZ-0006IQ-Rb
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 20:08:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3131180D;
 Tue, 11 Dec 2018 12:08:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01ED33F6A8;
 Tue, 11 Dec 2018 12:08:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 204F21AE0B70; Tue, 11 Dec 2018 20:08:48 +0000 (GMT)
Date: Tue, 11 Dec 2018 20:08:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.21
Message-ID: <20181211200847.GB5218@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_120836_102366_3E7C3B8D 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Joerg,

Please pull the following arm-smmu updates for 4.21. This includes the
clock and pm_runtime updates to the arm-smmu driver, as well as some
non-critical fixes for the arm-smmu-v3 driver.

Cheers,

Will

--->8

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 89cddc563743cb1e0068867ac97013b2a5bf86aa:

  iommu/arm-smmu: Add support for qcom,smmu-v2 variant (2018-12-10 14:56:00 +0000)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Sricharan R (3):
      iommu/arm-smmu: Add pm_runtime/sleep ops
      iommu/arm-smmu: Invoke pm_runtime across the driver
      iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
      dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Will Deacon (1):
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Zhen Lei (1):
      iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads

 .../devicetree/bindings/iommu/arm,smmu.txt         |  39 +++++
 drivers/iommu/arm-smmu-v3.c                        |  22 ++-
 drivers/iommu/arm-smmu.c                           | 170 +++++++++++++++++++--
 3 files changed, 216 insertions(+), 15 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
