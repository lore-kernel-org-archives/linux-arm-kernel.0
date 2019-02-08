Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF52C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F149E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F0Z8c1nF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be+y5TiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F149E21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CulQ+K/ccaNmjI9zpDMj4KyeFMlaoNKywbeiEZdxagU=; b=F0Z
	8c1nF9ZitgYWIszVYqYz+FI9kxshkhaRi9m612qbiVyyAHZlC41X1apSJ8+vDCN8DxANaMaHyC7C4
	x09O3KL9XWI6+VMk9wVq5k8IepMWBp6ZxPlBRBG5y1j6gQd2uhHFSQjgSiEZM4YnBZeWvdpMIPa/L
	U7udrWqV70OZXp4EnaqPuc5iFkeHJs7QBKF9hIocTjC8TMivaHKzHtb4BpN3hVrX7gYmeAWzJ1sAn
	UHkzLXZBWMSSQPGeMS3o3P8ptKnozRDTsVY++6VJG0lrdM3P2IqDswnYVzYmkc2ByqTAP1XyoPMRO
	2n08BPwyrdjz633ZkGgD5/dRgrk87xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsFDk-00020B-B6; Fri, 08 Feb 2019 23:06:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsFDg-0001zo-Sf
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 23:06:06 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C28421841;
 Fri,  8 Feb 2019 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549667164;
 bh=RKeYqyX82OZ4vC/YqDjtsL2Y4oWIh6XE77hXUdP9Fu4=;
 h=From:To:Cc:Subject:Date:From;
 b=Be+y5TiDxnAUeVC3nXGEzvibJHr8aLh9FuHuIBJIJv5TFLLWQPuFPt9KcWhfWLpo4
 I42jM53Wzf0ZtQgDD5luR9yruC3XtP4SUHDqHF2dPUdDsM6lhvuKuapZoWfZV6QaRQ
 dMIxchZftI34SXAMw8xeuqiKFprSUSPACVgxYb94=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Enable ADC on Odroid HC1
Date: Sat,  9 Feb 2019 00:05:57 +0100
Message-Id: <20190208230557.9292-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_150604_947331_DE36B5C5 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Odroid HC1 uses the exynos5422-odroid-core.dtsi file as a base.  All
other Exynos5422 Odroids use the "common".  The ADC node was defined
only in the latter.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 5 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab90f8a..9b0bccb77be5 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -36,6 +36,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo4_reg>;
+	status = "okay";
+};
+
 &bus_wcore {
 	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
 			<&nocp_mem1_0>, <&nocp_mem1_1>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index b299e541cac0..5f195ad7e467 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -362,11 +362,6 @@
 	};
 };
 
-&adc {
-	vdd-supply = <&ldo4_reg>;
-	status = "okay";
-};
-
 &hdmi {
 	status = "okay";
 	ddc = <&i2c_2>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
