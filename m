Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22395C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86C220859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPYR6WL6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ag2NYCPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86C220859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o6X/wuCeF8oudX1Ro0qbVl//EJaYtj+wTyJjpAxqpmE=; b=lPYR6WL6zrWtSr
	p8V4DDiYlbW1lIhQ8xFjSiPHfQs1rb7AgJ3S9DT1rEU9bf5/H3qoNnzYGURV2D/8bhXF6dYoSoA6V
	Oz9MEugdPXCwdyG9JZ6kTO4kdzpPQ5UxZcg/Bh9EhTQk58hKcq9B+OxU6tYRFlIjcdu5zr2Dp6Oz3
	fKOWRu/2XvXlybM8TJjwm6qw6NUInEeAAsLWzF3T4zuy13vFouXa2JSsnqG+N4pGsRbBhTKGuiwdr
	IXb7etFf6dZ5uvB4cDjXcYlMxEW7CqqebDSOSkTJQIoOfK1paGDDg6BT7smKVBkrOZFPjNJXBRKpC
	AfpixEywoq1EDxH7WiPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRbF-0000WT-3w; Mon, 07 Jan 2019 09:53:37 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRay-0000Es-Pa
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:53:22 +0000
Received: by mail-ed1-x541.google.com with SMTP id f9so233817eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 01:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FNlqm1X3Atjb25AV1tWHXoXpMEFSSSDH/PGAPmX/AtU=;
 b=Ag2NYCPIpVkZH2b+oJg0P28I5ij8lt4XNPUPnEO/83l2dqPs5NM4yCtzgYM99YJZkL
 RQ4S5KrfjUQIVr6VYqZ9ukssDf8laDqARiKxDJnU2TvwlwoxnIttqzL/9ci81lmexa3h
 WJJxBMIiz56vx3QAdrtfhJqehVBYzSgDx/jzBgghguKfYqEfufG7ECrNvQYXoDE+0obY
 EZECO77DEtxipxj7Kk9dztUEXRvR1asRsC7vpgifeVC7J1w07hqhdJ/rqzPkWwdF+xyC
 wdgvEw9aq1WxoxymZIzWTVlVI5uI9nSSiDX4xnJEe/B85yL1pGBPbQgTHHOaJf+WQ7rd
 QFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FNlqm1X3Atjb25AV1tWHXoXpMEFSSSDH/PGAPmX/AtU=;
 b=Xv8dfa5xkmi+6OIgbxBXEjlO6whM40058+1K5XDHO89wsz2wBZPo3Kgls+bvSDAyfS
 BC7C1TfZ/yljk562cLzKUa87WeF/p//1zkHOqULqaALt7798BtcWvd2N18dXOtT1HBy2
 oa302p+M7miaFadf+R+ZNHHM6Z1UyvX4DmEbaDNmfvlLivnOi61tBETmDOTXf8T2hVo/
 tedw8yYC6YhRrjj44p3ceCX2YznXp9iEBCLn0farp0rkHzG1Lh6mJAeYVKwU2IQUz6Ma
 6cSNOuGow6yFvE+xLADDnrVsowlEmH4BqNNPP73ddAMPf3q7NU1XtgLPaCplY6DnHHYY
 /dKQ==
X-Gm-Message-State: AA+aEWb/IHTeTqqSR1kk4ZvQNhumWNIPkV2NpPu/17ylulEprkA/3lE1
 MTgAPGx0ebtP9k5fI8t4jlBFOA==
X-Google-Smtp-Source: AFSGD/VB9Kh1/gVWE4gr/W1wMTPUn9+Mkxk4vTMo7msLAcnrwKTjwXOz2tN9CVZUKTeNW637/t4Dlg==
X-Received: by 2002:a17:906:4c94:: with SMTP id
 q20-v6mr46459042eju.26.1546854798987; 
 Mon, 07 Jan 2019 01:53:18 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 01:53:18 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
Date: Mon,  7 Jan 2019 10:53:06 +0100
Message-Id: <20190107095307.15233-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107095307.15233-1-mjourdan@baylibre.com>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_015320_829273_791444E6 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Rob Herring <robh@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
new file mode 100644
index 000000000000..aaa6c24c8e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer", "simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	simplefb_hdmi: framebuffer-hdmi {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
