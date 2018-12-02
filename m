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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F442082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VS2iFf7J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nteZ1A5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F442082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=31XjsfeWcClmS4WZXlYoTYYZ9dUn//iTLI/KFZgUMOQ=; b=VS2iFf7JNDG7FOozewijkpPHYq
	pNj4gloIaP53V4pY43mllIUpcJde8u8ts+o+r6ncyS1BhB0Jds1laGMQ37Gz0fHG/pBbAgauQoU7l
	nwCjekYRKq1tD3nvrT4AbfoJC9qesWGgI4pyVt6kEjLvLHypkr5wH6twlc0W7jw9PMZtIAzJ48pea
	q3MH4nxx+AMa0A7sqk+pxuKShZCG3BO35GEgB2E8BPtT9k1FkoWWKyZLnZ1QozExZeh1oXbxTlm1p
	bmY2uwEy6hlxLigIT1krEd80wyV+TCwCcj4TSqzyub9DHQ6sFew4k3TY8lA8kzuD/xeCouWSTINbz
	AkVwvJzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZF0-0004vB-LK; Sun, 02 Dec 2018 21:25:26 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDS-0001vT-L3
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:24:02 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so10133063wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qRH6PeTeS0nOBRWqCT6Sy3VYXacguU5ylHf5h8mKS3s=;
 b=nteZ1A5S5jTFEMnLTgHOVZCS6vWXVMfXSpo02opfr4tRlO1SrDYsi+WMd8ECELQi69
 DgK4zoDwn6nJoQofP2HZjADGqPITtv9r9dBG0ZpEOPwRFLCsJmMXzH1grPxd1xeNEz6I
 JYY+DRJf+PiuRJOLVpPDy2llNdCDPL0bGp1XxheZekHKKZK0MWAFkz2wRxSTDrif0pWN
 yDS5XNt+FpqzxXEFMjPzKtE2BqBjntpt4F+flB8Ud96BIBErmBVxHj41OcgECLqJiS6f
 NbzfqMYH6I4h9uzi5xL/QzgfUbncbeF38yUqRODJBDCwro2+JV5z87DTuq9KUc88ITyv
 eJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qRH6PeTeS0nOBRWqCT6Sy3VYXacguU5ylHf5h8mKS3s=;
 b=Of/+0tTFQtbNtGzD/SHaluul2jeWftyeizFTOwTCU0o0zC/ZLy2lWwwJDLtN3cppOX
 mNMv5HBxLdBO5GaZPDzHlBdZWbFTOnKjszPaHF/MpGwABcrGaUI2YbdumChAAYUApfCN
 M4/sfTIyMa8y8DSrMDud4cQql4WSngAv+EfhJ0vXpL+1Mr6mg/pZsEKUf+2+RDf9tg/A
 qr5fnuPLetOvdib26wsda5wGNWXvuecI5kn9djLumxRnuYeMZ2FRquBk85gsJKEHnbik
 zVYrzLGNo7WQe4sK42wAVGzx2hLA2y9rUgtdTm0f414AA8FOw8qC8AkIqlFUe9nqA4gV
 DKLg==
X-Gm-Message-State: AA+aEWZ41crHDLcMoKDDLLE6mvq3Ihyfe8EJt6xPbS9mvEr7Noo8WPvi
 Fc8a+UGLF+ZsHnJa5vAMkwg=
X-Google-Smtp-Source: AFSGD/URI7MWeIJo1zSa6arTqQmdNcPT7xrHVumv/vajrAYyCpjWsU77MvdbmYmIAZ6S5TSZqNcNCA==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr11121188wrs.86.1543785822565; 
 Sun, 02 Dec 2018 13:23:42 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:42 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 07/10] dt-bindigs: sound: Add Allwinner suniv F1C100s
 Audio Codec
Date: Mon,  3 Dec 2018 00:23:14 +0300
Message-Id: <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132351_440418_F7EF1855 
X-CRM114-Status: GOOD (  11.85  )
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

Add compatible string for Allwinner suniv F1C100s audio codec.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/sound/sun4i-codec.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 66579bb..9778bc1 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -8,6 +8,7 @@ Required properties:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
@@ -27,6 +28,7 @@ Required properties for the following compatibles:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - resets: phandle to the reset control for this device
 - allwinner,audio-routing: A list of the connections between audio components.
 			   Each entry is a pair of strings, the first being the
@@ -41,6 +43,7 @@ Required properties for the following compatibles:
 			   "MIC1"
 			   "MIC2"	(not on sun8i-v3s)
 			   "MIC3"	(sun6i-a31 only)
+			   "MIC"	(suniv-f1c100s only)
 
 			   Microphone biases from the SoC:
 			   "HBIAS"
@@ -51,6 +54,8 @@ Required properties for the following compatibles:
 			   "Headset Mic"
 			   "Line In"
 			   "Line Out"
+			   "Right FM In"	(suniv-f1c100s only)
+			   "Left FM In"		(suniv-f1c100s only)
 			   "Mic"
 			   "Speaker"
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
