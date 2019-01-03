Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D96620815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXS4yhh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QgbkL3QaIRlJRmvDg2P019NOWj9CHJdK5wHOte3Uv9Q=; b=OXS4yhh0Iakagl
	yleMhgLlgcpTyFMoPX7TEX8/cERWOtHibZFgb/9IsQEHQmkdy2HIYtIh3Iy/2hjZD4ZhPItrwFNW/
	sQvVRW2q9biAgAPQS/r2uW9rCXMsuHKwofOOIA8z55E/U0FdeASgaxVelcjogfM3A5rOGEPJoY3bL
	EOzR7Mg5sli96dyQdfy6Yx+CppIeon8j4mQg6JBZYRmRcYp9vERz9TYNUcdIDeFpn7FZJlvmYV4PE
	vS75WURZ7/D3imzuzpVx0r7KeN/ixi7FbO0NZ+FUCYI/yQG34iB8LQPdeHrsuwaejJ9iUB1gHs3Uq
	hDGqumnd4JncEzd0LFFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf045-00062A-UG; Thu, 03 Jan 2019 10:17:25 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf042-00060r-Dm
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:17:24 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x03AGY4w004133; Thu, 3 Jan 2019 11:17:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pnyjxj7ph-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 03 Jan 2019 11:17:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B098638;
 Thu,  3 Jan 2019 10:17:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B71E2A8B;
 Thu,  3 Jan 2019 10:17:12 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 3 Jan 2019 11:17:11 +0100
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@st.com>, <dmaengine@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v1 0/3] Add PM Runtime support
Date: Thu, 3 Jan 2019 11:17:07 +0100
Message-ID: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_021722_808138_2CCD4CA3 
X-CRM114-Status: UNSURE (   6.62  )
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
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use pm_runtime engine for clock management purpose for both DMA, DMAMUX and
MDMA

---
  Version history:
    v1:
       * Initial
---

Pierre-Yves MORDRET (3):
  dmaengine: stm32-dma: Add PM Runtime support
  dmaengine: stm32-dmamux: Add PM Runtime support
  dmaengine: stm32-mdma: Add PM Runtime support

 drivers/dma/stm32-dma.c    | 58 ++++++++++++++++++++++++++++++++++++++++------
 drivers/dma/stm32-dmamux.c | 58 +++++++++++++++++++++++++++++++++++++---------
 drivers/dma/stm32-mdma.c   | 52 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 144 insertions(+), 24 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
