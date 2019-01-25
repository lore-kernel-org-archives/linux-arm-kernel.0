Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA2C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:13:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8AA218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogs+R5s6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ggTa97CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8AA218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GxrRQGtzmqxJq4JtLCav65cIVg+z7eKkdHaNA9L7XQ8=; b=ogs+R5s6JYjqDO
	dP1W41pbe8I71BIBsXoZ3kD7fTkbGAL6GabfTFcVJO4tFd94yznJqyPc86giM4JtdaXitOVlLlJUn
	XqbM1ywp9ESaHjHdr6+STAlXFTRdQaSodpOY/CqIBHJwHIjWKESkxFZay2JldwKwRzraizMkfWXU3
	4hqZg/FoT4BVYVI8GXJeIDT4nkwotY51o+ZnATEcfYMsGkU0IFacyMa+PlkglgPhMzrDRwFeM/d28
	mWqYb3LNwObcK+JcEoDBa2MHjECmlsY3Hz/+Veqa/1P96v2QEaFVThyKAtGmzpeqxKkAGU7TIBIxU
	3007c2wTVO0gh92DPZPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0Md-0004En-Og; Fri, 25 Jan 2019 12:13:39 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0MZ-0004EI-O3
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:13:37 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so6382947wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CYBxlUpt6j52aqir7pbFD4iwDVUcezZoN1Rvp0rCsg8=;
 b=ggTa97CFIITUCiENawd6Z0ySEg8HyJWq91TB931BHV+5GPhZcKcfP/SVW3X9JJf8GJ
 WgExd+7lXDPMwVpQpUxD7OmH37t1qfgjR5u3BvpfM0illmb9u7LgI8aO8+tanNyhiFsT
 6aha7nQSY1LVhoQ5r4cqw1j6UG4Mr3ryckpAwHDwBF9hEJZGoAhbXMEhwnkpPXKmjmh7
 Nq/Vlqk8HPtOYuuyDY87tAQbreevZQ6oE8uE5MYuHLNzDPe5q9S76mY8AfY7ckr6gua4
 OWK/EuwoW9Ym91tqrZBXzyN8c60Jfn+yPLov4uLNyqlIy9MkOeZbQ/+UOONlbgIavbyp
 5IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CYBxlUpt6j52aqir7pbFD4iwDVUcezZoN1Rvp0rCsg8=;
 b=EaCeRXA+Kk8TUXJLlJiEtwWOiqvxEOLB+sP6paVid0lq3dEWTID37l/ETn88Vr0lrA
 VWBL5rsNfNkTOfEFh43aCD4tA6J4+dtRQSn14tt63yeTvctWbtn4Tm1NEk+F5y06O914
 6OjIDhi4EqBzlG0O3e3QyTdA591JQRp0FpbkTKntRYvQQDU0F0hkzhWRmQmSHN2WMHMv
 6P+ZVMJwGgNGzVtikKwxpMAMKll9hKaq6EZgG0HKO5w0dCZItrGSUJgBFuyfukI+6cy7
 Thp+zv4oiz4uBujqNsEOxVF6TCWE3ukcapamMCnYetC3EuuHMTfW72xe+vLta4U8lzWq
 yiKA==
X-Gm-Message-State: AJcUuketLPDaUAnhH5foFuHt24AefoHzyJ0Fx6Up7uQGM7VZR/6DR8m0
 p2s84MtnKNsih0DMIN6lbFQaG74XgZ8=
X-Google-Smtp-Source: ALg8bN6H5q8ZzuhLWqGYwEnonk5ZKvxoBo+2yHsLv+5C/58QKpCQf7sMID4+Nc6k0XWO0dV8RehZGw==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr6566690wml.96.1548418408853; 
 Fri, 25 Jan 2019 04:13:28 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id c15sm45488512wml.27.2019.01.25.04.13.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:13:15 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, aisheng.dong@nxp.com, abailon@baylibre.com
Subject: [PATCH] arm64: dts: imx8mq-evk: add missing MDIO / PHY nodes
Date: Fri, 25 Jan 2019 12:12:57 +0000
Message-Id: <20190125121257.7151-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_041335_836660_742D9FB2 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..02f6da92957f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -37,7 +37,19 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
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
