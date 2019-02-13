Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6484222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="egVZYLQL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaeBd61c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6484222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mZaJ7WQKi0yHorzjFUVlcvR3WAGZzfmHsUVERkR0W9Q=; b=egV
	ZYLQLaRNd3iHmlNKl8UPuAq0IVjgfPu0yGDN+eZm0KslieQ75rIk8ej7ZOO7+naRd0K9MMUsoYNZU
	I0cJ4fvratROecEzUPQsnl/qrYCILF6yicQXjFtB+eQU/iEzgKMSdkN8WZIfuF6oyufaWr4MAqlIT
	HNZ6jn5078dZj22YMgJezWE6phkLjOdRntEgyOzNvvRrSEvE+DHFAJCWtyrKa75KODvt4QHTXStDX
	teB7g0TzOM1jWFal1YiEqve/RgqSqxkArPjXMszvTyNQWgsw5j5cniLnrHhv9o/wHwXPBN+xiEb44
	DNmUFJ2ILKcVhJRQdjGtN9xbjEAU4Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzDo-0005lt-77; Wed, 13 Feb 2019 18:25:24 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzDk-0005lG-JQ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:25:22 +0000
Received: by mail-qt1-x844.google.com with SMTP id v10so3735770qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=zOZ+8nSG8Sb03iEOL0M+UcixMozhCfMx/rRiG5VgEIU=;
 b=FaeBd61cuAxoz36aUMD4hEM8q9L9Bz0uJwQ/qd1Ao2mfYlXgYV2NfIe/A4CXurPyTW
 OES7YmZld5cxuTjJnZV4etMyNx+RqVLlMjk2LUYPsgoFIQp78MY3x6getP1QoJb/l87r
 p6MjWSOYDK+ildAhyv7b/YbifrWD+ts+9EuvGdix2r4R1Jfz7ip+kmNIFg/1izikBJuH
 rWmqVAQVmRpmoiEYCockV9EHN9PUeywO0t0hbsvPuPr+iFa0klexyRs5VeJXoYs52YWO
 mw4SM81GJ7WeMOXqSh1TZsW0J0srDvAFLJJ38WGvWW1l6NwZ+vd72aYDOtFeJX+J7alu
 GFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zOZ+8nSG8Sb03iEOL0M+UcixMozhCfMx/rRiG5VgEIU=;
 b=NWx+jhrq4fanfu+02NDhL1VCWO2CA0PzvzEdUd4rGsNmRYH4zvy46RuZ4URzXFH1De
 U/k5W9XJzuN3pZ+Y+BW678mT5Tk68ZTDVcbiRbkDCF3h/Q3eve8LxMyFjUCo4Mib+h8O
 WjZBIzLdP/oUcWc7x3yd7SdcJtZy816EgoSDXWCDFrnFokKO9joINs+PGWJ9kScRU+8H
 /8+O6cK+PefZ4/M6Zv9qgLjGLMeH3y+z5ViV/vsNKWfb/oyoWW9xlEtEo+sGexJ66Yel
 FmTcbER5OHmiS/L6OwiPvRe2zqOfmwB5UjJxztOAMaiNY2DQ4h+gmrqulPKILYv352yy
 4Bog==
X-Gm-Message-State: AHQUAuZqGiRAUJ/K0yh+mwjvEe4AeG7pAL4/Ilx2L5nQ5ItWOdFdC578
 njG+hOm6uSlzK9wHcEh2AfI37v+2
X-Google-Smtp-Source: AHgI3IZWErdvSELjNgsCD/uxC1Dt7/a9VdhRh7UfceJWLDCqXLgVf2cLmilQIJFanTlhR8QbFJ7tKw==
X-Received: by 2002:ac8:23aa:: with SMTP id q39mr1536600qtq.82.1550082319153; 
 Wed, 13 Feb 2019 10:25:19 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id l129sm1596796qkb.44.2019.02.13.10.25.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 10:25:18 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH v2 1/2] ARM: dts: vf610-zii: Disable SNVS RTC
Date: Wed, 13 Feb 2019 16:24:38 -0200
Message-Id: <20190213182439.6184-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_102520_663133_3DA85D9A 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: andrew.smirnov@gmail.com, andrew@lunn.ch,
 Fabio Estevam <festevam@gmail.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
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
Changes since v1:
- Also touch the recently introduced vf610-zii-ssmb-dtu.dts (Andrew)

 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 4 ++++
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts  | 4 ++++
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 4 ++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 ++++
 4 files changed, 16 insertions(+)

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
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index 2b10672fadbd..60dad9c228a9 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -211,6 +211,10 @@
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
