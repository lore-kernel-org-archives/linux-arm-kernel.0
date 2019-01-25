Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F65C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7192F218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gf+B1dT4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2NXTSc8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7192F218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tp8djGXRKEB6I3xmNwngCP/AP98VcSLSw7LwKv4/yu4=; b=Gf+B1dT4tYMpVs
	8wn9XG7UrEMXhzOhH8e4TJ2w1CPT1LdrH47N3Bj13cSLjGRjCvvo8b5OxLMGtviTxYykaC26KC3GK
	QArl6F97gl5Cd3phfKJ+gL7lYKEQ/mmI0+xPCzFvgUsvre3CabipCfnree51FxmDJz+GDtPa4JGdU
	BsV2Frt8gVslnQiWixHs6n4bVju4OzuP6gJkx4eOABlfhal+2hvz6zuFt7xWGK9PWGSbd0Ososz3s
	so/iiHYL514hpf0kS3nfn4VhabLNpmBMtPbI3uC7WnQXmW87WMypbYZq4kI8c5S47Z3+F/FtDHMiZ
	7gXcrxavvYFn2JAHQTMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn11t-0005FM-TM; Fri, 25 Jan 2019 12:56:17 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn11K-0004kW-K0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:55:44 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so10174599wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yLXmvvmwUlgQBFdrOdWep035AQPEqhwCx5EyShXhR7o=;
 b=2NXTSc8UvqN5OwroKjXwXEi0hUuQpY/Fui8iiXjE4jqGwyBxNYoR3bwcsaWaVNuktc
 MeRhOeRhFvPSgKsTE1GcQTyuiP7nefsqq/oo02FgL8D67mNNC/vn1GBpMxDPdqErvBuQ
 MOzDUhrEL+ynlpsR8uaMxYzr9JJ2gSd+dPMgTz2Pr63TL3F+E8XG31LEt7Qx68PODzNs
 YE3NDqRT5qkkg0qMhjDMJWVUfN9DjRplXLe1G1jxjMhmBjqaeWo9bfZNJAgE0IkvfitF
 p8Mv/BA9k7YJp3y+1HN4p3A3OVCHbc4BGkp0oCEzuGB/qY5kSjozESphY46gmwDpUxA8
 siRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yLXmvvmwUlgQBFdrOdWep035AQPEqhwCx5EyShXhR7o=;
 b=Q1rmcbrLcP98/hc2zGkLQ8VJ64zUkxRutSgq2xNSZx4o7GatYGTu2EiVnICNVY4HFI
 OaJZRYlYp3wbxAbdzkw3pi/TpsHHcvf8+mRJMrLHUeVVnPkzZ4+1DHNmMfqyfaEhQMpo
 Ru8YFjjTIcPO412L8fjbPO4aWeLeLAP9D/vOVfWbb2WQFRBNrK2gTr4Uzv3JaYugABmQ
 VD1Ee6uPWtTV84cz4YC52OmNl0M8PoYuBtmYfBmwYi83fn0b1fOFkjeQuiSOM8+2V6vM
 tvehhtcu6pUoVV+GJ8/5q4IDSHc33yrOVUqPoGm3z6fV2gdt8EQMQxFGCpzA2Zb4wvyn
 BB/g==
X-Gm-Message-State: AJcUukcjKy0j71X5fsh4VT/w4YaW1cXEcjry75ZxqeLiM/2RI4Xr0jCx
 1To59nJOTjgzWSm+Rc89sCMwpQ==
X-Google-Smtp-Source: ALg8bN7TltAMjOE8qnnTzrfotDywTXeCN+vLoJBdpeH0dQKPVrpnQJ3nittRkfCpXwWWNN9yMbe+5w==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr11901673wrm.2.1548420940811;
 Fri, 25 Jan 2019 04:55:40 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id w80sm93057860wme.38.2019.01.25.04.55.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:55:39 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
 robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, aisheng.dong@nxp.com, abailon@baylibre.com
Subject: [PATCH 3/3] arm64: dts: imx8mq-evk: Disable SmartEEE
Date: Fri, 25 Jan 2019 12:55:13 +0000
Message-Id: <20190125125513.23656-4-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125125513.23656-1-ccaione@baylibre.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_045542_655047_67C0BCA6 
X-CRM114-Status: UNSURE (   9.97  )
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

Disable SmartEEE mode (active by default) because this is known to cause
issues on certain PHYs.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---

This patch depends on https://patchwork.kernel.org/patch/10781297/

---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 02f6da92957f..f324fd1e78d0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -48,6 +48,7 @@
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			at803x,smarteee-disabled;
 		};
 	};
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
