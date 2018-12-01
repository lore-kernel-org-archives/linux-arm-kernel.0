Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE78C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1A120867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjJ6t2O/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilN6XTIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1A120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2lDMMguJwfac5tiPniDNKraWiQhc1LmkIerML03qwB4=; b=gjJ
	6t2O/f6k9PFuWEWeaAZ8X38X0yf4tzukLPisYDEzU8JB0e0fsZHMTqrv+IMdfwOOGbetsufh4fcHp
	OKhoZWgxAMJ60MTMaeUYLN3DaSrFpEuc73pHFgwNzCoPUchPa9iPi0vX3tmSjVbI0nYj5taO5ILO5
	vKChmSv2D/NzA5tJWceEXdvsYsqTckONtVByv31+RoiWT4iU/Y5yVOqNN3gxALXwpDQb/aAP11SXC
	iYgmTf3AS1/NijZMk1khNZSGcJ+RkeVLdLoj3DnDXOzBewGD1q05N8R4K4EocKymtqdAZlbTRe3Tu
	7u5/tYuXoZH2aNO8X33s1DKGNR31mbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStPD-0008Tw-Sb; Sat, 01 Dec 2018 00:45:11 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStP9-0007AN-SU
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:45:09 +0000
Received: by mail-qt1-x841.google.com with SMTP id i7so7941925qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DB75ZZlBOEP2IIajOQQNUh36kLCLM6JmqTlgKvH+qr4=;
 b=ilN6XTItEF/rFN74vxFZPlgQUaBKyGICH5c5eWr49SV4Phuj/9GV3+rcm8+DVQUgfX
 ofD20nZ5WjiGfvPerVqf0LBfUq1givX58wpckTw9V2KBQBUbSVycsQrqffnPWiiQnUb+
 LaPs/g8EaZkfTh7qbBvCCAtdnBvz6zNptHe8kDiRZQheo94UWz8NorUOWuHVb7khjeCn
 va5UKHoWTQynq/lsp12VCfAbChKoDaMFRTLjFMIceYZhZDO42OyiJqdizGRx0zGUFFsL
 GVnJqDL3UkRhKohXca7oDl5+FOWDi7a5I1v8sjDzRDEP18pPbTsdry7Uo3fYJAAj7sIz
 j0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DB75ZZlBOEP2IIajOQQNUh36kLCLM6JmqTlgKvH+qr4=;
 b=Ik44A44jeXJC2UyQAAPvflPzQAsJ2qbpPgKxOCgP+h8yXTsEeSkLM05YRRWpJg9AyE
 mhuLRYjBxG8araRNECRxNqWpRBKbPTTabvRGpIRVu4xaV2/cKmuxarwO7aZ1ORh/XAAc
 y2tA6aeyOzuackCqdEDHfEAGKAYadhiolZ+LAw/Ifx6TNTFs4ibq8N7R+7FZsUiOZvtd
 izLuvoooNy1ZJKt6YZDLWMT6K8IawtaivNIjisI4nBMetT8/1SFEiqIUNjNTk/FzEiPO
 2ixF97t57Vw1MLLUSMA0jwDX6SK+CczxLh979UQJ2lEEzirk3QmrP32Uv4BsJo4VDkJN
 C6qA==
X-Gm-Message-State: AA+aEWZBMhuJEUGEFpC5Gpi4EgYACpoMZUaqraNmkdDvjOEqd0y7FoMB
 NIw7ISqO8uoGFFGeVji95ZQ=
X-Google-Smtp-Source: AFSGD/XX01Ak0OdkzpT4MVeO5fpmZhwtBSriDaCfThuPyF0LNreTGmZv4DbFU94O4gwbWX/foIH6+g==
X-Received: by 2002:a0c:b5c8:: with SMTP id o8mr7787782qvf.213.1543625095872; 
 Fri, 30 Nov 2018 16:44:55 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id p31sm4699420qkh.86.2018.11.30.16.44.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 16:44:55 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: vf: Fix memory node duplication
Date: Fri, 30 Nov 2018 22:44:52 -0200
Message-Id: <1543625092-24498-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_164507_929006_EEAB4BB7 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 stefan@agner.ch
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Boards based on vf500/vf600 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the vf500.dtsi/vf610m4.dtsi files.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf500-colibri.dtsi      | 1 +
 arch/arm/boot/dts/vf500.dtsi              | 1 -
 arch/arm/boot/dts/vf610-bk4.dts           | 1 +
 arch/arm/boot/dts/vf610-colibri.dtsi      | 1 +
 arch/arm/boot/dts/vf610-cosmic.dts        | 1 +
 arch/arm/boot/dts/vf610-twr.dts           | 1 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 1 +
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 1 +
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 1 +
 arch/arm/boot/dts/vf610m4-colibri.dts     | 1 +
 arch/arm/boot/dts/vf610m4.dtsi            | 1 -
 11 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index 2e7e3ce..237b024 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -47,6 +47,7 @@
 	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 76a0949..b0ec475 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -10,7 +10,6 @@
 	#size-cells = <1>;
 	chosen { };
 	aliases { };
-	memory { device_type = "memory"; };
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index cab9571..689c893 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -16,6 +16,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index aeaf99f..05c9a39 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -47,6 +47,7 @@
 	compatible = "toradex,vf610-colibri_vf61", "fsl,vf610";
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-cosmic.dts
index a3014e8..ea1b996 100644
--- a/arch/arm/boot/dts/vf610-cosmic.dts
+++ b/arch/arm/boot/dts/vf610-cosmic.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 59fceea..dbb5ffc 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -14,6 +14,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index b76c3d04..7cdcc5f 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -16,6 +16,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 5ae5abf..19eb4a8 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -50,6 +50,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index fe35766..757af56 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -24,6 +24,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index ca62495..d4bc0e3 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -55,6 +55,7 @@
 	};
 
 	memory@8c000000 {
+		device_type = "memory";
 		reg = <0x8c000000 0x3000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
index 8293276..76bbfd5 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -50,7 +50,6 @@
 	#size-cells = <1>;
 	chosen { };
 	aliases { };
-	memory { device_type = "memory"; };
 };
 
 &mscm_ir {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
