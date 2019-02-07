Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBB42175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kAYQCCxA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kMRtPItA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBB42175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9eElse2sfbshw+j2a2+/UpJ+D5iSMB/57KZkguaz4g=; b=kAYQCCxAXnAu/h
	kRJAD4sEVGIueAZvH9tSIpaQdwDkjmmTlp9qowsgdaFWnhYljku8iS/MZgUX+yUKX4R0ykD4HOws1
	rugqCAf76ycRGrymWsfrFK+t43vJkGJunbZOGXhMHjQkMYoB2dw6JkF0bW7/iXg8LVOu4Pd8fWifZ
	/WfCMrLMGiRmGnIdD97E2qU6mpNcigAm2Rc9PVXN+wN0KChR4513vOety7V+gZw9115WwZfVHBvhz
	GhIs2jcKwP0tfj3JGon3K9U3UwqbzwqNGt7MQUMUMETY63gB6zV4MMa+iOSJWOPWzAKtn2aQanIv9
	KVfLgsvr4pPHNOMAtpHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjhT-00008a-6I; Thu, 07 Feb 2019 13:26:43 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjhC-0008Jy-Dr
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:26:27 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so4375759wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8XylRKB64rC0etlFc8MGnuHKrAg5r8/oAGOA99T2tC4=;
 b=kMRtPItAaBPkNvo3gAV2Y9er+9FSAnNPV+ICuvBPuMmMMV4POhRy7nveOWRwQZz5uM
 MnU4x1Q5o/XVzzv9OjHiEzS2NLR4bBrtEdEviWTkA8ubXKlzPsfj3HBT93Z3/ubzfybC
 sdm6rQJg5wUu1HnKVARHuXEy3WYZ9Ncd8L3GKADrpqD7GdzU8PUnStc4tywrEp0JKLRy
 oJD4Z2HWu4QaGCIBHKExQ9KlZXDt+Q6clRkZnv+3L++E1UR9kWxyijizFarutBgPvC6b
 fppEfZUsTXguscPeBeTo5U3Np5ME0zfJ0mFcP+xFYXY7DSc9W8v6UWSRSz+IVwDMGK1k
 FJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XylRKB64rC0etlFc8MGnuHKrAg5r8/oAGOA99T2tC4=;
 b=ocax9FYtrEzdiVFecEqNm/9Q24Lb3UAyEfqGPrbMmhU2jlpeB9AHqZc87amZXHKdHu
 W5FSbwV2BfLr+80DVDR5ZvzvHUyiaOPiJSIsDAQozPALaHc84JsfyknsPXjJb2t0F/UR
 ApV/CPhlbFTrEeOo4+jWyEc4jUyjmko9lqIBdwdB69idjEkv2ijmNXM+hduq5TA/J13C
 daxt/pr5FTcW0Ef3JrexXCfwdxsXkX4kQZf3upL5Vi/kIe4cFi8DVtuaqDEECO/pNDJL
 Ks77lO/tWBSoONar5oPck3Ba+frLfsWyZ3JnhqFB9XKjEtpTrI8A6crT5ukPtCoHSeQx
 EX0A==
X-Gm-Message-State: AHQUAuaHINsmH4bu36+SMMvGvf/kkXUAW2VuVVnUoPXxI2y47B06Fsy9
 wFfj1Ygv/ZUyoM6k46dX8HiHeg==
X-Google-Smtp-Source: AHgI3IazHRtY/RT/wDeZ+hWjsf9AxYG8eJn5ILrK1Gs0DTZgAxISkZ90bOPieDKYv5UpyabnUNn8Og==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr7266686wml.121.1549545984743; 
 Thu, 07 Feb 2019 05:26:24 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 05:26:23 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson: g12a: fix clk_msr node
Date: Thu,  7 Feb 2019 14:26:02 +0100
Message-Id: <20190207132603.694-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207132603.694-1-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_052626_485868_CC9437E8 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The clk-msr node should be in cbus.

Fixes: eeca2cf15e05 ("arm64: dts: meson: g12a: add clk measure support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index c9d53103a58b..05ea750b8c16 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -217,11 +217,11 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
-		};
 
-		clk_msr: clock-measure@ffd18000 {
-			compatible = "amlogic,meson-g12a-clk-measure";
-			reg = <0x0 0xffd18000 0x0 0x10>;
+			clk_msr: clock-measure@18000 {
+				compatible = "amlogic,meson-g12a-clk-measure";
+				reg = <0x0 0x18000 0x0 0x10>;
+			};
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
