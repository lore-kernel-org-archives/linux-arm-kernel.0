Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38178C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF02520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzE9ivIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF02520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gYtonq3FvDDnUhvzPDE/HQdhtdEJwy82szx1zma7oUs=; b=AzE9ivIu/QRWkf
	4SaxTm+BqoIOSgbl5s3DZA13CNkHLIRyJ8ulQiByG1nDaFE06mIXVG98qQ0+ylFmju7gIg8k1q0wi
	kQrw5pnGX+3gOpIAFtc+7JrkknlvqvKnkTQgbrsmlHvsOkLjELQANFPACZG7cJNUN91kP9Sv2bCOp
	03CvXDQUOxbRDGEl05LX6+lu1zcnyeOTSX+dr1aotpgQbaSB/VE49W9eTUFHMmEUpt/lTlhXg//Th
	sJYZhCgRQigMtD4VVEsDvveydLzePkry3uNoyzQorZOIvCyUiKhRGs8WoPGO4nbO0OOl/EOJO9eXm
	w8Ro2+545powrjyQZp2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqce-0003dr-40; Thu, 06 Dec 2018 10:11:08 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbc-0001FN-Mz
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:23 +0000
Received: by mail-qk1-f194.google.com with SMTP id a132so13707405qkg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=B1Ek6CSKUKobmAWbvbtfseZEVwX/TEbsIxU/ItCuEZE=;
 b=cqFiP0m3+6CY0bPE0aw5gkTAqZel36d9yK/IZCWUtb/U+Da+9OZ32oy03IefKZUYf5
 mEYXIf9akriZxg4Y0E00EpPsmGT7jjqi+RqAjMhsN8M59s16WdFfdWRrQGcF3EXqrRvt
 kYQbOf+TH07SLKdkDxz/rUHnxon1MD4c6CpU2EHiXb1EHILAH29BM6C8SAwnLdOZjdOU
 /uR+lVVRULQzrsMpnlW8VY7DiY2K4176m/reGqXwLQ7NRJ2Jg4TbFMzsvrA0bKeGui0+
 xl1L7/8J05+LpBjb0R6SQo4J/83kDSbHtXExyjZWl1jyRAi3TWk17xiHhbdKNKD++YJN
 2daQ==
X-Gm-Message-State: AA+aEWZKNSAyOqZ1D9s0+UaEO9XBv0ECU5BeB1jOoiiRzqVBCBL5olFk
 8a5DMb6vPX8wqDMV1y8tpeX2LqDX
X-Google-Smtp-Source: AFSGD/UTLydvHnKZsQ4/tc8fGloaj43fdcjDsK9TbY+EkKM8wgv6y/B2rRjlZLIFaMdRMJv9R4GkNQ==
X-Received: by 2002:ae9:ee02:: with SMTP id i2mr25155380qkg.179.1544090993242; 
 Thu, 06 Dec 2018 02:09:53 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id x127sm17458704qkx.43.2018.12.06.02.09.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:52 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:46 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/9] ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
Date: Thu,  6 Dec 2018 08:09:01 -0200
Message-Id: <20181206100905.15053-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021005_323365_290239B9 
X-CRM114-Status: GOOD (  12.83  )
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

Changes in v2: None

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
