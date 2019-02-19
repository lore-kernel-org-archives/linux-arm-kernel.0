Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777E721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CTH/SpZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777E721903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e+TL6wyfbpteUctdsYfU/FFBno306n4b4duGwQ29AIg=; b=CTH/SpZG8rco7o
	1L9OnLdYoPzuJzJ+12xpwSaHlomIfNtPbO3m0dZwmysbWX/alL9S27Q0rGbTlPn0Nv/I0VfFKHTHR
	KzKSFs+lY6L/B63ySZrLSFWKZuae+PDBZV3RHR7UgpklxCFR696+ZFNm2NTSTvKCOnxGulx/+rDc2
	HMcII14g5WibTDLG8bRLSbN3KKjY4xbJdV2cRF0c4qP1CLGFmanaUg+cme4pUSto1OQ5oEh39LAPl
	BAEnLDh37h2w2Wn7Ek+qfTOEYT805Gv3a6ucn7CgbEw3fTncMZ3ltw6P4vxTpzwVksJ4AtgZT4ApG
	uMBw/WpdMdSzFdeG/MYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0HB-0001dt-Ii; Tue, 19 Feb 2019 07:57:13 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0H7-0001ao-8j
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:57:11 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D7AF1B92424E6C398E6C;
 Tue, 19 Feb 2019 15:57:00 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:54 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump
 kernel
Date: Tue, 19 Feb 2019 15:54:38 +0800
Message-ID: <20190219075443.17732-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_235710_421260_26FCDFDC 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series include two parts:
1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
   devices accessing. For more details, see the description in patch 2.
2. If the "ste abort" feature is not support, force the unexpected devices in the
   secondary kernel to use the memory maps which it used in the first kernel. For more
   details, see patch 5.


Zhen Lei (5):
  iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
  iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
  iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
  iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
  iommu/arm-smmu-v3: workaround for STE abort in kdump kernel

 drivers/iommu/arm-smmu-v3.c | 243 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 194 insertions(+), 49 deletions(-)

-- 
1.8.3



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
