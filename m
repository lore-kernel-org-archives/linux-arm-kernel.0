Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C42C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0604220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzDPV/1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YnXQdxQS9LF0lo8h70FVZlM10SJfaxOgghCbHleX1mw=; b=YzDPV/1pnWdVxdfFjCAoVAl8gn
	t38PreF2ULoaKUeMb+yu+bZpw4gGk4zfLV7LKMVwZFQ0pR7IGiDr/01RiLchw7kiOIfl8FpA8RNjP
	7NGntLmXw6Kms/SrX09RtaFf9DeNVmtSubjd0e9B3wwz9i4CqhXK88PAxjVJDhVl4x+2cQGsQ4obU
	MgEsRypeRR/tkkVvH6pmqeCi8fsxvfb6m6rLXMd2JjwnpOF15i9nEnEmZ3Yf+xJPz+nrW4SKHyGWg
	4yEKTwhYBepBrxZguXNKqajNCe1kwmfQwkMX2VSsOX3bVfN+DcHIm8e35OBDehT7PK2N436Lk1lxG
	KiLv8/KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX88-0002Hf-E7; Mon, 21 Jan 2019 10:48:36 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX72-00018U-Ma
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:47:31 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6720A1A0140;
 Mon, 21 Jan 2019 11:47:27 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FF681A0014;
 Mon, 21 Jan 2019 11:47:23 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 744C340314;
 Mon, 21 Jan 2019 18:47:15 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v3,
 6/6] MAINTAINERS: add drivers/ptp/ptp_qoriq_debugfs.c into QorIQ PTP
 list
Date: Mon, 21 Jan 2019 18:41:43 +0800
Message-Id: <20190121104143.46782-7-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121104143.46782-1-yangbo.lu@nxp.com>
References: <20190121104143.46782-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024729_612366_30B7DAB0 
X-CRM114-Status: UNSURE (   8.79  )
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Yangbo Lu <yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Added drivers/ptp/ptp_qoriq_debugfs.c into QorIQ PTP clock driver list.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v3:
	- Added this patch.
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a592b99..098d0eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6088,6 +6088,7 @@ M:	Yangbo Lu <yangbo.lu@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/ptp/ptp_qoriq.c
+F:	drivers/ptp/ptp_qoriq_debugfs.c
 F:	include/linux/fsl/ptp_qoriq.h
 F:	Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
