Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E188AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50C7208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IdogA4he";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsvsDjz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50C7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GQVZofipzhas9jseKSwBk7j4znpVIVKE1i0JVFyVxHM=; b=IdogA4he0+9FKr18Kz+0+f1Mk+
	vZ8fqQgDLnruhc/N/GT713dlmGUjanX5Bz72UkIlh3Oe2CuBobzt4fo3WM4Ry5IF58dBCW5RRKR4a
	jFSTsHaiE00WQTbSXiDcM8nXHIQq6uLgTDEAi/smZTwjHimNfrEbGB+xURl7D/GQ7RiszHEx9gffw
	L4d128tK35nvNZiIAYT54eC091Xczf5LVNwJzifwmQqOUKBRh9cqh1ACPRpdE/Wn1ys2WiLOhQMDl
	90enQL6g83lTQ9y+11BNZzNU5JR9PqPMKOf1eVk/mDlYL7y3tvXL015cmlPFJfCAFix7NBpQmdCyG
	exznlE9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoua-0001cm-Mx; Mon, 18 Feb 2019 19:49:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvouN-0001S9-27
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:48:57 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF2D2217F5;
 Mon, 18 Feb 2019 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550519334;
 bh=Vwca8hO+LibGD8+0CJHWfALb+VJ+1t08azDOmNdrltQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IsvsDjz8oBRFEph6mQSW2JI8RHrp6tRQJ8t3v0UI5rJaEkAJQuQGmiqZllgJHXL73
 iugL4v6quoggKjBQvPUWVpGa1QFmtR0lbrUG2Hdfq6FxbgVryhFJkaoyDNnOIhC03G
 eFN9XmBqm82ASLyTIxFHAXFfMmGR0DiP870dSyKg=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: exynos: Order nodes alphabetically in Arndale
 Octa
Date: Mon, 18 Feb 2019 20:48:41 +0100
Message-Id: <20190218194841.21374-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218194841.21374-1-krzk@kernel.org>
References: <20190218194841.21374-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_114855_121667_6F55EE8A 
X-CRM114-Status: GOOD (  11.96  )
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

Having nodes and overrides-by-label ordered alphabetically reduces the
possibility of conflicts from simultaneous edits.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 2b227246c685..6b4bf5ee2e45 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -51,6 +51,10 @@
 	};
 };
 
+&cci {
+	status = "disabled";
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
@@ -323,14 +327,6 @@
 	};
 };
 
-&usbdrd_dwc3_1 {
-	dr_mode = "host";
-};
-
-&cci {
-	status = "disabled";
-};
-
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	vdd_osc-supply = <&ldo7_reg>;
@@ -724,3 +720,7 @@
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 };
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
