Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFAEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27C320821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KBhd1rUt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n0lVMIhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27C320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x61pSWuKUmeuNYs2FKbwq7TAyRR3BTlsAKGgY8ukbB8=; b=KBhd1rUth3CA42
	2Ezm0ubIZYZp0Xi4AdLCjxYCNZ7FZShZJRWlrEgwG+1+0G16H83Zi69X6qDGeMNv4KylATUE19jpB
	7kNbGq70/JouymXysBC6SMkE3NFeojzv2LjNA3k+TzNE90FlVUnNFh750OevQp/89vvAexk7McGZE
	AE6po9PW0QwBikVxUt7l69vzPo7SWP9f5bGW6vQahk2QydNlaM57rRTXGMQnSX/oJea/nu2ZdnF56
	qJIODDr74q6GcYETh0lQR9L5kEK41X8/hqc0ebJYjwHu4ZnX6QbIpJsZZwuHyjgNTr8uYDmyEvvyq
	6kP7OnV/ILecQ1vQEArw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK9m-0003P4-SI; Mon, 10 Dec 2018 11:55:26 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK8F-0000fk-K1
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:57 +0000
Received: by mail-wm1-x336.google.com with SMTP id q26so10862893wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xKc4rpirIDSNGgBaxIhfJAOtD80I9o5vCC89+wiWkHs=;
 b=n0lVMIhf/pt2IhkdEtL/kB0UPnc12c5yZJO8z1mlEQchur8xRLpaFk1VbVOvFlJQ1g
 Mj92rLsdzeV6FTj2vMCaJnKQjTuqWrx1tUfhMFiacFRjso4P91fpKg6jExzPm7lVjBc3
 APnAy8mCqdqqm1rIvJ+0Dfbuilzxi1Cq3itL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xKc4rpirIDSNGgBaxIhfJAOtD80I9o5vCC89+wiWkHs=;
 b=UngjmsUsEqPwr2jwDUiLcd8G34mgLfUP4D6xbR/QQkQvSwQ0FUiUUhUA+4iQu34Kge
 PHAD5ve6Ra/T3eWXLeUwIi4yem1wuPb4hYsG68Fcr2bR+BNO2ukapRREyNByQ7nfWNyc
 k6PeQxhvU/k/Iz60CQkb90GOl9TUHYDKUhxUoztYGU32wRUXtxCh6YBlwZoYiTEBbaJW
 wXAGGwl1pIgRKEDrlqEs5LwUUDYqHcGNDxj65yucIuLVdHV0MHTKLUjT4fqa3THhzlYy
 y/SvTHZH9f3hjeXfwGFgjPRaJ5zPRXdRJVifXvXH7yfcBQlGwy7WQokdXtCIax4CqSM3
 +MBg==
X-Gm-Message-State: AA+aEWb6xBZqzjfAHM5jxxHY3h6w3BjBS4H4C7Qt0hz09zVcy4dX1XA6
 7tvZtJsz93nLW7SzuAfk0gUnog==
X-Google-Smtp-Source: AFSGD/WnBP1Yq/JRouF0m4at1X0DT0N5cwK9FxnDzEubdisXhm7dXDnKqLaqkQ+t2zSaxIkyjtCAbA==
X-Received: by 2002:a1c:d912:: with SMTP id q18mr10093519wmg.122.1544442819830; 
 Mon, 10 Dec 2018 03:53:39 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:38 -0800 (PST)
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
Subject: [PATCH v3 6/6] arm64: dts: allwinner: a64-amarula-relic: Add OV5640
 camera node
Date: Mon, 10 Dec 2018 17:22:46 +0530
Message-Id: <20181210115246.8188-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035352_159328_7716B6F2 
X-CRM114-Status: GOOD (  14.14  )
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

Amarula A64-Relic board by default bound with OV5640 camera,
so add support for it with below pin information.

- PE13, PE12 via i2c-gpio bitbanging
- CLK_CSI_MCLK as external clock
- PE1 as external clock pin muxing
- ALDO1 as AVDD supply
- DLDO3 as DOVDD supply
- ELDO3 as DVDD supply
- PE14 gpio for reset pin
- PE15 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..ea6286ce5de3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -22,6 +22,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* CSI-SDA: PE13 */
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* CSI-SCK: PE12 */
+		i2c-gpio,delay-us = <5>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ov5640: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_mclk_pin>;
+			clocks = <&ccu CLK_CSI_MCLK>;
+			clock-names = "xclk";
+
+			AVDD-supply = <&reg_aldo1>;
+			DOVDD-supply = <&reg_dldo3>;
+			DVDD-supply = <&reg_eldo3>;
+			reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
+			powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
+
+			port {
+				ov5640_ep: endpoint {
+					remote-endpoint = <&csi_ep>;
+					bus-width = <8>;
+					hsync-active = <1>; /* Active high */
+					vsync-active = <0>; /* Active low */
+					data-active = <1>;  /* Active high */
+					pclk-sample = <1>;  /* Rising */
+				};
+			};
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
@@ -30,6 +65,24 @@
 	};
 };
 
+&csi {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
