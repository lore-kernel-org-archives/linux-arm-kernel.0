Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BED206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Py4mspUi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sz5ejquE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TiTA0LW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BED206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tE9W7fOX6VtfqYnDq/4R5KJEj11c+hafmgANf2X27Ik=; b=Py4mspUiNNiDB9XyvMU0bPFIbD
	iDCWoC/73eRHgYpQGREnGYpY8IackFDjwqTFBOWtrUtk7lWQnGggXSqQ9YvyC3srgZVIRNPIvg47A
	BcLn6OIOwZi5FuR6nU6gn6AobID32ML9RVJ+yK2UMq0uQ8doCytEM+5sXkpgx8R0vm/1edMRm6UV6
	sclblB6kD4YA1WKHcHQbGKKBwRvn3onlOItP2VdiJuGhn74bqVEIVls6yFujuvG9hfeGXSTv2euBu
	elZDMltjZCVZJaNM1Tuk6J1ZZ1DAaCVeewZPqfWrMVnY5Do5qY/J6na2OKGjfVgsv44mRhXP1lRPh
	oojvmW8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvlT-0006JS-GO; Fri, 14 Dec 2018 22:16:59 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvlQ-0006IM-6v
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:16:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 491B060734; Fri, 14 Dec 2018 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544825807;
 bh=I5BUWVLVDXIzBcZU7r1vij9+pWJDwRJdv2Ml7au10m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sz5ejquEpXpKv4B5TnPg1JsmsbXs7OkIJiGBOjUSqVJrZBnUytIBKvaSeMAc5Mfqs
 X1U4tFZ35sPaCo6X+b3ZIQvaDCk2+vVudhj/FsBGmpsZFSNjr88xdV1K0GlNNT8MSY
 1O9bLvGl3ZKO6L4xhDUdEeWsTsEH7RgxWvBSgTFY=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C7EA460734;
 Fri, 14 Dec 2018 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544825806;
 bh=I5BUWVLVDXIzBcZU7r1vij9+pWJDwRJdv2Ml7au10m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TiTA0LW2DJFSWFl/lBKBUUovaxBz9/vZo8f/iFUAdkUQ3onNw3GdQncvmAFqSOFvN
 +NNDGdIZBfJcv0j6jyX2Lg6V4LFEzWXAi79e6GOb9AKWCjXdxpDoUT9C54fEJTPGrs
 fbHaa+YJbXgjRYA/fL5LCc643HqlXkddYTmXBulo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7EA460734
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] arm64: dts: sdm845: Add interconnect for GPU
Date: Fri, 14 Dec 2018 15:16:40 -0700
Message-Id: <20181214221640.25354-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181214221640.25354-1-jcrouse@codeaurora.org>
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_141656_271624_1C192F37 
X-CRM114-Status: UNSURE (   9.78  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define an interconnect port for the GPU to set bus
capabilities.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a5ddfc4c59b..2acfea87716c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1370,6 +1370,9 @@
 
 			operating-points-v2 = <&gpu_opp_table>;
 
+			interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
+			interconnect-names = "gfx-mem";
+
 			qcom,gmu = <&gmu>;
 
 			gpu_opp_table: opp-table {
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
