Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EA2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3F42192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZARe+65";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKheqm56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3F42192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dDOkV6jlUsS08FE8T4N2xl55Rv/6nrXa2cE+qZp+Gd4=; b=jZARe+65gP/k1UiuQl3Pkv1RNM
	MZ3+EF2QlG/9N86WMUpzyM++wC8RkcCQVapHyWLJyMU1A8Mf5g8ZI+R+xKDbpbvkXcepAuygmYyOA
	f+ByXxO9lJ4Gh7eDMRoIk/n/vSHLcHf2TEKMBDAm2+EoAtZQ6k7WnXmy+i+QZstud3IBUP8a09PKE
	1huLTTquDio/+s03fsdv78RfA4sPEjss6ONSGji+2/8mbc3LIll5cmzZ3baSsMzgT/gTmBpdwrOrI
	KQcggVo598PgyMMdLBbTQv+fc9G60Ub0A/jmp5q2A1uwf8DwOyY58nYSmCT3tyFFV1BLdA75nmxUC
	735u3MiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudt8-00050J-78; Fri, 15 Feb 2019 13:50:46 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudsI-0002yP-LK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:49:56 +0000
Received: by mail-pg1-x530.google.com with SMTP id q206so4856644pgq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
 b=KKheqm56wSJPNiObAsGRMR7nrwuSfrpChRtT2s+Z6r4ZCn17x5n/EYfI51tsXdaqpG
 FCBLKJLo6I2Z8v1+YZEXb/oB6nCinG3V/usVnVfxVeEKUmuWhIS/ALxIxvVu0BYaE9z7
 irViSXv7Tn2WD0Naf2S9WObt6PPqL9d+oz0dbN0MdICsRoD/VBq0f4eXqeqKFDeq/FiR
 lQoP6F03APlT4zzYFTleBlQTVrWTaqcbdeVDoBEJ8LlHA+Pw+MbKRVa4PzesSimEjapk
 Jv1WUUbbkVwEbe+oFyCJ0+KzKvWDBF6rBLSNyEe4dOXe/ur4Jy15/ZyDR+Me6nW9dMoW
 B+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
 b=EarjdQgqn+euWGjjaYu98DJsXv3kpGgw6f7IDDN/e2W9uSbKRNL/6MO5Sh8OUtpapj
 WT7nk2cGr2lsitbbknr5q6wi4GJkgNnKj5UV+JEUHEKC8iQClvZYd2dFAFvQ5A0dKmsp
 qs7ZQjhFGcKFV6PxCrcg2Zkgb4qr39Ox6DS/TsiRXgFsZo9gfF3X+ws2iBKNr1h0C56B
 TJIRXb2WwtsM9DWwrljMiXWj8jQq8sBjyYbU581X2IO9nbOwBcaKh4DaDcCurjMr7uBw
 +N/x6VsrWAIzRKFm8XnJz7SP0z75NDkHaotosrO1vT5KieEikagsG+cbkanaL5ypLG06
 /Q2A==
X-Gm-Message-State: AHQUAubAu+tmgw+1IJiugB84S8EPm/X1X+bMLHBdFSrub7iTnlZVUOow
 QaBI7gGnAr8tvpg/iit0AvI=
X-Google-Smtp-Source: AHgI3IYakrreBuSO4RtFWN/QeHmDAv0CIXF8Jmh5Tj8DSnyIC2iF243BrWxBRJj+AtrXTXroF3jijg==
X-Received: by 2002:a63:c204:: with SMTP id b4mr5442261pgd.335.1550238593092; 
 Fri, 15 Feb 2019 05:49:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id m7sm12430968pfj.162.2019.02.15.05.49.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 05:49:52 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATVH v2 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date: Fri, 15 Feb 2019 08:49:36 -0500
Message-Id: <20190215134937.10259-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054954_703700_D39BE800 
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d93a7add67e7..723f5d991a74 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -26,6 +26,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -33,6 +35,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -40,6 +44,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -47,6 +53,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
