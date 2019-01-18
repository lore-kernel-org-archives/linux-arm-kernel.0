Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFEF20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t25681FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFEF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ij0CIe3m2syHRl/21GBqCewLi11orxCQ+zya/pOC+ao=; b=t25
	681FUWFHVvpqoP+zg23r5ZW7ugRZeUHSa0urRj/01U+DNY3nM+vRB3YkHTkC0obPwl+zxqEm88qug
	M77+mLNFj8FrQDXo7A8z3LgxFnC6SzvSApeyDTxjUy0MR3tsH9hJ22tWrqdzJxxOB+MFMC7vMmxJ+
	hHs6OZHCV8NBZpX2kjh4Wbw96Y1CHJ1dSaIf4nAtXzRVBBvilchHu+ALz/siHtDvyjj0Q7hww4fB/
	fkg1J75Egv7ZC/D+DHIXdv8bF9Z8En8TzuSIkOEgf2OQQZwPuBgTEsNAAPJJFkXCVVkiZ1vJw9w9O
	gwJxloFcKZi/LZCX+ppzJ6SBXD5mzKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkIQm-0002NH-H7; Fri, 18 Jan 2019 00:54:44 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkIQh-0002Mo-WD
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 00:54:41 +0000
Received: by mail-pf1-f194.google.com with SMTP id c123so5698005pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 16:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9NpSHW4RmvPyV3ytMSCF4mTkutVXOQZSPLvn5ixjCXI=;
 b=JbTxEgnGFLqMbUizqPZT7hTM6OzaAp8NcASRhUEnq7fLY6T6gVTe4aXErjspZZxtc5
 C80anektfvVwA7CnPemD/uOZYGR4nhF3w1t1jqk3EWcTxSbt5CmEDYsP28kX1RgodLbn
 AdCCeCZxrWN9mduTFfsZMnHsEL786mKPl4cL7PxEcpHecGn/Fv9HbzQ+XR9ZkCF9pewT
 VTcMXVJrVK8tj50hLuGGL6nx7f+4Smffz2FbnaJ/Lyrf6o6+wEI6po4JB+5O1SI4ZTdO
 ZU7FfbSwUUc0FrQPIl6yfZKm1713DqiNtICplvvopuzwoFjfbuWd2iH5q/A3CJqhbTEW
 MIIg==
X-Gm-Message-State: AJcUukcRNkHkJjwk7V1E1Z2sc1JriE9WPo1vzCfl/H7MZhVPEaEegtEl
 HefQqc3QqXvUTpNGgngrwNqKRA==
X-Google-Smtp-Source: ALg8bN4SAjvtpR1UnHvIpLxzRUPX9vUmlTFSqDtT5+5nz6ETFoi1auA7BdLkUvV1546E3CaQrJkH4w==
X-Received: by 2002:a62:5910:: with SMTP id n16mr16998976pfb.128.1547772874981; 
 Thu, 17 Jan 2019 16:54:34 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id g2sm3700631pfi.95.2019.01.17.16.54.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 16:54:32 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH] arm64: dts: hi3798cv200: fix malformed SPDX license identifier
Date: Fri, 18 Jan 2019 08:54:04 +0800
Message-Id: <20190118005404.10452-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_165440_036461_2D7C037B 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It fixes malformed SPDX license identifier in Hi3798CV200 and Poplar
DTS, accroding to Documentation/process/license-rules.rst.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 4 +---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index 32716c96b457..c563d3eb2d98 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * DTS File for HiSilicon Poplar Development Board
  *
  * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
- *
- * Released under the GPLv2 only.
- * SPDX-License-Identifier: GPL-2.0
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 7c0fddd7c8cf..13821a0ff524 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * DTS File for HiSilicon Hi3798cv200 SoC.
  *
  * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
- *
- * Released under the GPLv2 only.
- * SPDX-License-Identifier: GPL-2.0
  */
 
 #include <dt-bindings/clock/histb-clock.h>
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
