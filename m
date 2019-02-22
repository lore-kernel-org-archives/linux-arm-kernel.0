Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB45A2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TrqTPEHE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2jjblP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB45A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OlPeZavctilhyjhSZGlk5hSeq0Stb78n14TOmkZTcXM=; b=TrqTPEHEspnEmj
	RadGSgCAxeOFP5eLXjpJdT/y11Zs1vMhYy5plABcfcZrXgqun604ZfDssMYv7b5iOEObmSOkdEhdi
	cLEr5T25bhZm8TiPZC6HOj5TwvG3qRXe60E4lwAh4A//yL67lqVoKMhqTinw4ZOUH4595dD2MKFBh
	gnFPVttR25r66kobvR/QcgEp4iGvfvryGRXIgcAeleV1ei/SHZbkrirrRYd4jAqeBS4B8HmTTd7zv
	t4A2nMoAojlqBRh4bQfsp1otYZyytlngdd5diGQANiCZEYpltV4sdebmvk/oH0O0Uc8Cmp9Dru9Yc
	EOd3SpkaZJVMWVbig24Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7vz-00024c-P1; Fri, 22 Feb 2019 10:19:59 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7vw-00023N-Rz
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:19:58 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so913084plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AooKzWveTVvTjP20/04jj799GvM5xIpT/iogDO3xN9A=;
 b=P2jjblP2DbX0scovVwuuZMh2AahuNzYnvArUx2qWaUl1TWzbf9qG7DIdNq9W5B/YKH
 J9t1d+3GUnSlt42t110jIGlPBLKOFeqKl2h0Hhy40UjJNx7/WLwepfBfAoOX/AwDr4Vi
 /yoHlcbA0NkRk3YrN19gkOFKSRSQiRoqtlolM8HOWc+LMfydPbJSMewiHsOZ0g6gtLBG
 /U1QbY2NLbYCMYAe6JacziHldc861GeIF4OF+0A+B/T8xjUkn/2H4CdzD/HLgddNEM1r
 tam6g3kJyX2bTcLpbbqmamVbhH3VJlct0HtIF6vIzyN2J4c3ODbTOgeijsdx2mXtyg+5
 oqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AooKzWveTVvTjP20/04jj799GvM5xIpT/iogDO3xN9A=;
 b=f+9U4gf7hvds5HJKMhS7BQV1pNLGUgGkjzykbEknGVufIeN3601qurmYU/fY7fcXek
 Zo+roxq8d0UiwRUg2MZ75KkuJTYdmHzyutBmNJ5aSp4YJBiKdIwoaQHJNGprTFaL8SBG
 nEMebnRbwEZRG3fRGyuj1w1r2t7YpDjHGubJDwd+oAttBVguPV1v+XXDnQlalrkLQVpT
 Zk4Mdmhg2E2l9w/r/ZhGHVYW0V9Gj6rUPWbM7AH6gvqTF7SQRpeJQ3KgIC3Z7ipyqk56
 1LPXYBb1Ok3Y0RorogHW5NZ+LJtF/0VMzk4lTHEd/WC0BGizYLEtsrPPF00Gz924yVUk
 KvIg==
X-Gm-Message-State: AHQUAubcZrjvyJZB1et30EwqrFoQIbayLydHcU+GiNg+CItiZMmjHNXj
 suZUOLvY8J/jwSsqlBP+Cqs=
X-Google-Smtp-Source: AHgI3Ib48zeEI1RhGoWcBODxTQfC23HdTer3t+Pap+ZtDoh6i9w4y3jmXfc1R4JFp+VExQMm5uJlvA==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr3287702pla.276.1550830795648; 
 Fri, 22 Feb 2019 02:19:55 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.158])
 by smtp.gmail.com with ESMTPSA id v15sm2835352pfa.75.2019.02.22.02.19.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 02:19:54 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Add pin configuration for read strobe for
 Odroid XU3/XU4 eMMC
Date: Fri, 22 Feb 2019 10:19:48 +0000
Message-Id: <20190222101948.848-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_021956_925845_8D8E99F5 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add Read Strobe RDQS pin configuration for eMMC to support higher data rate read/write.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 6 ++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index b82af7c89654..4fb3865e082a 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -206,6 +206,12 @@
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
+	sd0_rdqs: sd0-rdqs {
+		samsung,pins = "gpc0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpc1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index b299e541cac0..d41397748ed2 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -411,7 +411,7 @@
 	samsung,dw-mshc-hs400-timing = <0 2>;
 	samsung,read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
