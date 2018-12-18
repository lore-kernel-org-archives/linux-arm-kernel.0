Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B31C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064E9218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2XdFsFR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j8DS1Y+A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VfwI1U0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E9218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eraDAoUIQfBVm4Mlo2k0v5qWScrvq9FUxTWtVHcZMtw=; b=g2XdFsFRwIBfhrgfDsc8oIS1d0
	5SgiVmhes3HTL899EpviVLiR+ufuHoFWvPDtQqsz8PIFseiDAUgvMVVgzp55c6yCAA7ELsh8/J+gB
	l0hvPcOKGcKP6JyEFSs8l+xA4rUywcFN9iwPlv58VoWPbjjYx9byqsPt9n07PPmX48twuxK3XnX+F
	fPpV2+xET4WaZjbIu/P0Mwi1u2RtnmnhAed5vDXl3/B4a0zvLxBd/1uP1IsEAHIMMqsgWu5OfF1q4
	sI3jruMpkEmK0zbEOF+/j+ug8aLdBpY98z5hzXuD3ZguWUwbOKNsBej6IWmGx8LarCBenMu1ujGNu
	qrITc7ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKAu-000819-Aa; Tue, 18 Dec 2018 18:33:00 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAr-0007zB-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:32:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 5AABF609C2; Tue, 18 Dec 2018 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157970;
 bh=ejUSMwSvzr72rCzYagqybBF03IsN7YGJdY+di+igAYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j8DS1Y+AWTNh1bpjwCgV1Ay3aB8cavJGCQd7GHmN+rCE+RdmDmpEib/GsT/XKJmKE
 4s0tRSae786c2APr05HCIBy7/r56Y2v8kxgIqoeLIjyzQnaUsQBApyr58HkmqgiT2b
 SZnKOyhbLTBB2Q21DCzg85PWSCo4Ulh1MhqQJR/s=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8ADEE608CB;
 Tue, 18 Dec 2018 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157968;
 bh=ejUSMwSvzr72rCzYagqybBF03IsN7YGJdY+di+igAYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VfwI1U0cyLfdOWR/SkQgyAJ1YzJjHFB+yygZ6k/yPmqO5MUvYo0uTy/zukoiCx8h4
 +a50c0dvX1gVPjz6fM+3n89z32s7kBiM+r9YhKNeyQsGmN6I9PcaZGD5amhlJ/NWsO
 Xi0i1nOJjkR7u4bDK+g4cLsvpXKOz4jWFHAfZRtI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8ADEE608CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 2/6] drm/msm: drop interrupt-names
Date: Tue, 18 Dec 2018 11:32:37 -0700
Message-Id: <20181218183241.12830-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103257_392781_D4F3BE41 
X-CRM114-Status: UNSURE (   9.43  )
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

Each GPU core only uses one interrupt so we don't to look up
an interrupt by name and thereby we don't need interrupt-names.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 43fac0fe09bb..4ad5e70e5c3e 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -25,7 +25,6 @@ Example:
 		reg = <0x04300000 0x20000>;
 		reg-names = "kgsl_3d0_reg_memory";
 		interrupts = <GIC_SPI 80 0>;
-		interrupt-names = "kgsl_3d0_irq";
 		clock-names =
 		    "core",
 		    "iface",
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
