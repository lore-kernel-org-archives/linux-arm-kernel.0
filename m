Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:26:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC502086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rXSYVFeF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TnhDOyU8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R3WX6vR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC502086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QJdcYrBdsdOhtMe3VTF8dWcyZ52Cmw72y051z438tkM=; b=rXSYVFeFL7+nCX
	PpKOxREE5AQvGtW0xzjKAEIn37fyj9V4XzluePXX/5SPfSnaEoN/upO7+R6tcGAPP31rBAq0+PKaD
	/v7XcCNsNWGsYT7wyPqo85aeFqpBYizCUgZNORTydXidvcsILYsv2GtsP/ULWCj7VU8YWovzkhT1E
	IyAepx1/hD3qrd3gq4uW6bPBSFQqe8v68/YvPtfvBa5Qy4h7oYWneKxEyWWOplbvfM8O161pHFEPe
	c1uxjpUULWKEYclqOL0WK9PAG3mCL5zzQwt1c+YE0UOiHAygMNt++t1AZJCGFug8jAxMwIHpPKOJj
	gYPb4cHt33ZDeE/PJuGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPTg-0005Z2-GZ; Fri, 18 Jan 2019 08:26:12 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPTd-0005YR-KI
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:26:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 934DE60854; Fri, 18 Jan 2019 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547799968;
 bh=6mDZy73iN/Ttx97sfzAASuw/LjJA99QPTyUzBdq/J50=;
 h=From:To:Cc:Subject:Date:From;
 b=TnhDOyU85VeiMLObC0qg2UcLeDvgyV9lIGNxO+sN4JVP4XmUdSBkmRAXuM5y1vBSp
 DM6kk/ul4NhCdSxPaTXpVsrKzpUjoC4sEdQrA+xznMUjOxNvV1wd6By9h3ZtaXoLVq
 1yil1Yb9AbTgC1Scg40nEIg+QUMqAeXwklb69z0E=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A9797605A0;
 Fri, 18 Jan 2019 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547799967;
 bh=6mDZy73iN/Ttx97sfzAASuw/LjJA99QPTyUzBdq/J50=;
 h=From:To:Cc:Subject:Date:From;
 b=R3WX6vR3nocDkykEfgT7q0qt0miW30qqx20KNzdC8bG1bCRv3grnbqgV1lHbWSmD1
 lCOzdb0c/N47TdnxrtJPf5l8b3z7Sj5jT629fWfQjRuqdO+tJjYeQGQYOmafQ8LkgG
 1WptvKNRBQnzB0r1jKLPhz+AweeFkDHmcmj/k4rw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9797605A0
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
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 0/4] Add coresight support for SDM845 and MSM8996
Date: Fri, 18 Jan 2019 13:55:36 +0530
Message-Id: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_002609_715917_43BC9AD0 
X-CRM114-Status: GOOD (  12.46  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for coresight on SDM845 and MSM8996. 

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 adds device tree nodes for MSM8996 coresight components.

* Patch 3 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 4 is a trivial removal of duplicate header file.

Patch 1 and 3 depends on below AOSS QMP patches by Bjorn:
 https://patchwork.kernel.org/patch/10749469/ 
 https://patchwork.kernel.org/patch/10749481/
 https://patchwork.kernel.org/patch/10749479/
 https://patchwork.kernel.org/patch/10749475/ 

This patch series has been tested on SDM845 MTP and MSM8996
based Dragonboard 820c.

v2:
 * Added coresight support for msm8996 based on Vivek's patch.
   Cleaned up and added coresight cpu debug nodes for msm8996.
 * Merged coresight dtsi file into sdm845.dtsi as suggested by Bjorn
 * Addressed Mathieu's feedback about masking the minor version in
   etm4_arch_supported() and added a comment for reason to bypass
   the AMBA bus discovery method.

Sai Prakash Ranjan (3):
  arm64: dts: qcom: sdm845: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

Vivek Gautam (1):
  arm64: dts: qcom: msm8996: Add Coresight support

 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 447 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 448 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.c |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 4 files changed, 896 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
