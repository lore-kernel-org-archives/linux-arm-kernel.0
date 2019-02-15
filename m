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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C14AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF67B2192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+otRq99";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3R94AnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF67B2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=st96bdagegyr5Pw6BSHCmxNY1jWLl0/xRZmroUzpjBI=; b=h+otRq99Xi4uet
	SYji3k9utZOu8F3NHvR0imj417MgMibE48ZdftdZrlMLT6zIwA9LLwL+XMSUPJk0gUAuE4Po9g28R
	dDAhvcgXE0omODnwCWgZ5MY/4/O5u9Py/I7AY3KaDHvhvGkmlVkBRMvz6B8odkUz/iac9B9Uh4a0f
	1balNT+0xNIYI4eb99IxPjEcXQ3J9wHqw3iqty7iuz4nhumVIycjETKV0jItjayNXHPU3/CTacp8z
	Hmw3soapVOMKdahiId7xqbd2BHt38yIt3RkEUjtaDpQJf4vh/B5dFLkM1aiX/Xnf5Xjf7rOiT9W8P
	rcX30DTzGX8SbIGEk/4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVmZ-0004kF-8o; Fri, 15 Feb 2019 05:11:27 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVle-0003ap-C7
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:35 +0000
Received: by mail-pf1-x444.google.com with SMTP id n74so4249818pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ASbfX9LFQbe4p6p4hWxaxI0ZnNfxEpluRfdOP7JWVL4=;
 b=Q3R94AnDdknakfNT6++yghkOx5WLLIo1pOqjbiqDNLFgh0SMlcEwHLyH/MeVg1u3fC
 FYK4Sxp7htE3vuoWMgOm56krQ3pAtT+4BlfNZbDXvd/4Y227Jo+g4w83f9MEWaQsZEkL
 144C8mtVGPT8MWWst9zDIxUu/ZmMKcWcHnIh3U+qTfTXYQxCb9vkes8TIep0Y4nivOWL
 nqjP5XnNjiBt3+qszr+gZ8hzrKPB/HYmHhvk5c2m+MOAXlW8pY1yv62LjvoPI7gxqa70
 7kakh43l5wIUDF6Ge8MfwI092yLDSADzVnvhPFZ6mRMdqii+EHP9JGfeJO9jUHKmuW1V
 gm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ASbfX9LFQbe4p6p4hWxaxI0ZnNfxEpluRfdOP7JWVL4=;
 b=RgEUudMFcqo31lopVik2cTfNlamUI95cNk4MzClyy5nUi86REdA+VqsFcXXRKe7qD3
 v7dUTeIAbzUSgqoKLu/w7KsVV4fXwpeB9yy5XQ01iJDOXLu/R+ahDKeGugKrPqRwRGmx
 GpF+6boHyMqTh+sMUvH1N4C+DZGRBIO6+/HLJdfn/9Tk66qHZxMfLJdPu8tJWY11O1Qu
 ZxI2pri9mfzx1FVnLmgy34FQcMaC1Ic5aG1yga+mElb77R8BRgl8k06fLEozARg+UqWV
 jE5YE9xH3CYiEJWek5phw5prYUAa/25BmjRDQfSHve7yTVB1jayPrOfCbyNIsQcxSxxY
 om7w==
X-Gm-Message-State: AHQUAubF1GtgyrNRXwUkWYxzTPDU8mRAvQRUoMW2PLQvFGpS0N3DrwaY
 7AC58YXi2sYaWMERti31eVI=
X-Google-Smtp-Source: AHgI3IaqcojVqBwKHomOWKx2I8mP9YGFNmxJ6ZM9J0VEVvIB2pNupLdq72amIWhlVokG1QsJsdCozg==
X-Received: by 2002:a63:5f0f:: with SMTP id t15mr3609023pgb.272.1550207429806; 
 Thu, 14 Feb 2019 21:10:29 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:29 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 07/11] arm64: allwinner: a64: add pinmux for RGB666 LCD
Date: Thu, 14 Feb 2019 21:09:53 -0800
Message-Id: <20190215050957.20755-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211030_856130_8666B8D4 
X-CRM114-Status: GOOD (  11.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner A64's TCON0 can output RGB666 LCD signal.

Add its pinmux.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 2abb335145a6..a8bbee84e7da 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -559,6 +559,15 @@
 				function = "i2c1";
 			};
 
+			lcd_rgb666_pins: lcd-rgb666 {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9",
+				       "PD10", "PD11", "PD12", "PD13",
+				       "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21";
+				function = "lcd0";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
