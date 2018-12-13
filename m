Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C82C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90B620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NawsxRaG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L6zA7z45";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nUj2T9BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90B620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KbX1T3DHvHmHylBAxo0WocG1lYZv2oX2C+/fG9Sbt2k=; b=NawsxRaGkofmJMVLrN/UyARoEt
	bm2B10Xhuhhqovxh195oBs1Gnv4SRlcEYKYUFuEluVqeLh6++l2Fx2he/kiNcqyZJAMJEA25elECt
	k9qiQONn2cgwxCNq3ssJHDU7Zip3DolqGzf022vkFp8cZcOnQw7wVYX5s8SJD4WwnIqLgQp4yQq+i
	HhNehq1nB9Ae2dN5tS5kMQLpUt1KHvTMYKrRQBDLD1MQuFBnins/jKVIB9WGbt0RMXmLELb/YG7B/
	7umsuzYSNGy6nTlq/kJEcoLD26XAdeoOhZD68VXa0MM+yMlv9eonDq+NG3Nyw4kuD4wPF1zcuPec0
	jwSai1mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUqj-0004Gl-KU; Thu, 13 Dec 2018 17:32:37 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUqF-0003lF-GU
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:32:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 42303608C6; Thu, 13 Dec 2018 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722318;
 bh=HDpupgHnvnBtYCGFcEvdOzAXRFpgGdSUS3vcU+N30mk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L6zA7z45Z4DDPdAoflrOeLy2lb02QOi3XnnYFbr2EIsuslSU0fVPPkn3pXHpytkoh
 lmjEaIPTUSW6tJZ/EfT3QQAwewgBj/J8eZ8A2pWDBIiJOqTbc8vOo4p8KEdfVQNVHe
 8PWqhp2ik8f7F5MWln+N8Lz7WUJdUfOiJk5/o1wg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 93E5E60132;
 Thu, 13 Dec 2018 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722315;
 bh=HDpupgHnvnBtYCGFcEvdOzAXRFpgGdSUS3vcU+N30mk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nUj2T9BRJ711iKdgledpHU/WQc6gF23lp2EwEpU40R8glOeAF7dcsnN+WbEV/HSEX
 ki3L3f28r5QhVby+kkUk8cm1lsiQ7Tt2RvvwmS/tOHT32xUHicjKu1jrwc75o0J88D
 oSR6KQ2JZPjuXcDtQ7z+kZ70rcyxO/Qf3stvd1P8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93E5E60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] arm64: dts: sdm845: Add interconnect for GPU
Date: Thu, 13 Dec 2018 10:31:49 -0700
Message-Id: <20181213173149.6975-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181213173149.6975-1-jcrouse@codeaurora.org>
References: <20181213173149.6975-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_093207_573983_10A4818E 
X-CRM114-Status: UNSURE (   9.77  )
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
index 0a5ddfc4c59b..9323f211ca40 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1370,6 +1370,9 @@
 
 			operating-points-v2 = <&gpu_opp_table>;
 
+			interconnects = <&qnoc MASTER_GFX3D &qnoc SLAVE_EBI1>;
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
