Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB4D20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4F6miG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB4D20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xWFEeGtAw+e8mor7dtddkTHtGf+28NjdqE008M51duY=; b=a4F
	6miG00ZeJwvNWa6klm1ZyE7gBQL4LAbD9e5erZ2Thl4lZYx2Q0zMrtKjqykKthls9adcxSG6+SAuc
	hcDLbfJOfHzyltmScAgydGRUEjkZtgrRjeYhbrJ6Z58W3i7jof2q6sEHhS5IIyITAAFAXNurMCNM1
	/FWJ8T2k3Lgj8T+jEcDBSDQPvh4jaBK1AX5Nuvys+c88zyD5PX0nNX8aIGuRCQL0vAgC3PNcskVTB
	/gVmS2Z+kWvui24brXMTngIjcG2yP3lc3Q6xtU2qEsxXM4uaKI5jvBKfDCUWpGLV0b6B9dPHWSP/7
	YcoS77vCF6vHcLZpH8z3RkCnb6yuHlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw78w-0006L8-Tr; Tue, 19 Feb 2019 15:17:10 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw78t-0006Ha-IH
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:17:09 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 07:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; d="scan'208";a="125586257"
Received: from marshy.an.intel.com ([10.122.105.159])
 by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2019 07:17:06 -0800
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 olof@lixom.net, dinguyen@kernel.org, atull@kernel.org, mdf@kernel.org
Subject: [RESEND PATCHv2] arm64: defconfig: enable fpga and service layer
Date: Tue, 19 Feb 2019 09:24:17 -0600
Message-Id: <1550589857-10359-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_071707_906645_A8A89964 
X-CRM114-Status: UNSURE (   8.09  )
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
Cc: Richard Gong <richard.gong@intel.com>, todd.riffel@intel.com,
 richard.gong@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Richard Gong <richard.gong@intel.com>

Enable FPGA framework, Intel Stratix10 SoC FPGA manager, Stratix10
service layer, and Altera Freeze Bridge drivers.

Intel Stratix10 service layer driver was added with commit 7ca5ce896524
("firmware: add Intel Stratix10 service layer driver").

Intel Stratix10 service layer provides kernel APIs for drivers to request
access to the secure features. Such features include FPGA programming,
remote status update, and read and write secure registers.

While clients of the service layer can be built as modules, the service
layer itself has to be configured as built-in.  The service layer is
dependent on ARCH_STRATIX10.

Enabling Altera Freeze Bridge depends on commit 38cd7ad5bd25
("fpga: altera_freeze_bridge: remove restriction to socfpga").

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: add to enable FPGA framework, Intel Stratix10 SoC FPGA manager and
    Altera freeze bridge drivers.
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 931429d9..96c52f4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -733,6 +733,13 @@ CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
+CONFIG_INTEL_STRATIX10_SERVICE=y
+CONFIG_FPGA=m
+CONFIG_FPGA_MGR_STRATIX10_SOC=m
+CONFIG_FPGA_BRIDGE=m
+CONFIG_ALTERA_FREEZE_BRIDGE=m
+CONFIG_FPGA_REGION=m
+CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_EXT2_FS=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
