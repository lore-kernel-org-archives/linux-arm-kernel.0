Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2956C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D8A217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PluJmqYU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="evk9MkE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D8A217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fU+BgW+nkS9EOw1IZpYvePEQqMgjVzt2N35WmN04GyE=; b=PluJmqYUZ5824J
	6XQP874oECAe3jxPlzCmSbr8cBfUfH2P+lgYyvXQ6sOgfHqbjUpY3orzIasU6IP+F6H1kjQLnB2Tj
	v3GDL1WLUm5rCcB0hdzc0fNkcXfILAMM4Z5c5jCyyWhfUMKvMCa6ph+zoQtpnwd2RZ9QirOtpJp7C
	nKs9YJfw6Eu/Wq/o8JvkN4Vt8jBXPGvf/KNyqcvZQmdgJz+lKly69B9b8wuSOAorNpurps4B+QNML
	qxDgTxzw80bkqqAXQX0waeEC8G5TzyHBAnfRhkH8sDWVHxQfpERN0EYPnKb+/tFpdNtFwpkaCnswT
	TgG7rX1VEYXYuB9l2mQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDeK-0003SD-GD; Tue, 18 Dec 2018 11:34:56 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDdG-0002EN-Oo
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:33:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so15514187wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=evk9MkE8TyA07Y2trxHkB5MkphTIMNp7fzPU4KmNVofgoTzvU3M6guf5J/r3ghOabb
 bsbrydn+HyYESB6VICMLQOXRivjDdpFwHRkLWWSuaVUZl0m5z56JzMHmow/MuxQkH17h
 ZFSuwAMoLVUvWCB1Zm0PFfMB9KbDHReDge3fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=oWQQ3NO5gesmHUnMXLgMVMHMeLZnLrFerXYL5mAKQ7L4NYUN8+c+MJ7YK+Mnzdxdcs
 smWGHPCgUeBFV8ZR5EO5ohwJzIEoG8fRJkZKgv1olMdu9Ho1HON7s90bQOU/OZmEqF5w
 9uQwd14OPEWVMxvOf4iNIVbKRIe8KExXKx0TRVpV6Yg+SgJf1DkcX+9CcTZwjpNr5TuM
 Xp7bnQ+VYLbxkvPvVfjdP8tcaEMyqdLc47/80tBi4YP4XiWtBot6arl+rD70Wis0w17b
 Y4/17FQomzV7G2j2JbD0BV+rXoVCiKcl/ySYaCDWZetCpGO3rxOzSPqIWKAUx35KK/fm
 7rkA==
X-Gm-Message-State: AA+aEWaari08NOlofZf4GeCoHYqK2kHvS1CC/0DEm7avIvyp/uPtH4rk
 ESmYNgZ6NZhIDmjSfxCOyXbgxA==
X-Google-Smtp-Source: AFSGD/Xpr+LydSmIzvpDYcxk6/tMQOBwwJZfFJoJaAHL0hsGw79+s0AA6+qZPMSEgv16qrky3X9W3w==
X-Received: by 2002:adf:f703:: with SMTP id r3mr14050740wrp.93.1545132819036; 
 Tue, 18 Dec 2018 03:33:39 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it
 (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
 by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:33:38 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v4 5/6] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Tue, 18 Dec 2018 17:03:19 +0530
Message-Id: <20181218113320.4856-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033351_496868_F436A08E 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
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
index 89a0deb3fe6a..dd5740bc3fc9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
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
