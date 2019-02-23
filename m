Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB20020684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AK8qbkHh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w6VY6TEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB20020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mnmAz0qn2ly+ClHVPN+fl3jZBp/8W1bUJ0qAeq9W1pg=; b=AK8qbkHhNpmLgJ
	jO9ZOgA1TximOeAaIVvIPDfP6MhvfjD0o8cFtGIzZhqD0tD3rF/vYJxxgh3NizyWkh6FV8WnpVvKh
	v1uqPsRwqW4jbcJRh46hIsNLMm+szCNnLO6TsHOZ5Zu8sO/8Ijc208nK3/9uINev4vLiQXqHnJ7/S
	oiTK+3U7KTeJnAFffu9i25QAr5ISFRwxnhB6l2aUCbSFVrqJBpqN94PWTgjKjOj22FaamW2K2XXJZ
	pmlCyJ8n+nj/ijGX9mT05b3nCcJ1WuGMnZknQMCQMHOEboFfzYZaEqlriY2k/3LTB9PVRr2/Gk/WQ
	0QlnS9JfVJMIRPirtspw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxTg9-00067e-NC; Sat, 23 Feb 2019 09:33:05 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxTg5-000671-PI
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 09:33:03 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1N9WuTo103998;
 Sat, 23 Feb 2019 03:32:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550914377;
 bh=hekSgN0RAfdwNHhQWSUOHFs3OTGGciWCnt4NBTIkjCM=;
 h=From:To:CC:Subject:Date;
 b=w6VY6TEctOjNJuZMEQYKNAs0ZpN13cWN7nl+jdxZZRgqsrwSPUyvoe+LSr0/JRbxh
 a54yRT2MtD9yOG7dPN5UVU76rRohhN6n/swykJqF2t+x4EYkuBMOSu93QLuV+iMML8
 QIbsAvr+N5ACDYLGfnlwywNe8lP2AIWhNjswvQDs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1N9Wuw8030989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 23 Feb 2019 03:32:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 23
 Feb 2019 03:32:56 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 23 Feb 2019 03:32:56 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1N9WrQh028361;
 Sat, 23 Feb 2019 03:32:54 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>
Subject: [PATCH v2 0/5] soc: ti: k3-am654: Allow for exclsive request of
 devices
Date: Sat, 23 Feb 2019 15:02:27 +0530
Message-ID: <20190223093232.29003-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_013301_917033_80346890 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sysfw provides an option for requesting exclusive access for a
device using the flags MSG_FLAG_DEVICE_EXCLUSIVE. Once a device
is requested from a host with this flag set, any request to this
device from a different host will be nacked by sysfw. Current tisci
driver enables this flag for every device requests. But this may not
be true for all the devices. This series adds support for providing
an option to enable or disable exclusive permissions.

v1: https://patchwork.kernel.org/cover/10817307/

Changes since v1:
- Split the dt-bindings doc to a separate patch

Lokesh Vutla (5):
  firmware: ti_sci: (Dis)Allow for device exclusive permissions
  dt-bindings: ti_sci_pm_domains: Add support for exclusive access
  soc: ti: ti_sci_pm_domains: Add support for exclusive access
  soc: ti: ti_sci_pm_domains: Switch to SPDX Licensing
  arm64: dts: ti: k3-am654: Update the power domain cells

 .../bindings/soc/ti/sci-pm-domain.txt         |  7 ++-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 26 +++++------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 10 ++---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  6 +--
 drivers/firmware/ti_sci.c                     | 45 ++++++++++++++++++-
 drivers/soc/ti/ti_sci_pm_domains.c            | 32 ++++++++-----
 include/linux/soc/ti/ti_sci_protocol.h        |  3 ++
 7 files changed, 93 insertions(+), 36 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
