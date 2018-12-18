Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B839218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuKnfLHK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FeP98yIY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IwAawjvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B839218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jkgsbK/svkiERHbrOMRqenHEw0ZzPqGg56vh05wApzk=; b=RuKnfLHKh1nykbMBPl5WzFW66p
	sZt9UxkbK0ZKyTo/pMpKvc94OTMkxaJ1fbWFtYU18Lllcpp6PVU1AAQ/imjJAzVOJTlB5tWM0WibG
	F5wwDduIiZO4YHwUgRVqf+25NeOdPwN25vsnTG+GyX4o/igrtlkoQZjh0u2MkgLGQ2FHTMYdAx1+k
	fsVIazuk28SyDTffAiYQ4ZqNc2Nwt0m3liFj4y/s/xaq3V+JFViho3Wy9vwxIJwlVY4NyBCR74KdT
	I33tEdJoAolYGJdhaxtpfcWW0zYg1qoMGtEP0XFUMsP6h90tBz2ZcvXSuG7nifSai1g5H0RSSxKSE
	wTnxe8UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKC1-0000Ze-Ti; Tue, 18 Dec 2018 18:34:09 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAs-00080e-5q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:33:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C6CB2609F2; Tue, 18 Dec 2018 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157977;
 bh=FKtdT+t1O5qh2QaBJ0LIE8c5gDcqKJMfSwN6B5oWbl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FeP98yIYB6he1J1oipmJsjhCq1vpZ7Z55QeennHfqr3EdKEtCbLtO4UwihzeNnfEE
 64FaiAqdOEdU2K96MxL8RlH/5V7Bk/844NqJ5ntZjvoTY4USseHkEyPVZNQu9NWVXW
 gViFhz1c6nikhHTlP3b2Gdv3TPy9WMXkBusyI1ws=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C293609D4;
 Tue, 18 Dec 2018 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157971;
 bh=FKtdT+t1O5qh2QaBJ0LIE8c5gDcqKJMfSwN6B5oWbl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IwAawjvl7ewMQws8Jfx1FMcUKr+MlH9moAfqS1JVM1GIytJP2lH1HkahnmLITfdNs
 hvDeQZjyx0jkhUKhvI5HjSLNOwGnx/8sEPgWGWaLCR8gaaZtBE2+gZyFkgT7oNNd2F
 NTrKJq78XBtG+aQNFIyHmp5/AYXDqlJxy3suPLZI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C293609D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 4/6] arm64: dts: qcom: msm8916: Remove unused
 interrupt-names from GPU
Date: Tue, 18 Dec 2018 11:32:39 -0700
Message-Id: <20181218183241.12830-5-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103258_231331_FD2AC423 
X-CRM114-Status: GOOD (  10.22  )
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

'interrupt-names' shouldn't be used in cases when there is only
one interrupt and it is not otherwise used in the driver.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c5348c3da5a2..846de1043e4d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -880,7 +880,6 @@
 			reg = <0x01c00000 0x20000>;
 			reg-names = "kgsl_3d0_reg_memory";
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "kgsl_3d0_irq";
 			clock-names =
 			    "core",
 			    "iface",
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
