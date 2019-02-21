Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E37C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C13F2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bckFgKZS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzvBA2Wv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmOYJFEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C13F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O5HxfACUXEtfmfxx3oieGgsXSvuauuQfHRPNrU2vCKI=; b=bckFgKZSfLzbbd
	/NwFmQn7g25/0Oi3dp9g0msel0kwbFh63ycT5QllId8FxGj+4gYncUP2yQoZZlJ83rbJlb/02wetc
	eRbGSDrlGGg1czPeW2k+UMCxvmOb+C1ocPaGJbhasGJDypHXqKVTU3kpKog4/wUFoCzjBK1Z+fBgm
	FTxJAfJqVUTBR+eY90lwiFwCF13/YTTqIll/ES5jM4CdcDsN/m0x2i8efeluXHmEWntQzA3paiv9c
	X8lcFPoaBYmg5s40QMlmesXOJiN1dRIAqh1oz7FsXsCTQbpB0sD2KLoDda4D5l8yL1/kSSmUDOArE
	HpF4j73WGFJrrhMidwng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqnz-0000w1-1j; Thu, 21 Feb 2019 16:02:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqnm-0000Kw-Nn
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iBfu8JiW0KblxSgvppeS9hOf7r89GcJL5ioxOOVRNN8=; b=UzvBA2WvHepyUAeP+k2YD1vjy9
 Hiiojjo2tgj3mlklpGG6hvmcOL8dyBVkydRPYbkUEao7u10n7ogBpl4pES3fCyysIEHR6SIg/z6Kq
 04g4Eo8DJtIU7lJe1FdTpyS0iuF+AGsq5EBhBxYwn9lceDQ+83wI84wKDVNNn/fT4z0dXrSN+ENJr
 i5TTbBew6COUXcLUlFSsxLONw5G5jXDnzZf9Cvq0RRTpo2H6w4pHUDjNJcK1BrOdnTTsiVCc/DoAP
 fN6g3vhVLRx8S7VZ6xUTuG1Q6rqkMx9TM5AR49QdkGW2snUa2QQKs1knsnZNaCDD36tnAd91T6/YL
 vEMZ14Hg==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqYL-0006tl-EI
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:26 +0000
Received: by mail-lj1-x241.google.com with SMTP id f24-v6so24414653ljk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iBfu8JiW0KblxSgvppeS9hOf7r89GcJL5ioxOOVRNN8=;
 b=kmOYJFEo8MpZ5ILZS51hnwLHxYHsTO2hEZivsMVB/ygYs7Z+Ip8Dvank6vE3oskVcW
 kpxeMWqaRNSyWkBPsGTICk5A2Lr5I6EtXMV9g9SzsrkchDCCU8bb+gQmdMGdifOiyUdj
 ZkO5oKhHuKlGZf09aoaxNBDi41r5sFCPYyutoidACuD0rigX4XCV2z/UWcVYZ+bxFHOc
 GIV+5ShZla0erxpw3XGLWpuIqbcSJPYloV9OdccqmvbtuXprcaSIx1zVPGL+DA/iTGJk
 UZNqxw8bDq7gC3u2XsJK98bQRgVrPTvmVR32cclB2w8CVdVvhLvpRUMAIto0s73TBO3B
 5d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iBfu8JiW0KblxSgvppeS9hOf7r89GcJL5ioxOOVRNN8=;
 b=I+RnHi1D7dFc90z+w+1pVjudL6r6ZnYddkimsxBkRIIbwXEohteBDQeYdaYlfC4a6i
 0L/6gXgEt2aoGwoR5KdFOJYRQluslj1Yngjg9pvLaxZA3g1qO+AKGHADdj9tJLEcL2IW
 1d4r3B9B3XNA6Stszys67T8vCecpvjxxHJBR6KkhuuQcc7kxHl+UJ1p4S0BTZ3so01Xg
 nfSoLxexQ4lqaUGy1T8DFBOzVzEZZcSRzTYteeeYsGHoUSaYaVLSP57NrF2dmGqV6xqq
 0Evwb/sVoab27KoGvo3nVAjNEsHs8Eo/EHJw2FBdBCMtVQlFplMfV5DEDEjNg+R62sEd
 454w==
X-Gm-Message-State: AHQUAuYIE22vi9yx29R3rfamG45d97Mw8cScInA+3rRAOqcKpJAo/115
 zLVe9ItlIyIy1+jcP7CPUivTy5L7voU=
X-Google-Smtp-Source: AHgI3IYpXZIRVPke1fUnkMeNVRiHyyb/3Vd0YmA9dIA4HXEXaxws6lDPxfvEd2NvmpPgqxfkYcCSdw==
X-Received: by 2002:a2e:6801:: with SMTP id c1mr13805731lja.81.1550763983791; 
 Thu, 21 Feb 2019 07:46:23 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 30/30 v2] ARM: dts: Add queue manager and NPE to the IXP4xx
 DTSI
Date: Thu, 21 Feb 2019 16:44:58 +0100
Message-Id: <20190221154458.23763-31-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_154625_513298_FF6DDCDE 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The AHB queue manager and Network Processing Engines are
present on all IXP4xx SoCs, so we add them to the overarching
device tree include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/intel-ixp4xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/intel-ixp4xx.dtsi b/arch/arm/boot/dts/intel-ixp4xx.dtsi
index 9edd49509af8..96a5a02f7ba9 100644
--- a/arch/arm/boot/dts/intel-ixp4xx.dtsi
+++ b/arch/arm/boot/dts/intel-ixp4xx.dtsi
@@ -14,6 +14,13 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&intcon>;
 
+		qmgr: queue-manager@60000000 {
+			compatible = "intel,ixp4xx-ahb-queue-manager";
+			reg = <0x60000000 0x4000>;
+			#queue-cells = <1>;
+			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>, <4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		uart0: serial@c8000000 {
 			compatible = "intel,xscale-uart";
 			reg = <0xc8000000 0x1000>;
@@ -54,5 +61,10 @@
 			reg = <0xc8005000 0x100>;
 			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		npe@c8006000 {
+			compatible = "intel,ixp4xx-network-processing-engine";
+			reg = <0xc8006000 0x1000>, <0xc8007000 0x1000>, <0xc8008000 0x1000>;
+		};
 	};
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
