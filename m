Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEAFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFA020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D96VCEB9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EtqQxdIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFA020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Mp+Pj3fYdHQxful/CZ7PlmFzeOqDbYIsKEcUT1zbvjE=; b=D96VCEB9nHOQ5Z
	sYAwR9X0Oh5lb0Ve27GuYYPJoO5W3xlIzQKN5Gbo1PXvtoG0B76nnxQXH017hNojmzhZZvxc+M48K
	g/j9yWe5bO5uRY7FGBG4AsPqaq55nkyWuNpsYrTbYb1UzFxATJl9KB75piChRRWCJmQOxNE+Zku9/
	GgbFg1xWm85GjNi1yceM1Aroqf3NvkAfKwwnn9qXX//kddE80QL/GnhDJzApWNII3cDnQPbO4mLWL
	+r6ZmZSOel5w1yIBL2/5UjBUts1e/KHG+rlyF8e2wMEMbfzBmw/sJCwtEwsgrHLiornAa4tZglcK0
	JF/UsZbSsam12vy+aF5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQMm-0007L5-TU; Mon, 10 Dec 2018 18:33:16 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQMD-0006n1-R1
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:32:45 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAIWNpJ095311;
 Mon, 10 Dec 2018 12:32:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544466743;
 bh=kwxgW5hrxxyvv5BsKvPXkFnltap/3pj5q/x0IItJdH8=;
 h=From:To:CC:Subject:Date;
 b=EtqQxdIoW7DqCpn7nKZuC84HL+ECZ1o9xoSJoURgDt096jHjhVRWKxuofb87kKX1F
 qYMgdbXrro6d1uIvWCrnmB5I2ZvcLe3UoJc7ATUsuAt818948X8WXQkIVxyZ6psply
 TuDf5CBzFy34QyPlqnq4++H8tTxuXheLrR1ywRkA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAIWNaM101797
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 12:32:23 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 12:32:23 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 12:32:23 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAIWJdM020318;
 Mon, 10 Dec 2018 12:32:20 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
Date: Tue, 11 Dec 2018 00:05:04 +0530
Message-ID: <20181210183507.9617-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_103242_000742_C9117149 
X-CRM114-Status: GOOD (  16.85  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
 kishon@ti.com, robh+dt@kernel.org, faiz_abbas@ti.com, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patches add driver support for MMCSD on TI's AM654
platforms.

Previously I had added the support to sdhci-of-arasan driver with
a separate phy driver[1]. Since then it has turned out that tuning
operation (for HS200, HS400 and SDR104 speed modes) will require
configuration of phy registers. This completely breaks the model of
the sdhci-of-arasan driver which relies on a separate driver to
configure the phy register space.

Because of this, I am creating a new driver with both the sdhci and
phy register spaces. This helps me use the phy registers in a future
patch that adds tuning support.

DT patches will be posted in a separate series.

Changes in v3:
 1. Removed reference to clk_ahb as its not being used.
 2. Added comment for pm_runtime being used for enabling
    clocks.

Changes in v2:
 1. Reset OTAP delay back to default value in init.
 2. Improved patch description for patch 2.
 3. Minor style fixes.

[1] driver and phy patches posted before
    https://patchwork.kernel.org/project/linux-mmc/list/?series=26623

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Document bindings for the host
    controllers on TI's AM654 SOCs
  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
 .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
 drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
 6 files changed, 428 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 drivers/mmc/host/sdhci_am654.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
