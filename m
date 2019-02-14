Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C861BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C47F222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cNVqQGxH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4zOorQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C47F222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GNeVZmvBrELk95YJqs1FSzb5BFBEu48FONu7oPlKfIM=; b=cNVqQGxHPFW0IhtVtdguTk/7UW
	ZYjhwxh3RZu62PeHQO3rajMyD3714GIfphvcQcpmKyhfJ74wd9X3lY3S/DcKCXUBLxt22DhIvdXWl
	XbLGhwVgsEmCkgdRSeWGxss0g6mn6z8f51yUxndhrkqArdRmCQED1Q/Jkd9MJL9MLeUIBi4OTZQjN
	t0XmzYA7zGjnSsFZD5PeGWFI8qWEZjqsbFMTEgG4ou4VYc/NjeuZOYKxDFSLcw5P8dfO+kZJIILqt
	+oOAZUSVV1598tiYD4b+DJrHHYDPyyWuwSlJKCIqNYp8k0e2/0YcdXY5XOJbwyBw5ZFIo8b1DspIl
	rwsmai/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGm8-00029A-LI; Thu, 14 Feb 2019 13:10:00 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGlg-0001ZO-BQ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:09:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id n22so3102435pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+hK5V+00HuBIgvwFBMqvf1caVsLQS7fH30vXRswk3QU=;
 b=N4zOorQCPStoqHAzK8dkZTKIuQP4g/v0c1TBWu0ordNOpN4aVAkxtt0rp8IsunV+oL
 JZabue/BQgQ7oyk1EZFxhswYI6N4VS0t8uMNZvLg0klSFmA5pLDU/mDgolH0dEyGqxSm
 zokMSqu2kCGY+d9fL3j6oEt7yEAEVFngv8Bt9ujBDho+vikddNE8PbjcZmNNm0xK+MCi
 dWHOIfn8STLExiLjj+3+wW6TT+z4mheqy+c2CSzX3jrz1mNHO5s1nIVyWxsh5+siuqpa
 pEI56Q2+P7RJ7kS00p3dEpWoSe0rH1mNj+67idrGD5TyQh7qFhQI1MpTdTT5GbonMBbK
 W8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+hK5V+00HuBIgvwFBMqvf1caVsLQS7fH30vXRswk3QU=;
 b=XcVMKv5hZh+lV00lOKYECE7tg0N24rdfzN5nMaAUvRp2wQ75LXyeH6H8aeGKL9r+Ul
 SD8ZZQgevHmlRoSrAjBIpMquE86JkRPiQWHRjt6EU55CkiR+mKZXoEhbwPYFabH3nP+m
 +YdFlsKWLGkrF4mdfRGCVeD9IE5jwpydhOJjGPQvrl9T1VyPsdLys2ntmVV2ugDW0xGa
 h9UczkigqdPIDLSX5Kq9Yz2EGnu4LF0nMbjW2Zcu397r5DbBjxSr1qF9NPx/BChQReM/
 OiydFACimEVje8/u/t2V1ZasrBZ2xL25f/d+tBj4OZkc2O2m4rwfqIdfTjDCyNPDTI1O
 V3JQ==
X-Gm-Message-State: AHQUAubmU5Ta3oCXXbABICqvhs8zxzjhERXzdvVj9mpadrBMaMODn1MG
 VpWQesbotVe25KR2LkLsbAE=
X-Google-Smtp-Source: AHgI3IZE6om4PCXUD8l/xFXDXYr2gbJMaFNdC2/Pesiz51GgDeT7X6D+cXbbQrjUMdXMQpgE/YpFtA==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr3810384pgs.166.1550149771864; 
 Thu, 14 Feb 2019 05:09:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id 15sm3625336pfr.55.2019.02.14.05.09.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:09:31 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com,
	wens@csie.org,
	robh+dt@kernel.org
Subject: [PATCH 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date: Thu, 14 Feb 2019 08:09:09 -0500
Message-Id: <20190214130910.9201-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_050932_900575_7CD0656A 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
index d93a7add67e7..57a1390ecdc2 100644
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
