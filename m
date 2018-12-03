Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A73C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79223208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RZNmEU6y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CstbwfBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79223208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uffPhY7tsmLghD+Bg8/zhPSATWD56o7VcjrOYzUWAUA=; b=RZNmEU6yp031BXyghCa9c/u3X1
	2ugCvFMaa7wAnKgrq1EkJzRc2McMUKrwMN6h8UZOUAQxDLIb1cVB8I717o8V2Z7G//pde+MQa9w/D
	DTc2/stLOAKld1l174Pw7aPINK5Pz7FjdDQYyMHgDC/BppA0LGdMDPXEunSdq8qeeYB7tXHBgLsQc
	RJpuHEIbo87ZRuZ9/z9znRNwR+J13GeOsqUVjnjT4OonJPW4/VqtOSC7g0/s2QdJN8mX6FNs/6Rwz
	KV1bJEih1fl0fJDOYYSmqx3RorIEtttLQV0Xms4jDtfKE2WF5NxpLE38GK49zwBCacJstkK9POKys
	hn620oGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsDW-00026U-M8; Mon, 03 Dec 2018 17:41:10 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsDD-0001bU-4V
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:40:52 +0000
Received: by mail-qt1-x841.google.com with SMTP id l11so14773249qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vu4zGuxtXnfgv1zhNnjxH62KRx9n80raMEYegBD6vQY=;
 b=CstbwfBlRpgmC/535S5hbwmFblOyREMCUGt4HwzqvbM0UXNUx+JmLMz51DO7jkwri1
 x0/i/z14pudId2gGaHRvIwknljqcEC2Apk4izUmBvd48tgBzzp0Zpy5BuNzLI/OP7ifS
 qUNrcrFqOjni/W3/dLr4VubaNOwwYt9lUzNFPezGKEgorYLREygsf+0hxhKNDjArgSKf
 6HPuMMYMmgxzf9751ly2M2ntYxeojBX4qW5SietDjjilxat3P5uootPrGgH0IRuc2tXT
 xu0/bf25Y60f9zdaI1oAnd4YjsI3XAIERhkYDYOAvUoKToa5j2TIOmDqjNzqQuSTzPW8
 eSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vu4zGuxtXnfgv1zhNnjxH62KRx9n80raMEYegBD6vQY=;
 b=ipgeoSW/NIYzwucIEMuqGEZFn7aSvtGhodDlr9hpCI93M/dI8beJXV6jagn7W2C7wN
 xOdBp5kdhIF9aTGR3eEIQXoR6vLfMqFgiuVk3f/UFO7IF5YthnKCVxKEoxJ4xntV50a9
 pRT8kY18wqNahmWIRGEQOeH6UyEQ99M5yKpGfW9/dlOwR83hP3EhIwvuJGLz702+uPkh
 eEVsSRK7elUcwI8B9I9nfnVATrhplzkum79mqA7VNVmgsOr028YBcNehKxoOyMHxV17w
 WScrLR6CuH333DpQ341gtm1cVBjLPb47pgSP8ZTCjk82Wxjg+mfmB4t+uiFsA9DebkQ0
 Ywjw==
X-Gm-Message-State: AA+aEWbRb92huO9r+75DqF2SxnPny1mxVoZxvz4PTYRwQrx1jJncNjZv
 /TECtINbdqjI229ZYfVVqVk=
X-Google-Smtp-Source: AFSGD/V9VEHkCyPCcPje7ntyZeFXeIC3ZJB6Kb1M3mGwD0WCTPTeLR6PxWSzFjaN84T5FJZbIQZfKQ==
X-Received: by 2002:a0c:aa56:: with SMTP id e22mr17140949qvb.158.1543858839703; 
 Mon, 03 Dec 2018 09:40:39 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id m1sm11835694qkh.15.2018.12.03.09.40.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 09:40:39 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH 2/2] ARM: dts: imx7: Correct mask for GIC PPI interrupts
Date: Mon,  3 Dec 2018 15:40:20 -0200
Message-Id: <1543858820-3354-2-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543858820-3354-1-git-send-email-festevam@gmail.com>
References: <1543858820-3354-1-git-send-email-festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_094051_184197_36D509BE 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com, liviu.dudau@arm.com,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
number of CPU cores the interrupt controller is wired to.

i.MX7S contains a single Cortex-A7, hence the second interrupt specifier
cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".

Likewise, i.MX7D contains two Cortex-A7 cores, so it should use
"GIC_CPU_MASK_SIMPLE(2)" instead.

Tested on a imx7s-warp.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 21 +++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi | 10 +++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 826224b..6b298e3 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -24,6 +24,15 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -72,6 +81,18 @@
 				};
 			};
 		};
+
+		intc: interrupt-controller@31001000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupt-parent = <&intc>;
+			reg = <0x31001000 0x1000>,
+			      <0x31002000 0x2000>,
+			      <0x31004000 0x2000>,
+			      <0x31006000 0x2000>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 477901c..098d2cc 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -160,10 +160,10 @@
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&intc>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	soc {
@@ -305,7 +305,7 @@
 
 		intc: interrupt-controller@31001000 {
 			compatible = "arm,cortex-a7-gic";
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupt-parent = <&intc>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
