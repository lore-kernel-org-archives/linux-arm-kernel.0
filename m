Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA39020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhF0y9e1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTflcLW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RJa2k4JYQrpRSlPJLKCARu7iyP/oM+T6R0Crjv2N7O8=; b=KhF
	0y9e1D63pHcUCZbC2rM91jPKDjaUI62zM5M5P1C7YZ7pN2FlJlXiIwfmdQ5LJt1pXygVYw0he0waW
	XbpAs0YvlVil5VLO2rBnMO2mtyeDWoXdVgqL5bWXbphXDAmGzCa6YCWVIzRmzyULdNFmbc93GRe1x
	IWa/g2Nv3jDk9nfoOZ3v/m7hUosg+3p+XgqRPj/p0tKX1YqWBIeLibPChnD84j5L+2FXGrI7dCo5J
	SfEizE9a/rEjPMQXx4uRcFyFopAXMhokWtp9HMVEdJ+4l0CVqkE4FkQosjRKmpQINBpjuiwSijTiy
	e79DrK9SfzZe2o/qKV58axEJseBxIFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSNxj-00069a-Ik; Thu, 29 Nov 2018 15:10:43 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSNxg-000699-DV
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:10:41 +0000
Received: by mail-qt1-x842.google.com with SMTP id t13so2306545qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=24Zfl14dSHItwsLex6Nau/SxgPTiGS7DkkBvQYEghuo=;
 b=kTflcLW5MnvL/OFuXMwcVbqfxjpWTOrAznv65qhEC0ZEOhvOpLsYuXWhyhRHVp00j5
 sBPTUP43epj4FSWjfuKtxh3dJSGNV4A/g9zsOnUrghe+/pPItxKN4bR52kC0oJMH98B8
 080SPkVm4YrCOV2Fhx26fTVUmpHLep7rH0rJ+Px8G1Vb24Og0LSmNnuu9ddbMg3yocU7
 7oLsl8vN7urfhX8JX6Jv4779QRbKMb8fHw98z7Cfnoay2tAXm1g7uuUZdds2M+x2u5Uz
 ufYKqfya8o4wGElN4JKomnmgVY9bb2UMu7lnZzJPNwxvnHRgAas9/3ok1Jcolax62m5F
 jabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=24Zfl14dSHItwsLex6Nau/SxgPTiGS7DkkBvQYEghuo=;
 b=MD0YQGCX0A46RlznIzWxZROl7LPtZ4nku3Xt86G4KUEbSCjEDZm7vBmVAFNTsYamPC
 diKP7GK3GLgLCIfZdXi988jvjXsdJXm2d1x9tXEADAEehJpf3WopK3eCghnh3g+3ZjIj
 UYOCpPIyNjX4q6S+To/VEO1302K5pEsDIZkoq4MYaC03r12rYIHPnFIKJdnj3zW2NAEX
 JWULRQRFROj+7RZ59K3JIbA0wMD59WbdvGvWk5yZooNPHSR4NpsrDsQHfdExeZiLNXFg
 vvbGMvHiCDSzzHMyd2uIdcwJeKTXO6Dzl0FqNE0rvjyrS1AxPJ1Xv+D+bwfRUB0Sby2k
 /pXw==
X-Gm-Message-State: AA+aEWYsrgMzjUCo6tCGR+bstSzlsTF6/C1AuuMtaYrHiVu2tHeQj+Bc
 sUITyRS/gvsJLzIDK0cEJQk=
X-Google-Smtp-Source: AFSGD/XiYR2RK9A2ZIvSXQ4kRcgEjWcs4Zo0rRLrbOUfkiblZcUDc1ohTcCNi8e2m4/VGPTlzzkYbA==
X-Received: by 2002:aed:3511:: with SMTP id a17mr1786196qte.153.1543504227970; 
 Thu, 29 Nov 2018 07:10:27 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id w52sm1332915qtc.51.2018.11.29.07.10.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 29 Nov 2018 07:10:27 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
Date: Thu, 29 Nov 2018 13:10:20 -0200
Message-Id: <1543504220-10870-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_071040_462741_6B3FA391 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 cphealy@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On the vf610-zii-scu4-aib board there is a hi8435 ( 32-channel
discrete-to-digital SPI sensor device) in the DSPI0 bus.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index 52bac14..a1fd49e 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -397,6 +397,20 @@
 	};
 };
 
+&dspi0 {
+	pinctrl-0 = <&pinctrl_dspi0>;
+	pinctrl-names = "default";
+	status = "okay";
+	bus-num = <0>;
+
+	hi8435@5 {
+		compatible = "holt,hi8435";
+		reg = <5>;
+		gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
 &dspi1 {
 	bus-num = <1>;
 	pinctrl-names = "default";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
