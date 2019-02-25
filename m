Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05D02084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tX+OQeoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05D02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CwpN+Su1EFF5mf9kU9h2M8brnV3suFcpBa1yDmds6gA=; b=tX+OQeoESLNNvVWpMqBJO2G9Iu
	INpcCvgVbRwI0VYh0vl5EtqejV6kcXV86av3IG628ybg315bo6SdBUyap/mgYvj8qKED5G1UXa/bu
	uOJKIxLcXEJ9BXjozaSzDQf+/ufdHGRGe3HV593tubpMS/Y7WWLJm9v5HhrEg1rVsnXOTrh9jtcjS
	NVqwyMUNhgKqg2A0sdsw6teC2jklTywSIfqFFQM5FLSFA0+SfDhL1cJbkS7pO1EMC+OR9408x9SUU
	/j8Cw7CdwBbR+0xP5IvESs+MmSoF8MOKibeUvdicG7WX0rFFcnjNFNajlLYq5dI9dFCzgKlzYQKmw
	+dvpIqFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLWm-0003bk-BB; Mon, 25 Feb 2019 19:03:00 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLWP-000384-D7
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 19:02:38 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2019 11:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; d="scan'208";a="127150069"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 11:02:35 -0800
From: thor.thayer@linux.intel.com
To: bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
Subject: [PATCHv2 2/2] ARM: socfpga_defconfig: enable EDAC by default
Date: Mon, 25 Feb 2019 12:56:46 -0600
Message-Id: <1551121006-4657-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_110237_495174_33FAECA4 
X-CRM114-Status: UNSURE (   8.74  )
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
Cc: thor.thayer@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Enable the different ECC blocks by default on Cyclone5
and Arria10.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 Rebase patch to the arm/defconfig on the arm-soc tree
---
 arch/arm/configs/socfpga_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..1f2056c76ef1 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -122,11 +122,23 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_EDAC=y
+CONFIG_EDAC_ALTERA=y
+CONFIG_EDAC_ALTERA_SDRAM=y
+CONFIG_EDAC_ALTERA_L2C=y
+CONFIG_EDAC_ALTERA_OCRAM=y
+CONFIG_EDAC_ALTERA_ETHERNET=y
+CONFIG_EDAC_ALTERA_NAND=y
+CONFIG_EDAC_ALTERA_DMA=y
+CONFIG_EDAC_ALTERA_USB=y
+CONFIG_EDAC_ALTERA_QSPI=y
+CONFIG_EDAC_ALTERA_SDMMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
+CONFIG_RAS=y
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_FPGA_MGR_SOCFPGA_A10=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
