Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE882192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QxJMiadb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE882192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FG2UpXV6xvsi9MRho4lQrZn7I2CkTqWG8TpE0eMfLds=; b=QxJMiadbFfR8ODu8pBY+aID13u
	86/KnJEH2ArxHXB1p0BWL7ApxDxIfLbBfjYgCgAFCkKaApRj7C2hjKYfnHZJuZgOgZQHMbNvrGG57
	jbyCvk2L1pO2QVFIFqwuhB4vnHtCLNTdVx8DvJK/XM2e276kGgnR6kVg8VE6Fg2SxHvhleZI24oex
	xLkLB5/YDQEjpPbCDwz4Cuadn/kVMoY/LEZAFTf6O8T0+CAIMOycfmkotA7KqyXMdynWwJgTWuT3w
	g0M3ilrc1QMATs5iftSXU7SY7rJ978MJ5SXit5/QowPMYPthNH5CWkMRlvl/jDeunv8kDcTROVzrL
	jXUp34bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guNqG-0004Jb-4Q; Thu, 14 Feb 2019 20:42:44 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNpd-0003Hp-66
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 20:42:07 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2019 12:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; d="scan'208";a="143557705"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2019 12:42:03 -0800
From: thor.thayer@linux.intel.com
To: lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 peppe.cavallaro@st.com, alexandre.torgue@st.com, joabreu@synopsys.com,
 olof@lixom.net
Subject: [PATCHv4 3/6] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
Date: Thu, 14 Feb 2019 14:44:15 -0600
Message-Id: <1550177058-1860-4-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
References: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_124205_403167_9941F15A 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Thor Thayer <thor.thayer@linux.intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add System Manager driver by default for SOCFPGA ARM32 platforms.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2-4 No change
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..c510a32f9f0d 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -109,6 +109,7 @@ CONFIG_SENSORS_LTC2978_REGULATOR=y
 CONFIG_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_MFD_ALTERA_A10SR=y
+CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
