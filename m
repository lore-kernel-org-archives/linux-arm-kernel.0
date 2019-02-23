Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B5CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD12A20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EW+D366i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2vB15Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD12A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7KPZ9eTiHnlrJhSYRmygXsE3gjH3kIz/jpA/CNyXeAo=; b=EW+D366ictzigt6ZH6PUaQGHAR
	6dssEn0Cl4MqC5Jy+V0fZMyd2O4+uKN6i2KQ8eHAhl4eJFnp586Jr++8skfYbJVEqluxnAAH57eku
	tV1DUmADcZoXEid2Bz2AUmixtfm6CLE6gjXnT4CIRG/ptn3lqytoRCMOKWng+6YlKuBE9MMpcV+GB
	kyRwR46OZ12VgbHZushhme0zXHjYuh/AzXTSeiupSl0OqoIu7/1q2x5SV5/Xo1os1xkujlXqhnNym
	mMAjtUbcNi8VASH/pUYuuRtkE2o+zHPgT+n1D0O2NcxJQFZdGOW0A1Kpdzi7TujaE8isrTc0Kb2Xz
	TrhuIwow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX3X-0002uq-16; Sat, 23 Feb 2019 13:09:27 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX2L-0001Vy-5t
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:21 +0000
Received: by mail-wm1-x343.google.com with SMTP id z84so4257825wmg.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aFmdTDn+1DhlKxKeSwBRQMFH12sZspvNOM68gN8DFWg=;
 b=G2vB15NmEEv1XB4bfYMuhjNctr2a70JxJ/zvx37GB5wt6WquYw51tBA5XktIKFO8jn
 NAWphxrJ9A8/QNRxoSA718uc6c8JC2jm0e935vqXuJ5hliVk0DnSma0qM2H8UhKv+kR0
 joZolxC9lDojsCEZVIE60Lh5jcviPtz1FA+o34mBDNd+fQIk8FjpxNCmdNnNJ4kA6ydq
 kcMVV+jlIQl+xurqKehMsHmV5c9NYCxz0cLnXQyC2+sHphT/Iq1Tsh43LuseU0s25/GY
 3qx35JLiDY0ZlJ9ao0LTez0vlvUQnlHJ1r2exuuLIvFIxNgNz5yVeIFpGodzzD2OPI9b
 NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aFmdTDn+1DhlKxKeSwBRQMFH12sZspvNOM68gN8DFWg=;
 b=lBO8+kusPDiF/1fG79OMPtMSIREpQtA7RxmuMos3jc0Lo3ireZlJ7w/Pk9ucqXTaYv
 VgD+QzQk+7vKhGuz6LMPeGNinpVFr0iTmTLyw5pbgPfFmUUqHi/+tg1i5xl+kJg0hzka
 T91k7DbZHx+jGmA0YfBwxPoihDiNJRTDJ7npE4VaHY/V6SAlX7A24SLHC8Vw+qzB/p/B
 PkPoDZIHY5YQS6JDY9du5A1lY5OugBHqnrl+B06+FhpnVFOefKomSMBm24TwA5XwcBaW
 IiXIQhHGrOVYzYQfwGdt248k0XoVkeio4J5QnAkFpU4YEdLQvWLn6AKsNs/+uSv0D+8E
 8vFg==
X-Gm-Message-State: AHQUAuYkKgfVek2efI19JmnDzf9pMsxIDVC9FRkOR+DsFydTFYcdapVR
 +mHUvVEtevLtSae08IyhLu27Aw==
X-Google-Smtp-Source: AHgI3IbE3e7b7DmxlFI6vJD7yNqU/qn8vC/LHML6Oc7tO9WjRks1opAdike7HqSq8I4x0oVa83U+iQ==
X-Received: by 2002:a1c:740d:: with SMTP id p13mr2192011wmc.46.1550927291672; 
 Sat, 23 Feb 2019 05:08:11 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:08:10 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 10/18] dt-bindings: timer: mediatek: update bindings for
 MT7629 SoC
Date: Sat, 23 Feb 2019 14:06:58 +0100
Message-Id: <20190223130707.16704-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050814_047226_D5BCEE87 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

Update the binding for MT7629 SoC, which uses fallback compatible to
MT6765 SYST, so add more descriptions to distinguish it from the other
SoCs that use GPT.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 18d4d0166c76..ff7c567a7972 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,7 @@
-Mediatek Timers
+MediaTek Timers
 ---------------
 
-Mediatek SoCs have two different timers on different platforms,
+MediaTek SoCs have two different timers on different platforms,
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -9,6 +9,7 @@ The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
+	For those SoCs that use GPT
 	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
 	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
 	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
@@ -17,7 +18,11 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+
+	For those SoCs that use SYST
+	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
+	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
