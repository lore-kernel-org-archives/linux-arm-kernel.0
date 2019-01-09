Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC620656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdRbZ5fZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MLC1Ijw3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NIaJPO57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=p6goObdiFZ0t98O6YlgAMAck9iV9A/1iRtmy7nC7htw=; b=RdRbZ5fZBQpJjR
	qvOJ92rfxe17myROLHnzvbGf+52InnIhXT7pGXyhhsABgWxg09CHQSLbd8LH2XENZL2shUr15kB8E
	2tYc/cWfUI3t8mhTdqWV5QjwtySlELKb0iCBkJVcdxC1oz5KoB9XzIEWWj7Too6SX+uA4N8S5W0ZF
	JU8f/8rBczIGr2rhomIuo/Imabzv37r6PSHo+M1ip3w4JWdsbKidbYp52G5Sl3XGrNbhQfGLnNolQ
	lTotFZjS+0DfTFMdaoctX2Lcv1pYFp/jUzvkQ2S7xKEBOOOdzf1BKUbFRadk04hsifA1x67z5466/
	NMSeXKjVZc2CJH84rcEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHx0-0001I7-KQ; Wed, 09 Jan 2019 17:47:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHwx-0001Hf-7w
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 17:47:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E6C32608A5; Wed,  9 Jan 2019 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547056050;
 bh=0gyYLuNtvHYhM3xrhaPPKd29npznhL5tuk39VI27em0=;
 h=From:To:Cc:Subject:Date:From;
 b=MLC1Ijw3LT0hVJUYkGRTD2Z0CAq2nhSfU8KySc5Kbd7DqSW1zOn50qL3P7VkX4zdN
 Us2XWYZcbNY/K8ay6UFnNAOm4v+dkbNUIJujAbeOxVpX6YOzA/MBmc+OoTWAYY4e1M
 LvUhCDLw+sbMrFZ2/C/gt/GjByc6tAOEBZirmif4=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E09C6050D;
 Wed,  9 Jan 2019 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547056047;
 bh=0gyYLuNtvHYhM3xrhaPPKd29npznhL5tuk39VI27em0=;
 h=From:To:Cc:Subject:Date:From;
 b=NIaJPO57LZljsVWqPPR08VplgWmrs2A0n+aCxaRhZpt6ETr2QvSTK6ymIHZreaJyW
 mYPNBRHGrqJ9Jd5IPuAPPjCUzrr2fnE5pxoKZHKNB+NGsrpXrV3hSr4BDqFD+tTvrR
 m5SunLbhvTRBDvVJVMKfbOSdoUBki8hT6csjHcMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E09C6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] Add coresight support for SDM845
Date: Wed,  9 Jan 2019 23:16:46 +0530
Message-Id: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_094731_306002_AE6C7DE6 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for coresight on SDM845. 

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 3 is a trivial removal of duplicate header file.

Patch 1 and 2 depends on below AOSS QMP patches by Bjorn:
 https://patchwork.kernel.org/patch/10749469/ 
 https://patchwork.kernel.org/patch/10749481/
 https://patchwork.kernel.org/patch/10749479/
 https://patchwork.kernel.org/patch/10749475/ 

This patch series has been tested on SDM845 MTP.

Sai Prakash Ranjan (3):
  arm64: dts: qcom: sdm845: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

 .../arm64/boot/dts/qcom/sdm845-coresight.dtsi | 437 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +-
 drivers/hwtracing/coresight/coresight-etm4x.c |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 4 files changed, 441 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
