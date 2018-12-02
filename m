Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40906C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FDF2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8AHdtOH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSrXGWXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FDF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1db5qsXe0TNAVlaWW7CpvxPHavejqTTYhIRckyes+Hc=; b=X8AHdtOHPFY/GVoYIEdLJ2Q3jJ
	5VeTGc2UenxN1JaeCZZESU633DmQWFRedNpTsovqUXrWtoC127SAyUWOQbF7sYLCcguRo7dCSuguH
	neoqAz9YAKufxHpAtYx1dIMnGH3yfj5AFRoaHBf2mHPvws+J1q2MpQSMSwO2+DrsyBIXURAZK905L
	KqKoGWCdMdNJGc4LBb2IjZfreZXZLbcnyLmFAKDECuypyNg/Uv7hCSyY/cZcSNT5LJYPKd4u8S4nK
	CPYfkv12MpOTp0fnqVduYQkaFfr28pgl3wKHcBZo0avm+5qrOA3oo6EVD3FaVmCexNhW8nS756jGY
	b5lxnlfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZEl-0003t3-8l; Sun, 02 Dec 2018 21:25:11 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDU-0001x5-B8
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:24:02 +0000
Received: by mail-wr1-x441.google.com with SMTP id j10so10130909wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6LxUnav0zIyn7lCfJyICRwEWEm6FUE24Ta1FtH9WUg0=;
 b=GSrXGWXrOqtYtYyb8EOJeB8iD7RCnNokxW2iXm8cK2okjT7DaYq1on3gZA6qB5yvNM
 gKRD3bjQKjU3ZwQCc3jc9CEuhweFJ+bCdgajKLkucJRddwZEuvSLz2vk9nnvLm/8F5+Q
 qTdD4xMc22DfTdtTjIMDEZ4Vg34ZwEe9c2fgsdbEvSjA6IhKWR93spm0AMmKaNsf76Ko
 PPrFtuZeEwS2jCTqVrEF9WBfZ1HuYHNu4LMXpq0Qb+QwLpniaw+CzywCTAkKiP/p0fT5
 h7H9uwneXP2dRMHlbNfCzIKgGBUE7EZZZ3YAW08ZkhQ+KC3Xxc1GBKVhYotrSf/5QUJF
 iNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6LxUnav0zIyn7lCfJyICRwEWEm6FUE24Ta1FtH9WUg0=;
 b=krzBb6vgH77VP0pFQhrzOn+wHh8m+xDQR5339Q66bCLbYtCcFYY3IWmOh5r8AS7xIq
 LHR/kG+4XIvG7iehMbVGebM9Ki7ji534LG4NP6pveu7l6QVhkiRpoiehWv0nCLAd457s
 PwBdZaaLOPGRDFHHreKmQs4zfAbHaSSUvPnqSImTonoGk76dlul5FeC2sZdgRB6jsHO7
 swY4mN1P8phdUAI9lSrqmKXNPU3vqQPar6995dq0qB2MbfrigDKYCOS/OTha5h96fHnP
 26QeAxBRM7X+zQ7AWqjJLDZOQzS5K2cI1NyPtssUKWBLMm9NTmInZFtkumGyOZTM1jMy
 JFVg==
X-Gm-Message-State: AA+aEWawlGCx2Vu5Xaz5+t/OkRMGDbgObqosAvoL9d3EVRrJ/xwQ3Sph
 RQUvCINSPsjZM5/mUvc5S10=
X-Google-Smtp-Source: AFSGD/UXqTlLRnQ9qFyi7CzYKDOg0vCB0/xVT+soOuMlleGNZ0QEam8bkTB8W6Uvggfp79R/8Pfxtg==
X-Received: by 2002:adf:a743:: with SMTP id e3mr11378257wrd.56.1543785826048; 
 Sun, 02 Dec 2018 13:23:46 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:45 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 09/10] ARM: dts: suniv: f1c100s: Add support for Audio
 Codec
Date: Mon,  3 Dec 2018 00:23:16 +0300
Message-Id: <5f9f6c3e7c21a33c425396717211601f4460c488.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132353_139181_C6898207 
X-CRM114-Status: GOOD (  12.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 4c96a9e..130d31e 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -154,5 +154,19 @@
 			resets = <&ccu 26>;
 			status = "disabled";
 		};
+
+		codec: codec@1c23c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,suniv-f1c100s-codec";
+			reg = <0x01c23c00 0x400>;
+			interrupts = <21>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 12>,
+			       <&dma SUN4I_DMA_NORMAL 12>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_CODEC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
