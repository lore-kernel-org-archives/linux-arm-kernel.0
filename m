Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B030C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5905920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jWkUMacx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5905920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oGDc+Puj5o9mFB6W/wXrpnuorpsvYZjKcKxTBTRM0sg=; b=jWkUMacxvqosvp
	mGUAhiSkQb3XKziGqCjtEugKZHDCcbUglgWnkCk1NjtlSW4wUIds3w7Nv4CLhOor9lgaobZIMSCCh
	CkbvIqRK5TfuTsFbHj8SCikSw1n13q1AsAQdwa4c76Y+Xh+rYcaamWlX25Ag8fJMWLIlBXR6Rp0mb
	tk/i9j78EOPud6kjzf+D8svlcuCwnGOnQA26jm6VBV5PSDSKENfb6BZTo+INyN+jt9tyr9knxryNb
	fuFJvgVNw0Gj7/8pjvPZGiBvSrzr/hvG86VzylHHckc0rieN18kyNq85qgiy8s3oQCfTo3bAGk43h
	w/QypVE4CpkGcn/BiqzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqcA-00038P-0S; Thu, 06 Dec 2018 10:10:38 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbV-00015t-9S
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:15 +0000
Received: by mail-qt1-f195.google.com with SMTP id l11so25679978qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=uuAA08QKScYw3fsRf3URpZe6l85kQOqeOIxl0eNvqCM=;
 b=YIUDLL6EvsBU2CDg0VaZzZunh62N70hrkGOGR37lblMlr7Mod/KB1PukIZhztZ44MS
 Dhvpl+Ngv/6sz2vepQYEjEB49m7noo0yP2JsDZsOo+Bd6TkQdfPDBG4zRybFFVi38T0h
 5vftTXtGeLuDBSVgWAIsTeRzHpqb253XLgazeUZa4tUtpjhSvimcwm0RAnUN5XuW+9Lu
 WXxzf/dCSzGm8Lqjefg+8OwgjFN4CLv66yaTJC7viC/0hWto1DoPzheuNGcg9fQt17xw
 XEp3rA2bNQyGojy6xb5/n4K1n5FMhpL1IeOtcJ8sy82Ho8EHCpHwJ9+5A24tBdw5462Q
 tHtA==
X-Gm-Message-State: AA+aEWbNLMmLNbOz2bg1VdmOy5kwdMoONZW+HFTkPCv7ohjvKnM5ZgGX
 yki2qse7BqC2EgaRPt7zUc6KXAEc
X-Google-Smtp-Source: AFSGD/Vy3eJG31zis4TFA88ZsW3HrTY1wKYcyWZdpxYxm+oJAp8CVDO3DBGRflPsLVQV1n4qYStglA==
X-Received: by 2002:a0c:8936:: with SMTP id 51mr27184459qvp.220.1544090985833; 
 Thu, 06 Dec 2018 02:09:45 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id p31sm18136118qkh.86.2018.12.06.02.09.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:45 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:38 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/9] ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
Date: Thu,  6 Dec 2018 08:09:00 -0200
Message-Id: <20181206100905.15053-5-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_020957_795664_EC38EEAF 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Pass the USBOTG1_PWR pinctrl description in the USBOTG GPIO
controlled regulator.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 7319e2ecec5c..cb30bded1e4a 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -41,6 +41,8 @@
 	};
 
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1_pwr>;
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
