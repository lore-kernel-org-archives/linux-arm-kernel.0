Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D89214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLLqCFtC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fU4YdSsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D89214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=keeoWByo0op4c18SX5eUGfp3D16+RPMy3tTmiLtoIy0=; b=HLLqCFtCiMqNlb
	pTfZbFZBEePHEj0w1G5I2S7l0R7oi2dNl9ZBwRlDLw1rq1bOipbjBiZUZ1hcksca7uWUBy2MSMINb
	/WERzmPQ1ql6526xq74jV6FQuFjmquwDLL+DWd+UkNN0gk816DkXn+LcYdCYOFeEMHMd/jqYPrGzW
	OXYaF1AoVPuTl1LzphfESWC10R1QhFMPpc/rk768Hc08RqnyZYgRIC6Ww8L/Oi32rA931VvhKeSWN
	9DXufDbn0mWZFNEd949J0l9/gavXEfSd646PRT1QkgK/DXGgXpz25C0T9MLb588Qn9S/iupg1xpqj
	yzDk9m0TN9ID9THAFEDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUo8-0003kG-Rj; Thu, 10 Jan 2019 07:31:16 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUo5-0003j9-OM
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:31:15 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A7V7nJ102211;
 Thu, 10 Jan 2019 01:31:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547105467;
 bh=0UM8BoEUFLapEG50gQhjK3ZcFicTENsT9w6/Mpg/YFc=;
 h=From:To:CC:Subject:Date;
 b=fU4YdSsKKl0gK/Vnv5JBCoOGL7t/w+Mn0U0gZIFMRqi6W33gmyRXTISHdimsHmZbf
 UnWzL6C6ptJ/GIq1gCwzWUKC4iG+TPTLryOSKuCWLmTcCX8ogY2/yI0iCPmhHsYqcD
 6AqDUzEZn74HXEhgIl6ciw7AqDuh53fzqRsN2kgY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A7V7A7106510
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 01:31:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 01:31:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 01:31:06 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A7V38h020221;
 Thu, 10 Jan 2019 01:31:04 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/2] Support for eMMC in AM65x-evm
Date: Thu, 10 Jan 2019 13:03:53 +0530
Message-ID: <20190110073355.3382-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_233113_944399_E7147106 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: mark.rutland@arm.com, nm@ti.com, robh+dt@kernel.org, t-kristo@ti.com,
 faiz_abbas@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patches add eMMC support on TI's AM65x-evm.

v2:
 1. The SD card node is under debug for some usecases.
    Only upstreaming eMMC support for now.
 2. Rebased to latest mainline.
 3. Removed status = "disabled" from dtsi patch
 4. Fixed node name to not include '_'s

Faiz Abbas (2):
  arm64: dts: ti: k3-am654: Add Support for MMC/SD
  arm64: dts: ti: k3-am654-base-board: Add MMC/SD support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 13 ++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
