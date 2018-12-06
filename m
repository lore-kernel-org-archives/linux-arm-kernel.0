Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF66C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B5208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+KAAw1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OyYHeUWde9OrWylcHHwZ0r21qSuYFmkZR9Mzn4y5yJY=; b=f+KAAw1TyWCUol
	eowbfflcBFxvJKv4RxDTjrawAgFgkX4fOStdgGvZayg+acAqWsC2gd1AZwpQ5Kdh006HVxXJz53yJ
	0cKgkk4AH9oxAYO9LfM7BS0A8D9IjVsr/CKBGcDebXiZEMjk8aK1Vn/UcnPwSWJcgY+xBsvwZ8x20
	48IJUnvEobD7dINP8ss2vZlyzR0MatekRYLe+/vdVkqkTvCZcobXXrAOX1wbH5wLsDHueEeFPehpK
	6KD1SL862vO0NGy4lagK7v8sa/G22HT5V/KeEa/GQqzgJqg1CVycAcqhn20IhKGzQiXrZFjV3rhhf
	y3gu0W4oNNbWJeYL0Q7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUz42-0001g3-90; Thu, 06 Dec 2018 19:11:58 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUz3z-0001fK-8A
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:11:56 +0000
Received: by mail-oi1-f196.google.com with SMTP id v6so1365207oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 11:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B85wNpGoSP2V2mnXhKpVkuqFiCCFoHETPOMnmS1u0Z4=;
 b=F1eDGAnk28lcQ3VT6QBInse1Hqu0ByCs+5U/QODonk8mWGHlBoJ+nJkrUIyaHuRAUR
 O8anf2/prNwvNEtxYdLskPpB6oYl4NFAgotb5FJbodDFDNIL34uYJLGT+aJ4fSFDzS7y
 XGQjjgc6sIQYOFdcH6E7Wg6D6vyK13dPNh9c4ihUkyHHnwQqsG3wJytl7/dMSCK+nMnm
 98/IyH41eJhNOMm3pxYbVYEsytr+VoVxHe7Ug+GxaUfkgZgMAz7JNkYdSpxSZACEzoDm
 MSzjcVbcw7ntAKhnwkA+FS3Z32P1LW+CQ8TqO9ZUCEuxq9DgSV4BpjcdRhScjC1DEWcy
 KKmQ==
X-Gm-Message-State: AA+aEWZonaZGdLI5rlv8q5EXhr1Vick410fmaitR3b6LP5qNcuZu2Pv3
 VPZMWynxVHnX7RcOBY/5d94/Hc0=
X-Google-Smtp-Source: AFSGD/X1vwlhMHH8LkMsF82l6VrchCkhhYk66e1/gBFrN709SwTUaCHAKgjX6fMjSkx2jf4wTGsEIg==
X-Received: by 2002:aca:ba02:: with SMTP id k2mr19301532oif.177.1544123503792; 
 Thu, 06 Dec 2018 11:11:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id u19sm490821oia.31.2018.12.06.11.11.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 11:11:42 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: sunxi: Fix PMU compatible strings
Date: Thu,  6 Dec 2018 13:11:42 -0600
Message-Id: <20181206191142.14118-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_111155_289128_CD0D4BDA 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

"arm,cortex-a15-pmu" is not a valid fallback compatible string for an
Cortex-A7 PMU, so drop it.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a960b8ef7822..9e7931d5e42a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -202,7 +202,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3c571dc599c3..5e413a5d9f6d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -199,7 +199,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
