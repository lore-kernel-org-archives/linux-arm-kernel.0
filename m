Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205ACC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E177E218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TnMocACk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OMW6Ep77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E177E218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nGuHPvtAfRwzRTkSfQG1hHBKdCHvKPpP2z3KarN5J1g=; b=TnMocACkUQINPO
	WduMNyjPg0ZjOyNfkoFbJDVHA64RshOFpUMBa3rRdUo3/vTtVAE4cpS93sp6EQ9Hlq+EMKUtuC4Ea
	2lz+W0UWcYCL/X2k9xRHtvhAvss2kux5gQple4WaqYw85MgFA/98qnDoKUhmRS6ihrmWWDoqQ0PEg
	ffdYUruEef9AkwRMSXexouh4pELW5hFcJ3CQPihj86RRZwrZZx6h+cH3W66HWpSUTjCPbLPlcsLro
	Dl6ewQei+IW87HSOaEsyVl/Xz+nmAtAjpWVXL1eSnYOFAuZZkYVaAy6XQBHmmxyF0dRubwGay6m2W
	oti3eyql8HmfUygLvgaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbHd-0000oG-RZ; Mon, 18 Feb 2019 05:16:01 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbHU-0000fC-8B
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 05:15:53 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1I5FeQ7114545;
 Sun, 17 Feb 2019 23:15:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550466940;
 bh=g/fP70CmME5zIgH7uVWnK2y3g1qmmSxCLJR24kICilk=;
 h=From:To:CC:Subject:Date;
 b=OMW6Ep77BK5S5MvryyAdXKg6bEHQ7JelGzardIRmmzgnGPuntOhI5KQjH9AuphSlb
 sm9scaPVQOATo/m5HeZmTrnwXCJdBzqFvZ4a243xpGgZgD3ZgcR4b40NqxuCDj8lUQ
 lBO+9+ILj8BXrbAGg5DkZXdccK31NUOqSd6bva+4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1I5FePf052296
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 17 Feb 2019 23:15:40 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 17
 Feb 2019 23:15:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 17 Feb 2019 23:15:40 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1I5FbKg029067;
 Sun, 17 Feb 2019 23:15:38 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/4] soc: ti: k3-am654: Allow for exclsive request of devices
Date: Mon, 18 Feb 2019 10:45:13 +0530
Message-ID: <20190218051517.9218-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_211552_328616_A22F37B7 
X-CRM114-Status: GOOD (  12.88  )
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
 Sekhar Nori <nsekhar@ti.com>,
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

Lokesh Vutla (4):
  firmware: ti_sci: (Dis)Allow for device exclusive permissions
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
