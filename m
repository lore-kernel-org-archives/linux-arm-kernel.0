Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE05C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8A020848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lJNGiyTd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qC8oqrq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8A020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sApwpzEd8ZHqqCtMG/S3vpcdwFPF5yTwmiIGCPqfc+0=; b=lJNGiyTdLKWy+m
	pJloFXE1k3BNdwq51CH8ryTRBtZfIwJUntT3900e89asoA6b5q4VnZfA7UlB4aXgDVo84Gx4g9LIP
	vIIIv36DelLWXiSZB93ZWRsIGEcGNI2hHz502iSq7xWpBSETHaBJqkgryTrItsBs/pE00MVsTRWN4
	Fmc0nUiiIsQfT87ImmNjPyC/Zg74TvBUwG4ABYWUymzw7jghqIrKgvDvJY67EWI8TnXUdQ2dSWyQ0
	1T4Ara94l4yge9wicpnGpnS8frHFMF40LdPcfJF+VsWIhEj9iRZ71XmJs6Ec8WGOvAXtgmFEtyECO
	Mq43aJ80hEvLYAa0EtLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlIs-0001k2-1y; Mon, 03 Dec 2018 10:18:14 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGw-0007zx-SX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:19 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so11461865wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sYIR92ZSRt6P2LabORDc+r2SZD6NGN2vTfFdELLfLf4=;
 b=qC8oqrq55XITG+IaBKgDlrqKba/eWXMICT8ZW/Rcc4w4V6RiseMUjyfrfmbtTpyUDd
 0mBjZRf+m3qaDu0DTvoS/QChJeSM09sBOq9ACkMw0YHJ6WxFEYFT8xBCcWPVTdkEU7AA
 dTa0Ib7KnK7tI8rzBqeja78V/ZEzDQy+/L0sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sYIR92ZSRt6P2LabORDc+r2SZD6NGN2vTfFdELLfLf4=;
 b=Vl6Us8dpYMa9UXGaOiM+GsVbp69KC8ZaKvw9NyCpE9CCaazGAHaU3aRhxYq0cZYWkL
 HIqCgfSz5i4auhXepFl4Nm3WOLxfxoJIv5+m73AKNqQ4U6e7jdsLXbgW2av8UMFh61Nn
 ajC1IqzcGl+Ax0Mf+to8unUasgENmxg41/ib0o+vite2Hcc85MxTNB2+CWFSovLhpNBf
 mT+iDw1ec0zxSwS+XBHlw2bg2al6/iZoSuyUu5DwXdNvTWZBpCLBLYAuG28eBdogxh1N
 NXMGrIuIl0PD1JhYON1nend1+/qhIpNiM+FcNt7JPljQhk17aDUtg9HDuaT6GE4DvS4K
 E/eQ==
X-Gm-Message-State: AA+aEWb0TdVJ6972rsfuSAoKi/J6W2BhRyQIPVSEl5bSBoxtzruw7YDS
 QKnLnzdmvhYCEtLbOAGXuqFs/A==
X-Google-Smtp-Source: AFSGD/Vm4W738LcPT1s/CT/dGj4WK/IiXywz4IEpkGYPcV0L5ZaqAwwt1Y6p2GtyZ5p6627XpfOOdg==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr13550244wre.13.1543832163368; 
 Mon, 03 Dec 2018 02:16:03 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:16:02 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 7/9] dt-bindings: input: touchscreen: goodix: Add GT5663
 compatible
Date: Mon,  3 Dec 2018 15:45:45 +0530
Message-Id: <20181203101547.16835-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021615_422247_ED6614BE 
X-CRM114-Status: GOOD (  11.77  )
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

GT5663 is capacitive touch controller with customized smart wakeup gestures,
the existing goodix driver will work by phandle vcc-supply regulator.

So, document compatible and example node for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/input/touchscreen/goodix.txt           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 604766e347ce..1898d3dde8e1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
@@ -42,3 +43,15 @@ Example:
 
 		/* ... */
 	};
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		vcc-supply = <&reg_ldo_io0>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
