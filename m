Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88198C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4960221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KXFrcsmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4960221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=PgYgS41J1YkW/TSE+/v5loaQIfphHkSpMDMs1RtrDN4=; b=KXF
	rcsmZgISpGJmEs9ti5w1pr4rwO6bBZZuFuGNxW98Qya5q8HEJsjoXoA1sNjwSCsdQBCjtUbwZR3Eh
	rbm740icBy+VSGU3Sdk6x34mFlA7H7WXbZNReBpHK8OND+OWsLZcbf2X8WL3Q+4wyM3EzXeBDYPWr
	NPuNVCFYWJSqJWn6rVfWEPtzbNT+2I/jJzHw+HEtB3B2CYhR963/Hlwj0k418GAJSIPiDedXlMNfM
	8aJfGeMnAXRxyB04nCfq1hkvwgXIuMR7W00rAwt5w3RoPQxjAx2+plnNyM5XgRftH4djJO2kXFt43
	RWIYSNiOaRgkxBnK578Dyp2hQh5+nCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga8Zr-00080P-Va; Fri, 21 Dec 2018 00:22:07 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga8ZH-0007MB-BK
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 00:21:33 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2018 16:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; d="scan'208";a="112251074"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 16:21:18 -0800
From: thor.thayer@linux.intel.com
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 dinguyen@kernel.org, arnd@arndb.de, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will.deacon@arm.com, peppe.cavallaro@st.com,
 alexandre.torgue@st.com, joabreu@synopsys.com
Subject: [PATCHv2 0/6] Add SOCFPGA System Manager 
Date: Thu, 20 Dec 2018 18:23:16 -0600
Message-Id: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_162131_463860_F5526426 
X-CRM114-Status: UNSURE (   9.76  )
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
Cc: devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, olof@lixom.net, mcoquelin.stm32@gmail.com,
 mchehab+samsung@kernel.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add MFD driver for SOCFPGA System Manager to handle
System Manager calls differently for ARM32 vs ARM64.
The SOCFPGA System Manager includes registers from several
SOC peripherals.

On ARM32, syscon handles this aggregated register grouping.
Implement System Manager calls as regmap_mmio similar to syscon
for ARM32 SOCFPGA systems.

The ARM64 System Manager can only be accessed from priority
level EL3 so this new MFD driver handles the calls to EL3.

Thor Thayer (6):
  mfd: altera-sysmgr: Add SOCFPGA System Manager
  Documentation: dt: socfpga: Add S10 System Manager binding
  ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  net: stmmac: socfpga: Use shared System Manager driver
  arm64: dts: stratix10: New System Manager compatible

 .../bindings/arm/altera/socfpga-system.txt         |  12 +
 MAINTAINERS                                        |   6 +
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/altera-sysmgr.c                        | 263 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
 include/linux/mfd/altera-sysmgr.h                  | 113 +++++++++
 10 files changed, 411 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
