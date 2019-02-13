Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DCBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9603222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K3pG6XCP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmteZ4Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9603222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MC64kBcEUr385xBCR5+Mu+OStJGBob14eGQeIlXRXU0=; b=K3pG6XCPiJwlMjywStEatV2rN1
	Nb/3PEZtSdTn5z1befaURoGpEYojyuCpz8Nvwf0xeBtsQJwlCWi9S35lEWkowRk65LAbOy845CYiY
	hwEmeFpjhJDBVDflTIKe7MD7nipGxlQf6NIAWBCJ+ywPTOwfscD9+xabiR1RTXmZL62jtM5n+K8dD
	VJbGDY4gnb4NYFKY/uhhKWm0FtWLEi5YNo8N830S6+2U5Ct1U06r2THml1JXrGaNYmcCFZsWttwrh
	QOFk/A87LgXSjCbW1jLO3iGaZALSXKxhZfpwklmx9pRgKgm1fWtYCLmj5Tht7bivo6U9XM/BA2qhF
	JH3iGeSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttmr-0008Mz-6N; Wed, 13 Feb 2019 12:37:13 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttk4-000660-Ex
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:22 +0000
Received: by mail-pf1-x441.google.com with SMTP id b7so1077715pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=FGaARlyO45jSVlRCo3Ba46kwztIqiQvxEWOsLPfUyBY=;
 b=tmteZ4Yadx1Xj9sG8FjJzb/XQPKilq9yCsNYjoVZLRWUeNlKFBj20Hj8lf4izmYo+Y
 bbeGCWqccyS9rQx2mLdyJdaEyxg9LQoJHkArA1j4+WFLIBkZ/KsWvN4ODiaQxNttHHkR
 EwMAQ79vWNIuNG+PBfqs86YTYnu68D6h2ZruC0dK3pdyx7t9OTXKx+SzPO0DDz3kPl7X
 Pl9ZnKlNAzcHzZatc7X9UWT1XsN3zg5o6jD0fqONbJ4Rhm8+a5ZizaCaK1lwGBmReHOj
 IY4QGtiQ/igG6Lco8H4XRwozAfMo9moQS56Kiu8zFudHq+QrCqC3OnbFRLQlPQSC4Sml
 +nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=FGaARlyO45jSVlRCo3Ba46kwztIqiQvxEWOsLPfUyBY=;
 b=cg2DSI4MG11z6EZzo/7sugdkqiOGepAEBGMUA7U2Xkelmy7j/XTDaUHldGXae/ySgd
 eXoWZBIEud8wTpa13qlBeQpxX2/C+WQowkDfDd+OpL0JhkDoqBKYJOecjYTb/oFE1ZHg
 oB9dZUJnuK8Ra/gOZTrIgHtCWp3YXCFouAv/h3NjeOPPZZsLofxQBMxFwRjjTTAQNyI0
 MfDLEr0XN/tchoLMJPhG6wGmiF26c0OmEUP7/+UPjnFBmHwWPpPA+b4ZPEiCzS0uLOJN
 mWt/8ZKa8w523rM/lySAkoDCxPXmkrdtki9y+0GrZitbVoXjBc6Ka3APk6AgihNzeqNA
 Z+OQ==
X-Gm-Message-State: AHQUAuYxpmCUgiB2pK4l2pXZeWXClEWbZRiQB3uqY7aimf+IHr/347oY
 TqewXcwZTRKJ6FRKACt8dWlDGw==
X-Google-Smtp-Source: AHgI3IZrWYzG9huHS10ehbGpwHIHSv79LI09Vcrf45ydQgH291PARN3sX4S/vYIcLE4vYgUdlpfxRw==
X-Received: by 2002:a63:d347:: with SMTP id u7mr232319pgi.383.1550061259786;
 Wed, 13 Feb 2019 04:34:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.15
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:19 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 3/5] arm64: dts: sprd: Add SC2731 charger device
Date: Wed, 13 Feb 2019 20:32:47 +0800
Message-Id: <ecfa4740cd1255f358b307af946cb059f7776090.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_043420_720213_E9581AC7 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add charger device node and related battery node for SC2731 PMIC.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi      |    6 ++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index a2edc25..dbf6242 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		charger@0 {
+			compatible = "sprd,sc2731-charger";
+			reg = <0x0>;
+			monitored-battery = <&bat>;
+		};
+
 		led-controller@200 {
 			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
 			reg = <0x200>;
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 3bd18e3..2a963bd 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -41,6 +41,22 @@
 		#size-cells = <2>;
 		ranges;
 	};
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		charge-term-current-microamp = <120000>;
+		constant_charge_voltage_max_microvolt = <4350000>;
+		internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
+			<4022000 85>, <3983000 80>, <3949000 75>,
+			<3917000 70>, <3889000 65>, <3864000 60>,
+			<3835000 55>, <3805000 50>, <3787000 45>,
+			<3777000 40>, <3773000 35>, <3770000 30>,
+			<3765000 25>, <3752000 20>, <3724000 15>,
+			<3680000 10>, <3605000 5>, <3400000 0>;
+	};
 };
 
 &uart0 {
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
