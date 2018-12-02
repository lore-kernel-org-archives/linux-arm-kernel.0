Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207BC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F42A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2EB2C72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F42A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBRLzjCrMTWCyonEU+N2FkI/8NX4/2gmv41nG4SR6VE=; b=i2EB2C72Hz7wFa
	LzYzCbeF00j28ILo2tFwM1tH6gF6v21gTmlBGQgtknZiWEVQHT+SRVAlg9rHlKv3Xap669M8ocbUs
	Nbi3AWQKehTPwQoEKMwAzO0/RvRYlsmnIM4QzfWEdMqfd6e/mNa/nGlVVi7bDZVN8C9tnIGX9WfKc
	L9BlqkZZ2I2rPjJgprlLguuaSNAtTUZtZzLwVRo5hNzfJphwaZaExoXvP96J211XvFmCZtag3pFRx
	IOhbt6aXGfPN9SY6pXlt/OZXNfRot/vXX45vOMbDus7fUNVOL27e6YZKdh4unJq+5ycRTGzWWd2Pt
	RYYKHdPUo19Bi4xG+i/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZ8q-0007t9-AX; Sun, 02 Dec 2018 21:19:04 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ8h-0007Xu-H5
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:19:00 +0000
Received: by mail-qk1-f194.google.com with SMTP id o125so6226702qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=kMmCdcHh817VaRsjdnnuJ2NzdFpse3gt0nZG9kO//8k=;
 b=LwpHtL1K6vW0lb72jhBWTUyFOyHJHoot88ccKBZy/ozgvaDwi6NHiTADduZD3JMME8
 Z4vw7jG2tjf9gseIm4AlE5dc86DYO/YwNZNhqbv2q/MKqirNiOMM6/FXskJ2mdguiuC8
 p53vTrOReJ2ebDhOL6dhf0zLi1YjcLTFx/rd+f210uiwABVfkXsdlsy38GwhfYaZ5iqY
 d+CuciIZwzPr4l781qxdo1myzCFvEMmTTpyyN71Yf3k3L6S64kn7hb2oZAkP+nEogXKw
 wDiOa9pMeKCtLlhV24PEHBNvWOnZKrVl+QJwkXKC3OCqN0Cy7DJVcQf9o9jUKyqVVUAO
 wMxw==
X-Gm-Message-State: AA+aEWabzd62dMiivvt+pAPIWY+plzADHnjgjvZm8pglUx/yEXzIfIwI
 N42WODS4sav8eNFo96YJEQF5+RY8
X-Google-Smtp-Source: AFSGD/VUdFF9ST2bE1mVu/A1aHDJAuATO2XuJ3SVegrszEr2sMBgvEacIDdqLoHXEk6c83BT73s7Aw==
X-Received: by 2002:a37:6749:: with SMTP id b70mr12652812qkc.41.1543785523843; 
 Sun, 02 Dec 2018 13:18:43 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id m1sm9610025qkh.15.2018.12.02.13.18.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:18:43 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:18:36 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: dts: imx6ul-pico-hobbit: Make the child led nodes
 standard
Date: Sun,  2 Dec 2018 19:18:07 -0200
Message-Id: <20181202211809.11621-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_131856_177231_CF9C499C 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Use the same child led node and label name as used in the
imx7d-pico-hobbit board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 3cc04dd6f341..8656ccbb5a06 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -15,8 +15,8 @@
 	leds {
 		compatible = "gpio-leds";
 
-		hobbitled {
-			label = "hobbitled";
+		led {
+			label = "gpio-led";
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
