Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD822081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXE6djfG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv+evXEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD822081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vn38yXG+aMvq8GMJ2Iz7sJoAxgjN/ZFHRlsz2rqMJAs=; b=kXE
	6djfG4AICHz3vvf/7DszAxAE9FmXKGv4iUz3lxVqBkBTgj4NiUg84yE3uNTcSWy4pkBG0wnXFkuaN
	L9sEbR77VfOe1aYYUYPNbjTfdL8v2Auu0xh1fDJtdCR6OmxbhqXDsSamIhodGQlnj6jnik8mIklI1
	B1WSKPYgNLuDCLj0ASxYY32Knx1/l1mBW3Xh6w6A1izlU1f3xcyAD//2m3Ww8tUG/OhpCchwIScA4
	ixP3J42TRcLqKCrUiIs54fjYjBYu3QwEHwDxCdJr11aBb0KfXbk/LDkHVFBpaNkNQhFvoXxu7chHo
	AoxJUuKmx6y9Jh0udZvMW6osz7RWCMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXug-0007XR-KL; Fri, 30 Nov 2018 01:48:14 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXue-0007WP-BO
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 01:48:13 +0000
Received: by mail-qt1-x843.google.com with SMTP id n32so4309159qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 17:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=llcEPw+DEam9nIZXI7K3YmxRGhK1v2ylGtjRwriikSo=;
 b=Iv+evXEXXRAlVuTXt19/2yzZ40WGcPdILGASzMmNPfB3GRCnJ2dfJIcjwfwhuY25m0
 T9f09jJEVCvJaK7zN2B/NanskoHATeiyAihWcDCpZGVO9Y01UuEGw9TFQ+kjgFze91Sc
 qL6RKp4viCXb/rRPt7w6TzwNg4UeeJBNdQWPxyWmsBz8o94Ia5Uqf+pCRMkrxEG27OBy
 5Q2DI6e3/NPht1qlbabpRvkDVe28HBXol9k69MmpDXj0jJxTQGkh9/glCN3L/voYOS3h
 5TQ93PNH7DFqx2RAy82A+3jbdDLXd3TyDf50wRezWwKDletooE4a3AUe+p8Ek9+2TQVT
 oJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=llcEPw+DEam9nIZXI7K3YmxRGhK1v2ylGtjRwriikSo=;
 b=Gs12ZygwJQUk6caQhSX76ldpjI0VVgRcm59+a1lFDe7aCrg239Ne1sLVv0S9bPlBIr
 c21X4GaPjhMiibMO6HicJjbrmKW3VuBqn+gz8+3xyV3FTNHHycVdH+UI4FxM6W7DT/IX
 G4qukZ0CpTqZvpi5EE9Spn+2A1J4XlV8YnjAkiJKJOB+SAlectUtlkA5VCw9WD9gHcMI
 8Z8cqyxsGB7qMQyhjTrqEWtrABX/kZdNWteQB8rTdVXsSjCs31+ZDd7La17iIMxKIkH1
 apHw2kImfFmV9kVKb5iW226q1L4JGhaUdpR9wP34PsxRgnfXXCb0WBK6I8YLVr+9GXMM
 H9cA==
X-Gm-Message-State: AA+aEWZCya/50cCXUNuv1nXpctXHpVtA2DN5hCurrpreJ2WgsvsMiey8
 yapX1JnueL+wFEtzhEqVG1M=
X-Google-Smtp-Source: AFSGD/X1hZDQ3fA5qQNfyH3yyzgyLoMbXzpm2JchT3tzmbaFxmIou7X5QLj4zdFzbGFlRaieCwZ6Aw==
X-Received: by 2002:aed:3746:: with SMTP id i64mr3695001qtb.307.1543542480846; 
 Thu, 29 Nov 2018 17:48:00 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id q2sm1437768qkc.68.2018.11.29.17.47.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 29 Nov 2018 17:48:00 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi
 clock
Date: Thu, 29 Nov 2018 23:47:50 -0200
Message-Id: <1543542470-4813-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_174812_417062_B92D0453 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: gary.bisson@boundarydevices.com, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, troy.kisky@boundarydevices.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to bindings/regulator/fixed-regulator.txt the 'clocks' and
'clock-names' properties are not valid ones.

In order to turn on the Wifi clock the correct location for describing
the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.

Fixes: 56354959cfec ("ARM: dts: imx: add Boundary Devices Nitrogen7 board")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 4fb7e84..9ba9084 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -87,13 +87,17 @@
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
-		clock-names = "slow";
 		regulator-name = "reg_wlan";
 		startup-delay-us = <70000>;
 		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "slow";
+	};
 };
 
 &adc1 {
@@ -376,6 +380,7 @@
 	bus-width = <4>;
 	non-removable;
 	vmmc-supply = <&reg_wlan>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	cap-power-off-card;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
