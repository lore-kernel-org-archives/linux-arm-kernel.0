Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E77217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CpEacD8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E77217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xcwVidqI/Jt1JgDGIsTua5zqN0Ndqkm3LQHzlG+mlWU=; b=CpEacD8yqOlUtu
	YN6IwhvIk0u1zbz6Ib0tyKCi9nRjujWDwvFRVUVwLSSOANtmv45DCsacc/y3RUHG7t6F5cQnzWpRI
	GtZhnuBPVuNSN7L8/NSojj/OOghpOgVWRl3br86Raf7oC9PaAah29uL9pG5syZFczp2eRWR0MZKTA
	6Pa3rZc6hHYrdQtnrDEvk0zqogJQVKJDLuc8lS0wDGAjpL09tmuRMuSJt4gAiShtgD9zS/tk/2xU2
	Xuy026o2dGwjYUFqzIGD9HI30SukuCJdsTGqGK+q3LVi8NvFuJ8uiDA6GDSiZKHXJFpQgXDP/pv4l
	ZCV5hiDjWM3tg4YCmYOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhSh-0007QC-JA; Thu, 24 Jan 2019 16:02:39 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhSY-0007Kd-LN
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:02:36 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 44D6843D376;
 Thu, 24 Jan 2019 16:02:27 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH] ARM: pxa: remove unused empty mach/pxa25x-udc.h file
Date: Thu, 24 Jan 2019 18:02:22 +0200
Message-Id: <20190124160222.13138-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190124_160227_304266_77BE8D30 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_160227_304266_77BE8D30 
X-CRM114-Status: UNSURE (   7.71  )
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
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit c5418a0b98c1 ("usb: gadget: pxa25x_udc: move register definitions
from arch") removed inclusion of mach/pxa25x-udc.h from the PXA25x UDC
driver, the contents of the header file was also wiped out, however the
file itself hasn't been removed, now this change removes the unused empty
header file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-pxa/include/mach/pxa25x-udc.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa25x-udc.h

diff --git a/arch/arm/mach-pxa/include/mach/pxa25x-udc.h b/arch/arm/mach-pxa/include/mach/pxa25x-udc.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
