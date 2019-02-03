Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADABC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AFC21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGg/3tu4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jztKjIpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AFC21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7W2NcxdXXRbrlhE9JW4cu5jNlMqE99VTzsFlaiR6JY=; b=CGg/3tu47xfNwK
	HKVNCgDFjzZmeIoqzTfa1VNEVMIR4sV77+TnBvvdRkL06DVxDTB/yEfZTmfsCSpAPiwHo3Wq/fZ33
	uvy+siW023HCGJDsLf6cldNY4JEAXshN+h0pXHgLTltQbJgEC+Hi4DJdHPeqeL3dXJc2bJFHsZYkC
	/O41lpr8cSPkN/WUREtxTo/iy3ICZuzM63JN8zqvLeDvbAH0j/4UJaSM9gz48aI1Ut0tzXrUCrfuB
	y15G3YLwXy0p3+DMKcUQAJY0WdUa8Mk1bUphDgYFDIv3esNO4O0STzFYmbIPpb5WW66SehkVKdfa7
	BMlDIVLD/sgYIAcibsqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMwb-0006B6-39; Sun, 03 Feb 2019 18:56:41 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvg-0005GZ-Dm
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:49 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so5277722pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GIDQrPezNyP2qOXfGWTQCLxA7yBW6Axc2AnIari46Dw=;
 b=jztKjIpv9xZ5G1YHwwlmCRFouqo4OW3+rbk4w4anpDUbtA49KfoYEviZnd6QFuNOpW
 hSP4CxcC32WrVhUo9s4rPJ/hh7FE4NJ/KNu/od6dSvwd84qGspKU0A2hcyESdLxXR3IA
 7/Twuc/ntEOScXoV8a8ajAu3tL9DblOaTE2UJ2Yrc0wQEUas6xiV9H0DRVrNg1YhjXrS
 hnR55VY6786WC7VtDBGhSOW6abqkKqeUFKpofhMg8TVEq9QLY8AUhMTUsePpCn02EQ3H
 bAMWeqh3A9jNQg2pjenACMCHjM7Z+Lv4dnJKUaA2n0y7TDj6F7AYJaAq1TDx9BfEc66n
 Y64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GIDQrPezNyP2qOXfGWTQCLxA7yBW6Axc2AnIari46Dw=;
 b=P7+kR5Lzsz29JrmKDGLQ7Ickjk0gtgOplUKfDJME0oENpHhQnvWJGMtl23lQd4qjgU
 U3QczuZtRY77AaGfPBFWQCW55FDDGHy4mZGy9k5ywhDt99Ztlu7Bcd17jSQ6dlUEmEmQ
 paVLYFVexW0qboYyt8vrFxwAx8q1bEdyccwjr8sOKHWLnMWzj3cnbHqzBlKRlFBV1Stm
 mh3GjpD05wTMbW7j+NZc22zV1IAoXzasO24oKwsRaPk1oAVLgcNns59+cu8u1rjlXmzB
 m1yW5FMfoZ9BhnDmT0n2HLQcnZBzSfgRbG4KeyMGOvjMFHLXAoIaZw3FzrScZP2F4mi9
 ZpWQ==
X-Gm-Message-State: AJcUukea6b2lsUC6WlBLx8JFDrjBOfP/3c3H/Z9RzYuxooXN50/mb+mQ
 yFowomGeyiPxbdnvVT5Scws=
X-Google-Smtp-Source: ALg8bN4WDiE/7QCVC5GvoaqhrU301eHtH3CUa7iuNSr10RFt72+XjHGUOesB5Pfuzf1w61EicVu9OA==
X-Received: by 2002:a62:4851:: with SMTP id v78mr48530146pfa.97.1549220143763; 
 Sun, 03 Feb 2019 10:55:43 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:41 -0800 (PST)
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
Subject: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP panel
Date: Sun,  3 Feb 2019 10:54:57 -0800
Message-Id: <20190203185501.8958-9-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105545_007369_2769F122 
X-CRM114-Status: GOOD (  13.35  )
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

eDP panels usually have EDID EEPROM, so there's no need to define panel
width/height or any modes/timings in dts. But this panel still may have
regulator and/or backlight.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt

diff --git a/Documentation/devicetree/bindings/display/panel/panel-edp.txt b/Documentation/devicetree/bindings/display/panel/panel-edp.txt
new file mode 100644
index 000000000000..fc7a0868048e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-edp.txt
@@ -0,0 +1,7 @@
+Generic eDP Display Panel
+
+Required properties:
+  - compatible: "panel-edp"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
