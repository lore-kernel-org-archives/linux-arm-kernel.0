Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:40:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B833206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FjI7FHjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B833206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JQoNHAgsx9EgMIBU92kNec9gMhZuKzrmevb5HAgHjGc=; b=FjI7FHjAS1LmP4
	rlLIQomRc/qiAVgeOMmz2k3KbL0XiSbDJ40bKYbkxjc7GDpK6qeYXJbjf5EO7MMit2RpcK8pV3aDx
	PPggadreff9u1chAhuOg9OlO3ehEOAspnsbo+HJwAMWXMaQKiq+raqtzM8XDyiDYxmamiicDFVpjG
	0nwyLkcCMMAHAO70M3Ij1rfJs6WFvJg8vrxCYcicBMNdCiklVdEqFwf+kL9G1aV9WFdZUwqJ/R5iL
	Mo1kay2csMRxL8SdrpLU62bbyqa3ih8kg/t+cPDufD+NxLdSDUxStJ4eXUuJY8mbEJU9g5XYg9VNS
	LC54svgyZZfL0uvOAKsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZTQ-0003eQ-OS; Sun, 02 Dec 2018 21:40:20 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZFp-0005d3-8G
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:59 +0000
Received: by mail-qt1-f195.google.com with SMTP id d18so11654012qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=oOtyVZYPYhVv1dTbriat0rjkh3usuIjl8Abih+y5lwA=;
 b=EIvye6W5CJka2m1O8M+hIkKh133tpdIAn73FBdSzJsazpzBNh0adFDpeIHw4k1Jf/+
 8FcUAD2ijPdW1qYaBUU07JFTsvbGKL0awb6kFY6Ogm2+1URNO1Gh9Cq1Q3RWUqKRNvla
 TVdsT4ltwYqe66jIkQf84ymMpJwP6jbhIxw+p20n89GYnEB1+DjVd91EZ7FjndseMcrT
 lOG+ibXJNl9smQVKq/5HD9bZ1WAevV6V541edY4uZsd8a30eVQmnWz1xiq5BXadYbiGG
 iif0zbktyGgRZGVQCfEWNFa+MalkHDrqEu39l8si/9S1R+19WH//qkHaUPW9SRThvl+G
 gvPA==
X-Gm-Message-State: AA+aEWZm3Pz1kLMMZFle6pc3lnwu5TUP638amPvyYgs7hr9c0YfrQ2Sc
 V2hquXSwKpd3K8LWq5B6Y8AWhRdZ
X-Google-Smtp-Source: AFSGD/XOPV73f+FYO/Jxt9YfndoQbo9x4BDGAQs3Sd2ABn7y+FY4lbufVCrVLC7fZkF5jDiM0tKEpQ==
X-Received: by 2002:ac8:4454:: with SMTP id m20mr12774285qtn.381.1543785965805; 
 Sun, 02 Dec 2018 13:26:05 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id o48sm7583933qtb.87.2018.12.02.13.26.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:26:05 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:25:58 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
Date: Sun,  2 Dec 2018 19:25:16 -0200
Message-Id: <20181202212520.16650-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132617_788005_784BC7B9 
X-CRM114-Status: GOOD (  12.23  )
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

Pass the "phy-reset-gpios" property in order to describe the GPIO
that performs the Ethernet PHY reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index cb30bded1e4a..35791a1adabf 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -88,6 +88,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
+	phy-reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	mdio {
@@ -290,6 +291,7 @@
 			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
 			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
 			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+			MX7D_PAD_SD3_RESET_B__GPIO6_IO11                0x1  /* Ethernet reset */
 		>;
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
