Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA28920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iuzxe8jy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P4REhBT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA28920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nk7uLxmgASUXkIpL7PN8KQ0PvhqJf8BbhImBbwI+SeE=; b=Iuzxe8jy1WbM4Y
	qwHS91YHspc1N9+kSrlTEpyHUs0XDdVPqVOJ0rPEdwDqXMH+ihoGs0z3Ng5ZYVuTWwPeIm5i+ogzL
	n5Bf0G0rJOiHxGIVyozxbDNA+HQThAeAXnA6PK2SUMZ6O6ufC0AIQ/MIdr44cqOPniulMyvuXoNQm
	m7wVgQJItHKl/pJjmiAn5tDOc7dWAByFkNdSd4PkBl2AyLOFeKxppOIvqK2pQ5OCYB6PzzAugfuTv
	Ng3VJcztajnYNc4po4FmKnkMiQ6vsYiYYfG5tLBX+6+3k1PTMtyLkCzS28GHMJxr7g8lMebegN90T
	EQcHnV4nymL4N8uu/L/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlHy-0000qs-Fi; Mon, 03 Dec 2018 10:17:18 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGr-0007zH-MB
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:11 +0000
Received: by mail-wr1-x444.google.com with SMTP id c14so11501135wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wg4zCKkS5SfqlTRPj9JdiOkThqwhYO31sOTuFqJbv8g=;
 b=P4REhBT+SdcfxIfpb6eF0vbf+VMAT8ksV6a8YaOzCwDqLMOQx7fsYDoG6NREqfZsht
 csYkt25uMUuqcf6TSBQO7c57wNp4s7tlEiQ4rgmoQgjHeOnZM5bdEM7mE5sWhFbwd9/Y
 JzGC0CPNQfrCc8oHzKFL7G18BY+mWAJOdDpH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wg4zCKkS5SfqlTRPj9JdiOkThqwhYO31sOTuFqJbv8g=;
 b=LcUHbHtW9kBInohWdaus3Pv7mlKTtxREpSG+6ZGfOOJPKORyZ40yOQRor+w0MUGXhA
 DSfQ2XK0oysySx/h3fzcbi9KXGAO890W96N0jg5PxI5b4IW95uJSmDYQV+JlMhxkXd6w
 X3EJ06FXlvm7C4sJ8yHJfXhlTrcBPnubaawDnH7XH9TCJDr416IXqjRmztd8NL2WGcs6
 ZZ2lWdv6sy7ESMY55FdjxsbQwdHk/KKQnqUhn/dlvLibW3gVO29sUiykf9g0UGconVMI
 meV0eLaD1PYtI/XDcMRr6Cus9VIL/eGNRF5Yet8jWeqOSngtcXLYQ5LJNyChVfjb5+jh
 9RPw==
X-Gm-Message-State: AA+aEWZJN9Dte0nvmMXlqVGS3iscsq0zfytFB3/NQ354C8Fb8nmsttJK
 N1kYIxpeh6zcZkzNDc8wxpvMrA==
X-Google-Smtp-Source: AFSGD/UOV3gw0B7fO0cTvmV+8AhL+IERt/3Sh8OSHR90BdAk+ZC3xvxFiQia66+W1PEyVGFPnn8kjQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr13012473wrm.232.1543832159477; 
 Mon, 03 Dec 2018 02:15:59 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:15:58 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 4/9] arm64: allwinner: dts: axp803: Set GPIO0/1 pinmux for LD0s
Date: Mon,  3 Dec 2018 15:45:42 +0530
Message-Id: <20181203101547.16835-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021609_733349_A03830AD 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

GPIO0, GPIO1 can be used as LDO like ldo_io0, ldo_io1 in
AXP803.

So, attach the LDO GPIO pins along with pinctrl properties.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index c6b95980d476..b0d6b3c3cf38 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -54,6 +54,16 @@
 			     "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
 	};
 
 	regulators {
@@ -137,12 +147,16 @@
 		};
 
 		reg_ldo_io0: ldo-io0 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio0_ldo>;
 			regulator-name = "ldo-io0";
 			status = "disabled";
 		};
 
 		reg_ldo_io1: ldo-io1 {
 			regulator-name = "ldo-io1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio1_ldo>;
 			status = "disabled";
 		};
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
