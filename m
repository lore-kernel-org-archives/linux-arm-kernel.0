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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F379D2192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Li6fUayL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSJb/fGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379D2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4rlleUh1+buJsqLyuVl/QZVkR+L3mJ8EzZBXVutOss=; b=Li6fUayLIPAXZC
	srB9qxpg9XmEb+SiyoSM6PCNG8AUSY1581z/tplFn0E6yDDaZTK/xcqxXOY5aLOXBQ9Ye11pWAWfX
	79FA197zFEG3G4jUDurogH7aqi+ygnFly58xuztW/HTll/PXK+B89ah+5voKox5PFxOrM1VBEYHcC
	iutoyQ/L0RY5EqZOqJ1eRiPDFhbyVQwObYbaIJPQtkxtcVD+7jDqRPyvS7Kg5hs3Yo6jMm+b3Gc8s
	Q5OzRl+wrjPZMyQ4GymkRgNVY/H5PgyC0bzUv5D0z/Na/d3mGuVBIRjhNACdfh1gLEK2CEcJ4qmoe
	9HpfYtwKNaAn8pt2dpuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVmN-0004Vh-Ta; Fri, 15 Feb 2019 05:11:15 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlb-0003WT-8b
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:35 +0000
Received: by mail-pf1-x444.google.com with SMTP id s22so4261548pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VB9TNv/3eEaDdEdD66J61Qypynx0CtojWljSiZZ6k2g=;
 b=bSJb/fGp6sIVhTXALxQNRJiuL1acDtqiOJtLEb1TeNQ85NB7n7F/43/iw0PZRF0XX7
 swacHZqSgzU9+s/2P42MSkqU171Haf1+3/bEpBxIR+bXzynhoztyYu7zwgUjwHC/s9tQ
 Ks1J1m2TwF5bQx/HCJJGo9MNEZF9GaBhSCsBu315z4KezrUlKs5V8qbhXaaCq+6DE1pC
 PCZovmn3bQfX28J7E4qnJsjNoId0Tv4BxJUkTGnqTjpXEwGDFRWsqyCfhrrzF9kpglDz
 meIaOwgRfQxMx0F59beqi4y47q8Eh2S+8bBuO3Qvud2kqxm1At58DYjdHGDnvFJJoZLy
 n6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VB9TNv/3eEaDdEdD66J61Qypynx0CtojWljSiZZ6k2g=;
 b=NEp6akwlZX3YtFaMtxNFDt6MgzF6N41IIf4RKlvktqcFglf0Dpd8IyQOyleW+xXroq
 OFs1juqO1OIi0hZhsOT+C4qCrkX9amiTmUfFmKQm+MUWqADdUCPTreUaIqvSd56DJeBr
 6CaRE7j8zDtv6QrXsllFr1D3ZdKb/uro6qZKdHl2cAQkwaF6wYh1Fr8x+9LWkRE0xzZ0
 1gDhpuFB71JxjZQyT0AntmKp0hBT4IAgJ3WGEeOd1xTQLj0mrnaBK0aX8JqnmfWb4W2t
 MrhS8qfkfkMISIbzeyXEPO8TFxMuIfEPqFneuLdv/ka+NaWdQvZUsJpHTCApCF21Cccf
 XbJw==
X-Gm-Message-State: AHQUAualzMa8p76Ilzv4qvJWIL6JCjBlUZvYiXXmsfjfGFgvdBkdMRm4
 n/g6TLuJidk8g1LlPi6iqLo=
X-Google-Smtp-Source: AHgI3IaxFMlSaq/+jTiqkiRrq+qH1lXXWIm1fHoRK3NhoO0UTYoDs0l6WXqnjq/8V7xCHdcFnGBmSg==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr7838148pfi.95.1550207426640; 
 Thu, 14 Feb 2019 21:10:26 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:26 -0800 (PST)
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
Subject: [PATCH v3 04/11] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Date: Thu, 14 Feb 2019 21:09:50 -0800
Message-Id: <20190215050957.20755-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211027_550669_D2F528D0 
X-CRM114-Status: GOOD (  15.25  )
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
