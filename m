Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B9C282DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E5020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b/kLPZmQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsjVkACW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6rOIqtoxIaZOihdnCiI6pdkfGqn4rnU8EHHfEbRfXtg=; b=b/kLPZmQVhXrHoPhYoFYfBCJTn
	IUMF/tqUEkvIFtcmhEiI11hGhgBIregThWvtUdB9eS+ep8/wWO5EYf8Wx68EVkVjA4sQUiVhR1B3y
	pY+TlJFefoz59u5ckoVuek1kE3kMpia+DZZkuGBU4ZI15zVEvnGLrr60GlbVbvsKFTsATGIc+8w3j
	4LAweFHBFAGGoxW6fNr0W6+vuM9EB5H3f/Vzg1HsU7fgexZg9aE4NpEh6mLHJyN8eIX8xeSzfZWHe
	nec2b66nPHOdD0TenWP+uCpeWHWH0NCDPGKatCsHisf6BolzVQc/ix8FnEUaJY/n7+Y3Lv3KyOoE/
	lNnd4Hmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUC2-0002XW-9s; Mon, 21 Jan 2019 07:40:26 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUBG-0000q7-Tu
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:39:45 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so9390950plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=WoGfmBXbkp22eB752R6+rnQEzLObCNo8qMMo8guRvqY=;
 b=DsjVkACWlqglSNGhM3nJdcZLu4R32jh+mLpC+C0R8ZR2N8fnNBvR0EfJ1B5kSLvCEc
 9GJ6T6u0AmmNjTpYIo1ypZtvKSnigJjdVVwpSLIjNnGqHFUjL/PyHAWW7NcqDIFaH5XH
 SoioOQbIvDHzqYpVTvIJACl9xl/c6lIO4SJLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=WoGfmBXbkp22eB752R6+rnQEzLObCNo8qMMo8guRvqY=;
 b=pr9/bbC9Ve3NTupMmwzP1WA1KqI3S8VTOFSdxPmQN0g3Za3c8/Zl7W9F94RwVjI5st
 pf6e1ogAd1Suw03IxOtiaCr5RsU3oHAVF41E8K0p625UY5/zkS+DLHigxeAGBmtSCyz9
 rnh1Qk4AUEjiMbzc5lf1AjKmpIZNssiOFai2rxAKlIXMIhKcUoX+f9EfRUzSCpZOnz4G
 tNjsCWp9+oj6ldfCWA4eRq+d1XcrFTzbOdy63GL+eUrF1zK2KUPZ2Maki8O2LZoN9MRq
 egU3exhBXVtYeZC7cWnb8UGgxlBDBeA+YkXjvDUI1IPlnHRPOyMRxquCy4ONtTlRXVaP
 TraA==
X-Gm-Message-State: AJcUuke6qVPsZXjqOH8tFWCcisNrXwpZfKcBquonpNF0848y/SuT204V
 oeuGZHrKBXpIo1XXXxr8DXjCIg==
X-Google-Smtp-Source: ALg8bN5phe2gfmZHmrs7HD1M36IyUe38XNvyBx/Zbaen/C/WOb2DfwXvV2jTQT8QrlNCFvhT0I2S1Q==
X-Received: by 2002:a17:902:2ec1:: with SMTP id
 r59mr29453151plb.254.1548056378468; 
 Sun, 20 Jan 2019 23:39:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.34
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Jan 2019 23:39:37 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net,
 orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 3/4] arm64: dts: sprd: Add SC2731 charger device
Date: Mon, 21 Jan 2019 15:38:30 +0800
Message-Id: <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_233939_700882_951C171E 
X-CRM114-Status: UNSURE (   8.61  )
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
Cc: devicetree@vger.kernel.org, arm@kernel.org, baolin.wang@linaro.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
index a2edc25..b52eaf0 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		charger@0 {
+			compatible = "sprd,sc27xx-charger", "sprd,sc2731-charger";
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
