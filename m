Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC049C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:00:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA856207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CaMjFR2x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HjAx/yy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA856207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uxmIcO2Zqvr+w9q2Cul4TFiYQ4o5+27jj++2z0/m9/c=; b=CaMjFR2xR4AbqT
	VKylXMPr1KPUOCc48Y6iVNIgqv/mMgY36ug7/VnOtQx1aT0V3MDXeacdLIUwaQN1G02l+U5AMMutI
	M7FdmUgcGOr4tN48AwhyJs5MaWjk+r1XoV1OlRuE1FgpXX8ahoHmCHSs4DPMzvrCxJUi4njFdnzqs
	GNH1hX4E5FND/CGae3M8pSHshBIg7TNmsRC5lFvO7VNX1kcIMYfunt8JhnWVKLLN38okgtbvRKX3A
	fdHUvvRlEFYCf552df34yrU6sqidmWXFtfsRalaxHhzzt8KMWL27CfAdww9Pe7lEx6+jlokKXE0QG
	m45A3ZEb8SFxy64AV2lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2mM-0006cV-C7; Mon, 28 Jan 2019 09:00:30 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2lM-0004b5-8A
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:59:49 +0000
Received: by mail-pf1-f195.google.com with SMTP id r136so7713114pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OOQ/q0ycl2Vhbvj/n8EVpYC4IVJK5DjscGBSfNzrl+U=;
 b=HjAx/yy/syL7k3kg3Cnf0ViKI+mtZJZM73x1heLz1ROjdadKjZTw4nvJBRyfZ/GMsg
 8RqBV6XpoUxMvQZkXDKugOLWUpUaAq/Y6qqVLH8dD1ULvDqJTNDkuFdzFGmljTaDBr7L
 esIrTucW7UKms99zqrPP9C4GsALhUGGoOTat4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OOQ/q0ycl2Vhbvj/n8EVpYC4IVJK5DjscGBSfNzrl+U=;
 b=nlkSGxpLomkTavrP2RcQNc6lRy500Cjln60w4nKaS1y6Vo8NU2L+JwMTQZfIA+h+lJ
 PgQ2CQnzooQPTuTAHKPDWmNtXkXIIuOktN28XP5oHVwLcw1acUHGbAeGV2XacDXJzG+6
 UrRiyw+xk/4S/sYaCZiQtVZNCSq+LqssCnEj7tqp31jwNPatGlprnp8YjrfRl3Vl2F1A
 9QG1wzDEngUbqplObABRzovKo8tYrIoeKiUCL9PVTvFrD88yld6MR2qYORPIznSpTBv6
 U42zT4bdlFNMtpDsLEkWkb9SezLHzjLjQKsk4uwdLWHLGW6WhZ/BnE1GKn+sItshyIYT
 +K3g==
X-Gm-Message-State: AJcUukdvk08CAMTBTbs5YC/NWTnLr2UE/6bHDJ5Dx4TgOf/Ai63JJnc3
 l9i2s4ytjjZJEXggzy5znONZew==
X-Google-Smtp-Source: ALg8bN5WnA8/3Gmoe64gYSZH3o3zpx1Wuy2p6tBGMQgtlL5ke5xScNqdxLBkTOUXbFArsdzOgJaWaA==
X-Received: by 2002:a65:4646:: with SMTP id k6mr18697741pgr.153.1548665967437; 
 Mon, 28 Jan 2019 00:59:27 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id o189sm60746245pfg.117.2019.01.28.00.59.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:59:26 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 4/5] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Mon, 28 Jan 2019 14:28:46 +0530
Message-Id: <20190128085847.7217-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190128085847.7217-1-jagan@amarulasolutions.com>
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_005928_426782_21236571 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62fdf850e9e5..6e5a608f56f2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -564,6 +564,11 @@
 				function = "csi";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
