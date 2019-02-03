Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649EFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136D221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0UXf7ow";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu5qWTIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136D221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4rlleUh1+buJsqLyuVl/QZVkR+L3mJ8EzZBXVutOss=; b=i0UXf7owcYwPdg
	KIgPX9RjogHbsXQr4dmuwih8NWvPHBA562pPtzg2qSD8IZNeDM8+D88reOPgLEqHQQqQu38SXYj/Q
	wnubpaochyiZiFFPqXGPHpt8JJ1Oj1/gXhmR+qlbTiZ3mTlowXRGH2DjpTn56bQI059B6P7UXQYCr
	jNiZTWCaEIBSE6IV8Oc1jKMVY7XouBjZYGh07gwe/ANmGcpr6OQKdKesOVeNiWmmTmSYx4Av//omK
	fgDYhY1jiKb/JjME61SoNJlYxRRwRB/c8kuuGz4ZJmx1Y5/SK7nUxiiqmhVlTNA+6c7Bql6OFbKcL
	2yax5hP9mCoTwvFglHhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMwE-0005qG-Gi; Sun, 03 Feb 2019 18:56:18 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMva-0005Ag-TS
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:44 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so5762827plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VB9TNv/3eEaDdEdD66J61Qypynx0CtojWljSiZZ6k2g=;
 b=Eu5qWTIztXX0aWh3QQbXKHTr7tg5y71U8SQ0NLenLQ+z7iJ1l8RifSee8uM3VerdZI
 vjA/BCBvrR3KO9xhYhZchIWROj7/baLzOCwCGYay4Bt1RhUWKwWuPqdZzG37Ozx/Z2/h
 3yJ407nIy3uptodEQy8mw8TPE6bOjFufB2eQEP/LIPs112tPSzSnAwEqKcldUVUEoDMy
 BC7dcRPF94HwQEhtpEPhU9fnQv+aZ+bN6FgzGi/ZoBaH4iRCbLmg4JYYD295src+SF/X
 CFEeExjh7RsXYxeS5hF1EmgWdc4wuBko8R5YTdwUkMqPxuDz90MU95u+Ju50A40ru/Vx
 6cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VB9TNv/3eEaDdEdD66J61Qypynx0CtojWljSiZZ6k2g=;
 b=gNzTbdJcdA3ferL02pyCX78Sk/9klWhNuyn+phfdc0WbDQO4Vibqzho+epcz+ysaS0
 fO4IDI/MRjF2BqcIccM0DrTtNajVAoFAugSsK8bbXgtd7vOErQ0MVk5okWT60vxvnA6d
 O8Jf+wES0RtL6DyU4dgeU+X6a2oVirvSTDwByL+8i4asyiV/rEWqekVRa3gUMshylCmr
 c/r8GadB9F4UuRa7qFQZhoLzjz2eLp2PD5gqnya8RUOocgIVrbOAmg8TLQC8jy392Shd
 rxntXSo+efpNTcid/m9RSZj0knpA6rJW6HiNEU+xfiOv7uoQxEYfm4sdooTAWCQ59n/6
 WeYw==
X-Gm-Message-State: AJcUukdrTGvsVvjK2mdhNnM0a3LkOA5EAr7iWhLkeR47YMLGv8MFgUKw
 b9kNSNMRyRA3ScArxX9ZIfQ=
X-Google-Smtp-Source: ALg8bN4B5pi20YWHFip8IIAeBuNExl2GqqBBiEdeOuy7t6zStvv+RDWqei4q/vbg58+PLx5IbJLYGw==
X-Received: by 2002:a17:902:503:: with SMTP id
 3mr49055279plf.233.1549220138259; 
 Sun, 03 Feb 2019 10:55:38 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:37 -0800 (PST)
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
Subject: [PATCH RESEND v2 04/12] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Date: Sun,  3 Feb 2019 10:54:53 -0800
Message-Id: <20190203185501.8958-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105539_358811_44B02DF0 
X-CRM114-Status: GOOD (  14.59  )
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

The ANX6345 is an ultra-low power DisplayPort/eDP transmitter designed
for portable devices.

Add a binding document for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/display/bridge/anx6345.txt       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
new file mode 100644
index 000000000000..e79a11348d11
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
@@ -0,0 +1,56 @@
+Analogix ANX6345 eDP Transmitter
+--------------------------------
+
+The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
+portable devices.
+
+Required properties:
+
+ - compatible		: "analogix,anx6345"
+ - reg			: I2C address of the device
+ - reset-gpios		: Which GPIO to use for reset
+
+Optional properties:
+
+ - dvdd12-supply	: Regulator for 1.2V digital core power.
+ - dvdd25-supply	: Regulator for 2.5V digital core power.
+ - Video ports for RGB input and eDP output using the DT bindings
+   defined in [1]
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+anx6345: anx6345@38 {
+	compatible = "analogix,anx6345";
+	reg = <0x38>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	dvdd25-supply = <&reg_dldo2>;
+	dvdd12-supply = <&reg_fldo1>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		anx6345_in: port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			anx6345_in_tcon0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_anx6345>;
+			};
+		};
+
+		anx6345_out: port@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			anx6345_out_panel: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
