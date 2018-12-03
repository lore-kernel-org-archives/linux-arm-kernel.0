Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFD0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC9420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FnYEKggz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CdtOUgRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cLHQOW1koUUNg4PJZdHuG4H5XEYnGNOST5anZKicJl8=; b=FnYEKggzdyjY8r
	pUoPuYJaINjflkNtyupiU7kfet3aVrbjeIotUAVySh6hTqbS3wXHluaNCJLb7GVh/3se/sqRLrbpe
	3R+9MwIfDsJPnW19cioOoZGzYbiVwkzzd52s1sEmnZoEap4oDMqepEyj6isRw7tdM+tn9GmTFPyfG
	fkQd3JYhTB5Op/02Th7FSy/lVPM03LCpQu+71plqeVF4ZOfoiC+XVxM/vNFGO4oShA6fU5NM5ScSV
	EhGL5ZgsKf1gnBlcylXkn0vsE57z3aEUZ9PpYKVVGfgtFGfLTldUXZufC9f4eiw3oNTTQyzKr4OEt
	cI5ShRUa24aWw4Dbya4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlIG-00018o-7q; Mon, 03 Dec 2018 10:17:36 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGr-0007z6-M2
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:12 +0000
Received: by mail-wr1-x444.google.com with SMTP id u3so11480600wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O05pEMsjPvSm8OsI4DmhPRSk9+B31/RzfWZxO3ZP0hs=;
 b=CdtOUgRd7fKTLnNnApGPpwX5/e1tQjDrTcncF5Me4HkjmwfnmkhMlrZz1HqvJjLXT/
 sEKv6G9X5uUdL8V81quIJdVbM+WUzBKgHM2fX36kdItiuq3OjQSXyS/ZIa/MhVCGCYmw
 TRFqlCEAcpVWwiiaFbpcWaf9KYTT3yQtsdKXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O05pEMsjPvSm8OsI4DmhPRSk9+B31/RzfWZxO3ZP0hs=;
 b=qmuyGAToXduAsKZQtI81V9/xqYGhgZkzHBp83V0GDPff2YVrzIPOpFM+ugaD0AkVS5
 LDrGzuHhyDBb22UpO5jtky9kmOUQt0vQDBDPhP9opWnXXL2KqDGnuT8TvOpWW7+rhCtJ
 93iMIAqas1RI5eGIhoOleacjJqg4lvqKS9aNCarENNw6KyNZczT8JrOH1n5RgwKxqQIr
 EZVPBqopOxvB9Rz4h08sLCSn3MKqg2fVzP36oW0QKjpntLakVGE1Lf+KBiveFtjnbULC
 jWliu2GtTDOt1DKl4df/14efRyt5Bf+WFcnSa4OqXYolrot49qA/99h/PA/UejxpLq2+
 X78g==
X-Gm-Message-State: AA+aEWbuE+pWRE/E6TdjVJqJgFHn9KIBfd1LSwHbaXbnNRt8vlLkLneK
 PnIPJQvFOVglCBpXzYG8w20vyw==
X-Google-Smtp-Source: AFSGD/Uxa3NMQLBGsOsZ0LU5sErOBIuU/IbCycZtoat/FVE7R+MSb+HMM6jhcqw7T7YHjI2wwMe62A==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr12893016wrc.0.1543832158090; 
 Mon, 03 Dec 2018 02:15:58 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:15:57 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 3/9] arm64: allwinner: dts: axp803: Add GPIO DT node
Date: Mon,  3 Dec 2018 15:45:41 +0530
Message-Id: <20181203101547.16835-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021609_721330_7FC12A76 
X-CRM114-Status: GOOD (  11.93  )
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

Add GPIO/pinctrl node for AXP803 PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..c6b95980d476 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,13 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_gpio: axp-gpio {
+		compatible = "x-powers,axp803-gpio",
+			     "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
