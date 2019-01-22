Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE2420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O/jaz1Gr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z4yHd0mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Mi+FB19zyOUaHDPmFYjjZGr20o453UD7lGnPrvCq470=; b=O/j
	az1Grh32L+HEoP68tKQD9sU6iTRpf7x6ftlis9KicSswwUQzPvKmQxkNit5iDtjF1Q0GrkEDslgNT
	vqA/XK3XnAtgW+c4+AbJRQ0w4SDKjJTszA7JO70Zl3nN1GQmrcGkn+5t6k2ignVHgiLXjPZYdwL5x
	xE1WYQZ/mZZI90FebpxYUl1wi/q3+msZaem34aOqEl4BK3wnMO2upO8bDVEUCtBBIteqCyOSAtHeM
	kudaw7ZSaopUlBU9/s91oHW4TKwqmVRAcszJu6kAI+LPUSEooo9nMHa7E1ZkMGRZNzWrEfPkUXMF3
	b06Zdwt/tEBPip++wNlm47hs5Vziu5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqlx-0003IP-MW; Tue, 22 Jan 2019 07:47:01 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqlt-0003I2-Qf
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:46:59 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so13054351wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=zWujFp1sxIXzRoLjmY4y3kr0Z+vcNH29TjUq5dOgR2s=;
 b=Z4yHd0mM1YcNoTUS7aFQGHkpQ3HGB4OsRux4/lojMTkPIkxWOvjwmxQQdv+RNE0v8M
 dV6fYN6N7L9tTxGFsKFifzYTA0ldiAW3cjkygiBwnXYoe0pFbuHKRGIC9I2coTIPc1Eg
 oBwo6SGc5kjIIiwZU+3Pm7nioA+pcto5IH9lW094Nv0LbKv1I/cLdSlLCf11WDb8iWso
 3R9aHDDK9DNLaIBO9WvIa+9oX2GBA0FiZIYH/r2a7VmXwbnZhtDLEemXFRZ+5XB3TswB
 MLmrJnvULaHhZl4kSNvBVbfk+EOgodx3iQqT2aqF6boumOob5NLWQLQm6f7RseDclA+2
 DXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zWujFp1sxIXzRoLjmY4y3kr0Z+vcNH29TjUq5dOgR2s=;
 b=UiiqtXr48lWAHFJ20/AYzKN58Zz5M2fHATYQHSVwobXLHdv1VDJO4IckAfdKqT7qee
 MFLp7D5jprMXaJYkFwPX0GDeC7GKOdMAfNSKCuS6nH0dm2rSYNM0Cx61DTl41VM/ZNRa
 u++VntqjcDIKy2uV5i0n9pM0skInwe7RaewpOOsl4JsdkcqocOdw9ZRZY+56O0MSlvv8
 1gPGlitGc1oZ69EZem0CZig3ylNHqLQ2VlrPAaT0PO5jMSrRZ5Ci+P3Ca4J+0I982Saj
 kX1x9K2QQKxwv5dL4oo/lXgPWO9Nafih4DQEawSE/a7XbPtwTb1gZdkk+XpPE/XgYEpN
 peFw==
X-Gm-Message-State: AJcUukfYcWZtCOnpvy4BAaSB2pt+HgBofsh9bjKgDLnL9q/6FjU+DKA7
 G8iTfKAJFYs9pxP++foMdOeHVQ==
X-Google-Smtp-Source: ALg8bN7vl8/Hwn7aZfLcgdvniz3RDOzhzlFxz8iiQ192towOF1h8ZKQmTB/8AhKYWIBkX2wTK8mjnw==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr2465052wmj.14.1548143215495; 
 Mon, 21 Jan 2019 23:46:55 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id p6sm123766439wrx.50.2019.01.21.23.46.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Jan 2019 23:46:54 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: mark.rutland@arm.com, maxime.ripard@bootlin.com, robh+dt@kernel.org,
 wens@csie.org
Subject: [PATCH v2] arm: sun8i-h3-nanopi-m1-plus: enable HDMI
Date: Tue, 22 Jan 2019 07:46:46 +0000
Message-Id: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_234657_919608_9C217137 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Corentin Labbe <clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- removed status=okay from hdmi_out
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 65cba1050802..4ec94d72f021 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -67,6 +67,21 @@
 		pinctrl-names = "default";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci1 {
@@ -94,6 +109,16 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
