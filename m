Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:34:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BFE20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n4ouzaGJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xAq2P3DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BFE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/a9VSHQLzbPeuUOpXBGvEocH7fCGtZV5AfFy3ThJxec=; b=n4ouzaGJROGcqTnZpPNNdhnoyc
	Fg6CvKBZ3Hf8aEeBEddsui55GG3YVGMnKDT3aRfoUhWwV+aulpRGhDl9JPan0PPIEtuAMxPye3cRK
	Wb4tdbN5Kj068Sr2NGpPxOUu48ceD+mohufscS4lcmtDcRnV4DDJmPu6HzOMFjnvKeaRXPQJG0uuR
	FUnLa1KLl2bGL1Dy0v2dhDhDSHXitilpXSVAeDhcprK0MRaJQnNMyfg09LQOZsq2x2ls45bS96AtH
	sQeq4N8RCuK8BBjpeY+i+6843UvZD8grB3Jhh1HlmyDgW/a5B7jqSXzMNgUntqoYOGKZ7v5pgMvWn
	3MfH5rdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmnu-0002KN-2C; Mon, 18 Feb 2019 17:34:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmnd-0001yW-DE
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:33:52 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F24F42177E;
 Mon, 18 Feb 2019 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550511229;
 bh=lK+JHr7EO0NyLhpmUHMOKSsymoC78ioH0CGzMJHmkDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xAq2P3DPn+Y2Fbda6cAhas0pnMDZmtoqu+WL503tCX3dz8s9VnDtZSqXlTkNjzOgM
 8i15G6qEunRwuTsI4TfScK0YJkJyHIE5kpYEbawYVJLRQwqiCwSgggVx0Utx1sul5m
 cUVy5e8Sd2/1LNVlh160gfM6EMBdYL3MwH2E7eME=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: exynos: Raise maximum buck regulator voltages
 on Arndale Octa
Date: Mon, 18 Feb 2019 18:32:58 +0100
Message-Id: <20190218173258.7071-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218173258.7071-1-krzk@kernel.org>
References: <20190218173258.7071-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_093349_872203_DD548D6B 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: Markus Reichl <reichl@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Raise the buck 1-7 regulators voltages to allow cpufreq choosing them
and to fix warnings during boot:

    core: _opp_supported_by_regulators: OPP minuV: 1250000 maxuV: 1250000, not supported by regulator
    cpu cpu0: _opp_add: OPP not supported by regulators (1800000000)

The maximum value is now in sync with other Exynos5420 boards with
S2MPS11 PMIC (SMDK5420, Odroid XU3 family).  This also matches the
values used in old patches done by Linaro Samsung team.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 308c74ebeacd..c7d9604a119e 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -342,48 +342,48 @@
 			buck1_reg: BUCK1 {
 				regulator-name = "PVDD_MIF_1V1";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
 			};
 
 			buck2_reg: BUCK2 {
 				regulator-name = "vdd_arm";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
 			buck3_reg: BUCK3 {
 				regulator-name = "PVDD_INT_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 			};
 
 			buck4_reg: BUCK4 {
 				regulator-name = "PVDD_G3D_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1400000>;
 			};
 
 			buck5_reg: BUCK5 {
 				regulator-name = "PVDD_LPDDR3_1V2";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1200000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 			};
 
 			buck6_reg: BUCK6 {
 				regulator-name = "PVDD_KFC_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
 			buck7_reg: BUCK7 {
 				regulator-name = "VIN_LLDO_1V4";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
