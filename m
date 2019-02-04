Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB04C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:41:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4781C2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p46MZmFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4781C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xWFEeGtAw+e8mor7dtddkTHtGf+28NjdqE008M51duY=; b=p46
	MZmFrH/wl9D3Z7xIbsP96NP/MHyUHkBFwXXrVJAGsRQusc44KK0Ef8ZvkJ82fDWuxRXXHVVvI83NY
	8MCLTDgGneWDljOL+ykKDkTJEVumC71HNRB//gGvAYnPQO6gMOEpFh0DdxC7bc1QT5TDCOQgO+rN7
	vN7e2vBHYDFAO4yXdJF20ZedV01tg1GNIb6GwAHICkOzmimAxVs7fw9N8rVmPXxcwPhQxYJyMW1ES
	cvb3pSsVgIyrE1Kw9o1IV7+7k/d6pClwe8AF8GJOUUug0lZTQa5K8Be8sLos6+lvOteY3LCLPN77d
	0G7S727RZwPtabi0IQ/kH6z29SBPJ9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gql39-0003UH-Ty; Mon, 04 Feb 2019 20:41:03 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gql37-0003U0-Oa
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:41:03 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Feb 2019 12:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; d="scan'208";a="140624638"
Received: from marshy.an.intel.com ([10.122.105.159])
 by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2019 12:40:59 -0800
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
 atull@kernel.org, mdf@kernel.org
Subject: [PATCHv2] arm64: defconfig: enable fpga and service layer
Date: Mon,  4 Feb 2019 14:48:37 -0600
Message-Id: <1549313317-22964-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_124101_850895_231981A8 
X-CRM114-Status: UNSURE (   8.05  )
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
