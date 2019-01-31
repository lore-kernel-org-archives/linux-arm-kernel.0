Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0D218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7o3JE6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0D218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WyF6NCeQm8uaOUy2+CF+QK4ErbL0OS+PxtPn/jFqyBU=; b=i7o3JE6WkRNXUv
	9bqVTj6/9pazkTKOIMXJWEbvKjTFyQq6tllMI7gPW8ZXhslDZ3h3mo6EpZHWBoELjKJ0IXjSA7ReK
	/Z33dQTpeFEUTl8MR+K8alkaMIM/hpyoxfrxbDtUn3ACYCVjXwa+1nN3NAuoqCDoJv6QllAb52aTR
	K6BAafdqZopelmLkQccSPzekbwTFOJg6tlSsAmd+b+7gBDI+9fybuLF81nNJhFwVdrbMSebYivaLx
	QlbctcHRwkVYDkV+e+kqKFupTSLQRCHmZF8qkT9iHCfNO+n1GmiH8xyKqXBYBxxx15bLIyMdIHUkD
	AZ+W1vdHlI1WFNnWxDhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7IY-0004Nd-3A; Thu, 31 Jan 2019 08:02:10 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7IU-0004MD-ID; Thu, 31 Jan 2019 08:02:07 +0000
X-UUID: 0bd4210929c34eae9cac8bfc266effde-20190131
X-UUID: 0bd4210929c34eae9cac8bfc266effde-20190131
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 643749125; Thu, 31 Jan 2019 00:01:59 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 00:01:58 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 16:01:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:01:55 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v2 0/2] PCI: mediatek: fix warning and enlarge the PCIe2AHB
 window size
Date: Thu, 31 Jan 2019 16:01:51 +0800
Message-ID: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000206_605070_EB717243 
X-CRM114-Status: UNSURE (   5.76  )
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
Cc: youlin.pei@mediatek.com, poza@codeaurora.org, fred@fredlawl.com,
 rafael.j.wysocki@intel.com, jianjun.wang@mediatek.com,
 Honghui Zhang <honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Two patches:
patch 1 fix the complain of scripts/coccinelle/api/resource_size.cocci
patch 2 enlarge the PCIe2AHB window size to support fully access of 4GB DRAM from EP DMA.

v2:
 - Fix the checkpatch complains for patch 1.
 - update the commit message and change title of patch 1 for changelog conventions.
 - Add patch 2.

Honghui Zhang (2):
  PCI: mediatek: Use resource_size function on resource object
  PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM

 drivers/pci/controller/pcie-mediatek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
