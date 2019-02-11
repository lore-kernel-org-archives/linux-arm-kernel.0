Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939C920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gV3vGTL0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/QhhZrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939C920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cxZiwJ80YJZipHh/ggt/J8L5IrMcgH49J7DOdvRCHvk=; b=gV3vGTL0BVB+QnUO4I83pmnfRE
	QS+uUw0aM3SBGKiuhnN23DDpMGZTUri+fMGT1teu8w43ZWTxJthYN7a98MET2cORRTBHhoBcJ1VCw
	+uyjKSdbs5R1OYt3oOLxKk7M91HsTELp6Ka24TbyQuel1l8JE/bLaSjmVwvvU9rfA0BxJrkm0MlQ4
	da6YyoXGDo6lw2AtwBbYibXvKwvG16Yr3hlf0qvovT0WDmrozSr7xHNBVPCqiZKAodbGL3RrYlIjD
	VYGZMXX0cM0b1s/KR9/1jJ+mCTXQj6TOt0NNhCU5gaub3BA2BUz7LFLLuY+RCEEFjEXYp4QL/82Jt
	e3EFvUZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7mt-0007lb-SC; Mon, 11 Feb 2019 09:22:04 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7me-0007YL-Fg
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:49 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so16216819wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
 b=d/QhhZrYnhRw+rD/kN8Q0NSqsLHYO8JFZqmcqCz+MvyTEk5ClAjLS2Bjm9gU999leo
 TEky8slQIZbooNvaAti2WY+VvjNmcPmyqkNYwMkaqrkCn82uzjbawATJBWBarIX42bk4
 OIbnjGzy6tf6A3KacgEAlv3ZvJb0tsEc65exBXUHBzRf/bAO/aAGw1awltrOGX+ENudR
 5aIh3OFMeTRDugdblEwdpMF7xwryeKlT2wP50q5O1AlINQAco1aEFzVDV0Xv1DmME8Pv
 tT04sXUeIwkR0UqYhbCuZxpeuW0RN1syyg9/dvZcdN1l6b+qaE+P8HJoryqTFTGSIQ1H
 l5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
 b=jRuLxwHSZ/SZ/prVPdMaCc6x1wknMkWBQagrVBOCRuQQ5f3xna/WDJjxK5cTjxK2hI
 EoUbjPXE5iTbDuDvSdgozLLuX8cUu+pkkMbSSzDvJenxldfHO3MxG1ddHVFfgYOheRWb
 Vr+zYKI+o0YGeCJZa/2sqW9ckkCQCBTZNwgBJhWKAUZiK0jx40Mjc8n2VDtITMYjsDWD
 Zv01/VSRuPIZOTJyzRS21kIU3Hz1OzBOYFOJuoRKCKFLBBYfWfBa3mZ9atLxDBMYThIp
 Ovps1FgHKf4Z+RLm9iDK5xs7LDi9o/tPP/i3QG6rxkMLHxpNHmQsFHltdfTCEntnQgX/
 5t0g==
X-Gm-Message-State: AHQUAuYX/6L4NfPbLLt9CnAPjADBsEkm5WWfDxa+qQk73Z1LxztdaSDw
 nJ7x74GGW/IqJObDTi8yYOo=
X-Google-Smtp-Source: AHgI3IYw/k+kQXFFJH0VPzoQMV+1Wj7RkmesoDxp//a3KMm1MSI9pUhSfkOM+eFFGG0+ZK3p4tlkUA==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr8358239wrp.44.1549876906593;
 Mon, 11 Feb 2019 01:21:46 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:46 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 1/7] dt-bindings: timer: Add Allwinner suniv timer
Date: Mon, 11 Feb 2019 12:21:07 +0300
Message-Id: <df301a8a7c97f59eb7c87cfc9c5be2355fc6bc71.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012148_525583_08636C6F 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 5c2e235..3da9d51 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,9 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-timer"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-timer"
+              "allwinner,suniv-f1c100s-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
