Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:46:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91498222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hlSFuOU5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9PtzgbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91498222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9TDIe6bjS+wpX1FJckYgd9lYkyYlBrgLRG+yAFy/eF4=; b=hlS
	FuOU5Vbt//uclKzYVPMrHVY63h9cwogVrA3GAYjJ/OMpKq20cO2+bm0rbUeS50bIWfVDJns9zhzyR
	EsozxlhXAdvz6O04gKoR9TeSAXz4Znjfrryyn7kwauORycTx5aPX+Xr+Xp9Zhj+9PXAKBha9lk/sS
	rUKp+31C/6tghNf832CEA8CVKU5xvB87sV/no2l4WYkv0LY3i9TwIIjNcNo8NWPPo0zvzba+vC/6J
	WVt680F8q+QroUkce4btLvWpkKgfgnCSOKFBWDkf35isMDy48piu4/YqTZv8XRuf7HCIKJYvPsN/a
	DbNhJSbGx4LOmOGLq1XDdSRjsqvx34Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtjci-0002IV-TI; Wed, 13 Feb 2019 01:46:04 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtjcf-0002Hs-Oc
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 01:46:03 +0000
Received: by mail-qt1-x842.google.com with SMTP id a48so867710qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 17:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Ki6d6zzpJRd+z7VL63xUS/O9s+SjLhgbKOc1NpAUhNw=;
 b=l9PtzgbJvW+jaw9XPjJyBzEmTYtpzoAoSUWZtE0MRbLSkXdbdADjUrVAxOG5gLgkoG
 eTUrmdKGrU/a3ZKKT/2AQToiAuB4yEsHgHUHTBh0+iAFrXCSw7ukKJQc6iVJm/k6JN/t
 1f5aF7rbBbEtefS1RLVKfjZXZEsBXNbhipCy55BahGj9J2JTndXFd3enfXWUJ8UF+Cx8
 gLFv9N1jaM2honl1JqY6cLcLsRH9ji4hRw5hJY8p52f1gHMs0Mtq5wZTEKj5ASxLsmI4
 vTiKyNYOeZrrG8FSlz5cFkxMLmVf87SLqeBwXqE1OF+sboOIPIXkX5wuOGPCo13p1mWz
 6rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ki6d6zzpJRd+z7VL63xUS/O9s+SjLhgbKOc1NpAUhNw=;
 b=SSoCc2b0oZivdHB21wI2BWgVDfSkG/sQSf8R5Bmov22/L7ORTlUj8Pl1Z2CMZfZlcn
 rHDp1CTFsrVTJXAZaQtyqKTCtePIq/k/24eWcDYZhjKuIhzD0TOQ+vHTKgOXUlT3eV5k
 EQ9GMj63Xc87pNuVdXujknK5rVYzdTfM9XrgRhUqrdxayQhZlXwDJYboBA6IDo2oV2qP
 uFe2x8RuWfMJqXpikka0sTmZtFlNMCVke+4LRitPOqatESMAmbhLDK2kZwANaD0Yt+82
 h9ZPrGM4MO8E8U8hh63P0i4cWBFiYO72pYCeGba+8mL/bVP2h4ga528fwMnb9y2VrdpO
 k6tg==
X-Gm-Message-State: AHQUAuZ3CTP6NLNIV63WGmnR4Q0XRqKvHgFYQUU60x6A/DbJIm8oVf3r
 ixHPoxIQP7MrX+QauCFplQw=
X-Google-Smtp-Source: AHgI3IZR0o4WTonppURSaQJ23caAAoChJdA0s1ObRSATCeKFUE33psrPGNmeopoXfGOLqW4DV8UlNw==
X-Received: by 2002:a0c:a2c5:: with SMTP id g63mr5061120qva.52.1550022360372; 
 Tue, 12 Feb 2019 17:46:00 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id f3sm14079315qkj.24.2019.02.12.17.45.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 17:45:59 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH 1/2] ARM: dts: vf610-zii: Disable SNVS RTC
Date: Tue, 12 Feb 2019 23:45:48 -0200
Message-Id: <20190213014549.29283-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_174601_800507_4124FFED 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: andrew.smirnov@gmail.com, Fabio Estevam <festevam@gmail.com>,
 cphealy@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

None of these vf610-zii boards have a battery or super-capacitor
holding up power to the SNVS RTC embedded in the Vybrid SoC,
so it is preferable to disable the snvsrtc node.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 4 ++++
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts  | 4 ++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 445c7dc306b2..440de578d8af 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -236,6 +236,10 @@
 	};
 };
 
+&snvsrtc {
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index de6dfa57bec5..e3952e9ea0db 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -671,6 +671,10 @@
 	};
 };
 
+&snvsrtc {
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 0d9fe5ac83a3..6df3ef979eb0 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -219,6 +219,10 @@
 	};
 };
 
+&snvsrtc {
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
