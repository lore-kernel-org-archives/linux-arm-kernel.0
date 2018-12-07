Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F59C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720D92083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qtCElXj1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuOgoqwW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E71T0iqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720D92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t3D8yijTbzAzdx+lol65Z+UmDRDAaJz0EIyGuj0geWQ=; b=qtCElXj1klkLND
	eIE+dgfFqAqoEoOn9Wfc+UZUjqIzp9VNOA6Q6kGpO8kS2m3UA3h6IBX/GREELShJTaEVqw2bximzN
	HbwV/Ostr4ocgQMVsVY84868P/MoGsyXTtfBNfd0yArc4HaI/+bZdG+nCZbd7teIKUUZS4JwHVo6B
	ku4DJLuVW6LnjHx7P1516gOMmZSJ364ASUxQ0fgrXJNfv66jlZ9ZrFt9nhydGOWBxeIbsQIrLFh/7
	Cqs7J40S/aPGUhVaBTQPrKuq0aAdwdHCEnJukFi5nu91476iImwuKbuUx0PNTMxbcuEoDIjzKCTYm
	mATVinfEDuUsv014ifZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCf0-00078L-8U; Fri, 07 Dec 2018 09:43:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCey-000744-1A
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 09:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2jKxkI220R+5wuMTqsBOD2PoFL9puReITo+PnY2gRUU=; b=LuOgoqwWy84SYUa2KJNp/3GUHu
 G+F/ULAgDHRXTUakUg3dnSQS8oCxa9fLfR5zMWSuOzpgjIjrf07S37lklqFGuFyU5U8DeZmgun27p
 EGkSodOpWIuIwYoRxQNeomXf8h2ETd/AgugthrhQr8DNaXjAhJ0iWpBp0mnaHS0aH4pHj6XdSaDv8
 sghy2xxsV/6OJCuPHcZ1NGzRHTFG25C6ZBa/gXiN9DLCG7yO3LXYk0htaWjw3Gua8oxBVVEH6zL49
 +JGNdVj3GWbiLT75BiM81cgA0wJsVBa/0cWMkqeyeukgI5G9YgZ3RVAu3QzmtE5EImmBYR2hAMMtj
 WPt5AyKQ==;
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCXC-0001wI-RT
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:35:00 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB79Yh2H003670;
 Fri, 7 Dec 2018 03:34:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544175283;
 bh=2jKxkI220R+5wuMTqsBOD2PoFL9puReITo+PnY2gRUU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=E71T0iqzERnOFhSac+xTi86T/VbDsQah5ijHH2yse8h1YinaIkRJz2kjzHvW7lplo
 +v4TmX00rD4fEjDIkV55RFmjgZ+12y64F5D9HhdS1r9dxXrfTXfsQu7j3f1/1+1ROn
 CsTPdeFWKStEOlnVHk3X8Fue8bcnKK5pC58tb5nA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB79YhI6064472
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 03:34:43 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 03:34:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 03:34:43 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB79Ycw7011818;
 Fri, 7 Dec 2018 03:34:41 -0600
From: Vignesh R <vigneshr@ti.com>
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65-main: Add ECAP PWM node
Date: Fri, 7 Dec 2018 15:05:34 +0530
Message-ID: <20181207093535.5497-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207093535.5497-1-vigneshr@ti.com>
References: <20181207093535.5497-1-vigneshr@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_093459_085469_5D6F3E45 
X-CRM114-Status: UNSURE (   8.39  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT entry for ECAP0 PWM node present in main domain

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 916434839603..0a0a8fc5df64 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -129,4 +129,13 @@
 		clocks = <&k3_clks 113 1>;
 		power-domains = <&k3_pds 113>;
 	};
+
+	ecap0: pwm@3100000 {
+		compatible = "ti,am654-ecap", "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x0 0x03100000 0x0 0x60>;
+		power-domains = <&k3_pds 39>;
+		clocks = <&k3_clks 39 0>;
+		clock-names = "fck";
+	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
