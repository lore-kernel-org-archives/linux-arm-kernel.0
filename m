Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0E2C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA4E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dsSXX0nY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O7P94ppD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b2WJe0Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA4E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ycq+lmBrljUiL05wlrWFe2APaXZXPWg1omTG3vtjKyg=; b=dsSXX0nYfmADSq
	aRRvu+aLQX4l9dU2CMK2wVWV3KypI3tLi7Sy22PudD93IZ7r4s3b2C4qnwc0nuqNNS5pORDUe4ti4
	A4Vor2goGvML5JKkYwipO5wDiom6lFKJN13q5AeCuEmv01Pbk7wTV6UZai+rrdV1BuIrJLV0ex2Cr
	Pb34WGtu/9pziTKfCq/jAhYhfaolW0UevbBaA6VXnE3S2nhwb05IVWGioYQ+9N+7j3aDl1w0MXmDQ
	FwHxDyh0rdKQ/GllOqBG0M+TP9e0dJDB7ZmAh5B4RXM3Jgw5p43+xpOQP9MeCHqT1fU79YA7zFG1r
	+kiLz4wJt70WWg3GAEwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCMk-0006tH-DU; Mon, 28 Jan 2019 19:14:42 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCMf-0006sE-R8
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:14:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 599BC609A8; Mon, 28 Jan 2019 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702876;
 bh=Eu0BYORbrMw6PC4869PdS5UYuwwVmzQ7YHfLjPUBj2g=;
 h=From:To:Cc:Subject:Date:From;
 b=O7P94ppDv9dAtn4A95KQjTmg48pBzBEvTUpCiUzZ7Hvcjc/JwYbD9clWaj4RvSor7
 v83D9ZXiy6j5w0wti3DLYDYUeTMq0c2YGJJn2hCz/yZ9MESsCsEhRckDPSTeF5g66n
 cR5eRgrZbNPenPFEAubmXiju7GZYwj9XIljL9wJQ=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CAE060B3B;
 Mon, 28 Jan 2019 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702871;
 bh=Eu0BYORbrMw6PC4869PdS5UYuwwVmzQ7YHfLjPUBj2g=;
 h=From:To:Cc:Subject:Date:From;
 b=b2WJe0Sza8X4A4Rv9G3sK/tJUmo9XvAbyYkyIyAUHpTqIRxd2PTiUV6AIf03QKOCI
 kg4VN3Lq2Fu/NldZ0V+lfJVQpjydCsNMEoF0TNONIWVMvvuBBXu+OckVUZTuygXutb
 0ylTxcuFCR+S0AvJZQg9qYB6ANcwyFbCePqxPBU8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CAE060B3B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Doug Anderson <dianders@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCHv5 0/7]  Add coresight support for SDM845, MSM8998 and MSM8996
Date: Tue, 29 Jan 2019 00:43:57 +0530
Message-Id: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_111437_937175_9C356CDD 
X-CRM114-Status: GOOD (  12.26  )
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
 Tingwei Zhang <tingwei@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for coresight on SDM845, MSM8998, and MSM8996.

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 adds device tree nodes for MSM8998 coresight components.

* Patch 3 adds device tree nodes for MSM8996 coresight components.

* Patch 4 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 5 adds ETM PIDs for SDM845 and MSM8996.

* Patch 6 adds UCI table for coresight CPU debug module and
  also adds a helper macro for making ID insertion simpler.

* Patch 7 is a trivial removal of duplicate header file.

Patch 1 and 4 depends on below AOSS QMP patches by Bjorn:
 https://patchwork.kernel.org/patch/10749469/
 https://patchwork.kernel.org/patch/10749481/
 https://patchwork.kernel.org/patch/10749479/
 https://patchwork.kernel.org/patch/10749475/

Patch 2 depends on MSM8998 rpm clocks and rpmcc nodes:
 https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
 https://lore.kernel.org/lkml/8f431bde-0e67-8088-5119-7a951d0ead52@free.fr/

Patch 5 and 6 depends on UCI support by Mike Leach:
 https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/

This patch series has been tested on SDM845 MTP and MSM8996
based Dragonboard 820c and MSM8998 MTP.

v5:
 * Added coresight support for MSM8998.
 * Added ETM PIDs for SDM845 and MSM8996 as suggested
   by Suzuki.
 * Added UCI table for Coresight CPU debug module.

v4:
 * Mask out the minor version as suggested by Mathieu.
 * Added the dependent patch description in patch 1.

v3:
 * Added arm,scatter-gather property as suggested by Suzuki.

v2:
 * Added coresight support for msm8996 based on Vivek's patch.
   Cleaned up and added coresight cpu debug nodes for msm8996.
 * Merged coresight dtsi file into sdm845.dtsi as suggested by Bjorn
 * Addressed Mathieu's feedback about masking the minor version in
   etm4_arch_supported() and added a comment for reason to bypass
   the AMBA bus discovery method.

Sai Prakash Ranjan (6):
  arm64: dts: qcom: sdm845: Add Coresight support
  arm64: dts: qcom: msm8998: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
  coresight: debug: Add Unique Component Identifier (UCI) table
  arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

Vivek Gautam (1):
  arm64: dts: qcom: msm8996: Add Coresight support

 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 434 +++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 435 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 435 +++++++++++++++++-
 .../hwtracing/coresight/coresight-cpu-debug.c |  41 +-
 drivers/hwtracing/coresight/coresight-etm4x.c |   7 +-
 5 files changed, 1337 insertions(+), 15 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
