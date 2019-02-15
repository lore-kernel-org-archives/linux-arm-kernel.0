Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A365C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B322190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pnV4yV13";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emxoL1Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B322190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dDOkV6jlUsS08FE8T4N2xl55Rv/6nrXa2cE+qZp+Gd4=; b=pnV4yV13Ypi6/siVnBNG39e3/W
	LuONQBN3hS8sOrShy1SIhizdg1sZbV8oEJN0RKK9LTf/pwNwbIjAxR/EoU8+AIUN+fW+U26x+1VNg
	Se0d9vH7LYwke5/Q/fqL5Vy6/C1g5agssxNeeLMea15H5nggOjlLDhc3/3KuD2ugumyFewFAZYabS
	V+13PA04OUX/KQ3H6yK3PjEPR54DQXZjkeMfw+ZsO1bU3JLYfDRKuQEaQIgf+0WP1I5/IB5EyjH7e
	SPUEETF3SGSwlm7jwTpgRNvVD2wR4beUgYjniwkCn72XuOpCK5tJRGmXsay4kN0MsOlFXwyoKcOw3
	o2enL1Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufou-00072U-9C; Fri, 15 Feb 2019 15:54:32 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufoV-0006Z6-Ut
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:54:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id c4so102802pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
 b=emxoL1KzvzBcIgE2xzDLh7qQzKB5SPIhFRdU/nNbfCtvQ3N2E0XxdLeXWEw5rtjIqM
 kRk6rj0ofsbvEBSyjwXDDG8RdvsAZp/t8rRWT0E95HrJuh5q6Vm0SeVxWHqDM0WD7Jn+
 uVBum94XxNDtNnfv8ap3JWNhdkbSBivgcE7W0fPGLEyZWXEtT6CZSa2+VM0uJlsvVWMz
 2rBn2+BMW3XzTmmS5JUUrlPnK/FTmXjhcGnmeXBvuA+42WEDvUAzGXRDTw8zg1U1ZTPC
 gZY69Q7rtlfVa1gotmkEpvX++r82UIVP94lp53OA+oqI69XmjdmR6oPFSm3yjYZfkU2l
 FHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
 b=mYStxaa1SvVrLRMSi5frP9tmfDjrmZh6aAA/K2IjSO8IE90HBBAZgX4MKdMJV4tp0T
 uJomimLk/UMKbMEr7PrBu0KfwvbInCfrYNDHC2B9blqL2bxTXMAZ2mkWCwUZc9uV+/21
 j46LeHeF01Kx7zOoLAjxY7rFAEeu5JJHKkzP9SmqXE6bK5ODF7GCY7BsAqhlHhN7zd0h
 30nsaS2KxIUUFyubUqSr6CobyS6XI2GOJoS0LvanLKzvvPIbhc4TrE+BDrblIh6cxjPE
 osU3WeeylWocjTMzAFWL35g/GwVYI6Zg7oeIXSgNMH2CgAUjcz1GIEjccOX+HeovKvnT
 BxWg==
X-Gm-Message-State: AHQUAuavVxtHEqYxAOkcLJItYy7ISugIemaeUIkUYGvh6GlOLYpAIz2s
 rZOoXV56I+Eje8b6MYOMbRQ=
X-Google-Smtp-Source: AHgI3IbrDAhQRuLksuCQbodqFBztTLP/msRY10qRi8FyOrURXineipyQrjlm6aaywNpMUCb9I3dFLQ==
X-Received: by 2002:a17:902:8346:: with SMTP id
 z6mr6310437pln.74.1550246047408; 
 Fri, 15 Feb 2019 07:54:07 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id f2sm6217792pgp.32.2019.02.15.07.54.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 07:54:06 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCH v3 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date: Fri, 15 Feb 2019 10:53:37 -0500
Message-Id: <20190215155338.10564-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075408_513649_7DA04E77 
X-CRM114-Status: GOOD (  11.79  )
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
