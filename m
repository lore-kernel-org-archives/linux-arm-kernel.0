Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D1AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00F821019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sgEQNLQ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/qt11LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00F821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bad0sK5gccEi9B9SxpcTBSLkFJjhMw+ogKMnr/w5yNk=; b=sgEQNLQ+BOqjHhqHF49/F/0lu4
	sfC84/R+S01HPKqfLppTOf2G/cSZiFi72JcW0KTjVnG8RHR68GyoKcoQ4Otxbp38YSXBarxhFMOdR
	ejct8oEJwl0r79p2vCD8alEc2XfyjQ8as3WmqYy1v6QGPPRvF577LY4duePm9zuCBo4/68BubmWdl
	2xBiKzGWmlywidi0kxDqJjb+AdeorqqJK4vh90wtQ7IZYkCehga4Gwy/7Ok1yBC7DZ0YY/kEI8WmE
	rF5+Bwl9KIqxAkySk0UdIGWGv7Kz4tWdilek/09pGEJCTy21bhk9DNXxahcyX6PJIwmCJEoGZlo45
	IGXD8AOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glw0P-0003pB-JW; Tue, 22 Jan 2019 13:22:17 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glw02-0003UK-0j
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:21:57 +0000
Received: by mail-pl1-x644.google.com with SMTP id a14so11465062plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=OIolF++DBLb/hz3Yaz/nran8arOkyxEnLLroytUGF80=;
 b=a/qt11LKV/+zOK/6ySzuyxvITAkl0FBYgrPDH2o8Eg/GnYgfnPn4dUbMB4m/WuwfKt
 W5/vXs8ovAyg+9wKWFfOQPzOXmKsKvkPZxnpOfxRrtzIj4TLWZEQU/yzlImfXkeDGLAW
 bKlqJPoGSHfAB7G4IVyqXOzcRhBXBD/50uvYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=OIolF++DBLb/hz3Yaz/nran8arOkyxEnLLroytUGF80=;
 b=Z2JRZi20hn7H01iPMBD3kSAAOL6GktEUupvuM0uvngFpodomzBIszP+XObW2f/Wa2u
 mVp5zvChSnbObyrbbcrh1iip/vkAxWTIds9s3vd2fq5oBHMdgnyXvpLyxqxJiIKIaY2T
 FIOu/GHpLOk9X6UZ4nqiO6KOqXHgRW6nJ3cPdJWJy27zoazg92BYu19NWfJXmoaUqsGY
 HRFvFp7DmsDiVzekJacdvJZ+g4KTZY9U6yf+4Ua1PSfUbZpmar9tjHHyxglI1Y637pGd
 zqkUfSrim8dOX1hx/Kf4JO5CpmYyVPFXkGjsL49Aox4B4CG8VDZZOSRD5afQp66a6LyA
 VQSw==
X-Gm-Message-State: AJcUukfHs9pZhMQ3+9LZVQ8mYm7F1UZggqCziyfvW4QkqtUV16u4E64B
 Zli1A3Z2g47LZ7ijZzRRmSYfoQ==
X-Google-Smtp-Source: ALg8bN7/0SWz5gYbYU9eFTAYHI9OW8/XaHf5Zko66LCEWBGbg7qvDe8YgkXXlE7R39+JwugTQmyOUw==
X-Received: by 2002:a17:902:292b:: with SMTP id
 g40mr34579416plb.82.1548163312908; 
 Tue, 22 Jan 2019 05:21:52 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.47
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 22 Jan 2019 05:21:52 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: vkoul@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 3/3] arm64: dts: sprd: Change 2 cells to provide DMA
 controller specific information
Date: Tue, 22 Jan 2019 21:20:53 +0800
Message-Id: <44135b35c8a4fb1a68bb9c57013b672dd0fab3e7.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052154_574219_C2AFE546 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: devicetree@vger.kernel.org, eric.long@unisoc.com, arnd@arndb.de,
 baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Change to use 2 cells to provide the channel id and slave id for client.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 34b6ca0..dbd61f8 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -117,7 +117,7 @@
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x20100000 0 0x4000>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 				#dma-channels = <32>;
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
@@ -273,7 +273,7 @@
 			agcp_dma: dma-controller@41580000 {
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x41580000 0 0x4000>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 				#dma-channels = <32>;
 				clock-names = "enable", "ashb_eb";
 				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
