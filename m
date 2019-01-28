Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA4C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2933721736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hprgnpA/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KIrAinr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2933721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f8xmAz5MHufui5scWDe4dCC1WD5WnrEs22CMd2IYVlk=; b=hprgnpA/+Lz5Vt
	oPsoCk0jMQenGALEDGeB7D/ZSaj3PJqBQ4+Kvfe2JQFI4tnS/EANACzKYWRLZek3y7lW9+jGRcMey
	840YPRfKStu8uO/3giJFob9qd7hr81CssOy8aORkwan7ANazN6AN/5vgYLLEdLc+CdK5iwGJquntq
	9uMuHkmKWewHEKLcWour9AzLI+wESLRb79nHxrrGccLES4G4j3WwfAGPtCyHDozm/9IJ9v1/Fevvy
	S/xzll/Wq/7cg5QHyigS0I2J6pyU8aBTjSW/luw5JO5HEEHXZZuu2sh/aX7XxmA/zsWXjOh6FKVkQ
	ozqE4Vq6PHIRp8zFehGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3ap-0000TJ-OW; Mon, 28 Jan 2019 09:52:39 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3aY-0000CU-Ne
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:52:24 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so17254491wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KtM62Ad84C4ODh72Krb0FUMdDNSIAS/usrBDZqYXoSY=;
 b=KIrAinr0qJtIJpI60MufWjCO8qjZXn2uW9YyqMJy7+9hbumW1+FiBQ7A5hdShEL+Gv
 rWWelW18g+ZFyUKrlMDKSIu093lDLgxRux1fm5mN/Vp7VbLz2FtsMsWXQ7R5m7E8PmkP
 d93vw+uuiCtTQaV7Z1Jt4EzkFFD9LIeAJSQR5CvKTkgJerGLsLr8OIFZw+RcPOgR6NBD
 bhjqIX9H2wSDWr8ujyR+JQfvIBO0StQuCgjJ6GHjlqW2Y8jSYztszt0pbvqr55jCCpD4
 qSms/fm1D32j5Z+you4/F1aoQkxC5vrU1q4fIBgyR8G9+dBUnkQN9fYsqvfdgQHQbX1N
 mu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KtM62Ad84C4ODh72Krb0FUMdDNSIAS/usrBDZqYXoSY=;
 b=H/gNLPRtFx1dTKVBjVPnHXirfMxTb1k/4eyS46Fj4N0YtvbZmD0aJalkgW8n4U5lj+
 +rxTO+dUpu6jtks5+Qngr+9uaHn4HXWqYNucmDKxNy/Xy+FaJe8bZ4bcfvAB6IRSpnGW
 Bo7kHVu32kltKgYnFzMloPSeRNL8CZJxqppvO85hqMIqHH7WpRLSQl9RJLG+CK4w55kb
 oOC3zh+l4MG5L5jslIK54mqLTnUfoxzQFbK2d8GfXgp07b6ewTxrcdj3PEoWwSSuuqxm
 t3G4H/5HBiQUBWBHls2/WCtYOFbDp7NR7rxTNBh5TL47OJwQky+Fj92gaF+fq/GF6uNh
 fjtQ==
X-Gm-Message-State: AJcUukf2am+Z289OpqxZOjfUuR2HuYTHCQMG9ZvjyCS6UUk6qZPljSVm
 K4N+j8KyV0eXB889bY0LtwbV7Q==
X-Google-Smtp-Source: ALg8bN6MuBBH4b3wLTXhUt+RiTBjtHi1mpw3tOXEih3EAm9noUxIeTkcg9WTgR4PE6M51/fLTtzw1w==
X-Received: by 2002:adf:82a4:: with SMTP id 33mr19799883wrc.252.1548669141306; 
 Mon, 28 Jan 2019 01:52:21 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id y34sm302696099wrd.68.2019.01.28.01.52.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 01:52:20 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: imx8mq-evk: add missing MDIO / PHY nodes
Date: Mon, 28 Jan 2019 09:52:11 +0000
Message-Id: <20190128095212.14681-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128095212.14681-1-ccaione@baylibre.com>
References: <20190128095212.14681-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_015222_764743_CBE31536 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Populate the fec1 node with the missing MDIO and PHY entries.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..2641f777d0bb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -37,7 +37,18 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
 	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
 };
 
 &i2c1 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
