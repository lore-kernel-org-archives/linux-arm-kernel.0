Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:27:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933B820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uAVwawl4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l6xq5uyX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CrdVdFQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933B820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ag+a08Vk7fFgaOMSvZZUByap7FRE53MCkByeftRyYHI=; b=uAVwawl4B0WeUg
	1b8cFIpbudC/Iwz82oHw1sOIFeOUv4xFbRewBusON0+tg7RoP2wxLq9I1E0ao0/89EsNlGcMKbVtL
	FUYQklSc4jaUsjiXeiKMCKhRJSP7tmc8Z/41hI1aniVk1V9dsx2pIyJrjboEsjCe0KeMR0yX81CMx
	i/MkvLidsKrYn+Lx+hPU51X9AGi03IZaKwb3Kv3HMLWoWy6DPoatSWne/HZMTpbhC/YzIs6HAMZNX
	mXjRE3JOmYSds+czPId3c7aD2K/uXgHdm+O/OR2Ft7cAu83WdXnmAUjp3CC0r9FPD+/XnCS20OtHy
	ZbWFUUCuB/HwRC8f890g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPV5-0006sL-Ou; Fri, 18 Jan 2019 08:27:39 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPUA-00064Z-Og
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:27:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 07C4D60A72; Fri, 18 Jan 2019 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547800002;
 bh=G2KKZ1YgnbqVxa2WE/cuZbIxiSMXXOjX9Q8vMBJnNSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l6xq5uyXws10ORG03v/p2Vncx9GxhXNjJ7tv/zCHhyJHPxYoMf6jo0o3GU8Lqy0Ve
 3ld+AOQQTODg/lwLXYQztE26usJ7EXN2Mx4EyuHMzuaorRVVSffpxLobcXzfMZJVow
 knTxxEnuOg6KeP2Nof+/NN0BkrcxkFsdFAGvcRck=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BD33B60A4E;
 Fri, 18 Jan 2019 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547799998;
 bh=G2KKZ1YgnbqVxa2WE/cuZbIxiSMXXOjX9Q8vMBJnNSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CrdVdFQIDYIuOiTP9jsnx8C4hnqrNfTkFDuRyc53Jtk08Sv4T1XNxNjEX7imW42fP
 LcAy6fms6tgxi9iwbHyVhMEzhNUME0A3PlGEsPNvRfCaLmHCqyoUZynUy3FlANGeT0
 yVU6lJMWFt0X2lcdhOdj/k3at3FYjrHGFKnNQ/tQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD33B60A4E
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
Subject: [PATCHv2 4/4] arm64: dts: qcom: sdm845: Remove the duplicate header
 inclusion
Date: Fri, 18 Jan 2019 13:55:40 +0530
Message-Id: <bfaedf2ec34025cccefc5fca28a98e72604fb53d.1547798966.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_002643_348518_325A2668 
X-CRM114-Status: GOOD (  10.55  )
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

Remove the duplicate inclusion of qcom,gcc-sdm845.h
mistakenly introduced by commit 6e17f8140521 ("arm64:
dts: sdm845: add prng-ee node").

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 848ce250722a..7314afb604ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -12,7 +12,6 @@
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
-#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
