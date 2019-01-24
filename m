Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDDB218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YtaT8EbV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MBuene0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDDB218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uxmIcO2Zqvr+w9q2Cul4TFiYQ4o5+27jj++2z0/m9/c=; b=YtaT8EbVeZXfkD
	jsaoDPZWeItQd873RYNjCv7kO7mtcxu7NLYuiBmgFuZu5YSoDnL3bk3shRv+rdphjybQJAnkzBkLs
	5lKl9ELSpLN6nE0n6hqj1881CN3EBbPKYJMcOMR3MDRw7qQxEzBUL3UycYCQtCcu41P4ImTzNxfhb
	dAv/jkrN1fJwamJW1SwbeWX+Vy1P4hhP0PfQYdmauGnFFoDtUZITGNC3lGER4ELDQ2EX1Fi/OneiE
	O4C1FP0ywQd/cAhiulQKlLcbwM/aZnM3Q755EY2JDPmcp9shrFNgalSPTBXFNX8HGp0K9EQlTQsfw
	lzH1/iwiRX/z3NwZpKDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjRU-0002lp-PS; Thu, 24 Jan 2019 18:09:32 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjQd-00024x-R2
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:08:44 +0000
Received: by mail-pf1-x444.google.com with SMTP id z9so3388474pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OOQ/q0ycl2Vhbvj/n8EVpYC4IVJK5DjscGBSfNzrl+U=;
 b=MBuene0c4uUHb8+Bp3wEZ/+UgAl0anWc87gdaXyJdhvM4FS9sjReofRVil356wMbpl
 FGat6d4s59SnIDRICsqYL5q5vXvAAbftKuj0X3zBOyfzBwcwp0KQonwmKcR5o+EaF8p4
 dpv1LmS3LhFOt+SkdBFRY56ng6FSAQLripWP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OOQ/q0ycl2Vhbvj/n8EVpYC4IVJK5DjscGBSfNzrl+U=;
 b=YWhQjLvDxtMFeEXrksp1xWtqb+Me0JUc8ihtIe/TBkNUZVCXjp2t5FnEJzIEht6eYf
 4v+sXSXkEtUZ4xXYXH/S5kv/JKUKg1AN6quBvBkrO4wgAbm+UUbokz+A2di0W+ZFHguq
 KN842lRtzfDRfU43WET27/QeXqYow1YKkLcxCzlJ3cLyXy7MeRIiNU8bb7VnmDAxZUf5
 XvWn0wkaFQeSuMJoww9wG03XvuGIILCNaYMzcn/X+P52ceUtrIIFA3Tl1A2wHUTgwXrC
 fSRaj0u1YRsUBHcfyFoUiAB1ECI1QCpO6FLLQP8mrFmmty2PcBaZyFPJm97DNnFR6VXO
 UYJg==
X-Gm-Message-State: AJcUukcIIv/lqFhE5kJIW44exCd3gSb+mLZ/FtHLLxpozLdyz/l+Vtc7
 P0Q/JeV/OhngJxnaDqMCpHrQvA==
X-Google-Smtp-Source: ALg8bN7CyOInddhg3QutLK5b0/l+R6UdRyH0k8FBbS2b83cE70Ch/dT/6+aBiIyPOJ3ccOjd2f/MqA==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr7758031pfy.195.1548353319192; 
 Thu, 24 Jan 2019 10:08:39 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:08:38 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 4/5] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Thu, 24 Jan 2019 23:37:35 +0530
Message-Id: <20190124180736.28408-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124180736.28408-1-jagan@amarulasolutions.com>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100840_410656_2227E7F8 
X-CRM114-Status: GOOD (  12.15  )
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
