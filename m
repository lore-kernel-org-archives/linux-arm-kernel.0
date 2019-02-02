Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8412720857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvnJOOQ/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZXuSvBDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2DV8xeuE5tKck6XTLnnW4HiLU8KOm7AQDJHmBkqOfNw=; b=jvnJOOQ/VTXO16
	EthAotu0x+k/m19GMg8WgcMQFWTNZeoJQugMtUswDmVCgoyDhUGFNFw+G/op1aStPjmGDciJJrUdC
	EJSNzqfHHDMa0+NWswUCPRMzQJ16xvTbQ2gK9O729tTb4BRfg0f3lSPgeaa0J9r2huvOq8K7eUHhv
	CEUKi5OFj55Wxk8S0ortTNn3yPPto13ic99R3G5RYfQMfDBS5Q+s6tgWAX3gFu7/X33bi5WNpPRrW
	ctNj9uQeVcTZnTj22/nfDpZLsb/6Gan1brCqLzBT6IPdIMWPI4HB1xmOsPoAwB/g4uCKzWoVXhqfC
	v+l/8REyoUZb00Sik32g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpwtQ-00081p-9Z; Sat, 02 Feb 2019 15:07:40 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpwsv-0007UK-2B
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 15:07:11 +0000
Received: by mail-ed1-x541.google.com with SMTP id d39so7829044edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/km09EJcwL4AcPz2jLd4Z8bPwMU/0Bbc9m2RMAmmW6s=;
 b=ZXuSvBDE5uoVExt1KbhJTeU7zncJdsI96L59a5t0TrSnPY/mjNj88IPi0JMgoLsg5q
 SrZOKJP/7llyklJchStwoIAaBpsRRA0TE3YJpdhTaVCk/PMAz7U/i5imoMoe5onVBZaG
 NJRGmBLddkWaIgro5k8bVyaijP1bv1qpbnbx1BbUK55yccM1nhg+0CIKto9ZZzsdIkg+
 pAvA/QO28YcZihXRo6IRbu5l/zl6Q464uN0zSZQq1uJKuSNDWJ9Jr5c6eXztyezXEQLR
 TCFP+ISzPV1YAXassdV1Fl0V+UfAAG6hsgr0rt8HUYGGucj4vA/CaQG75Fzb6dSr4HTs
 41vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/km09EJcwL4AcPz2jLd4Z8bPwMU/0Bbc9m2RMAmmW6s=;
 b=S1aX4sWbnlpISLhYRxRSDH4A2h2PvEAXA9/yjNbN0+tUTp7vcGFKkMkZKcVVGw8w9p
 jepyngF3TBLzWamGNn5RtlyutBet/4Bm9zQSwm9FcDBd4LEyt3TJ6zZ3wIx1vmyAf3mC
 dRzxvA6jIyRzBdhGKpcJC1od3HMj9hvylFPidK7GNMg08V51EzgcMQwKpyACN0gnYacc
 9Arcf9Ahew8A5jODuf2tGQqfGqtvWWff3kDM253DyxMGfklcAU46aF5UaxkFmLcCNVBH
 RHWRY1k8VXU33O4WqYhmSfk1LAjDPyPOSwdc+M21sDfKRbZBYqOxDoybFoRvsxu18hq+
 +rcw==
X-Gm-Message-State: AHQUAuYafjZo2B+6PZKQLsHYKz2unMnaAiq7muljbAUnhin1D+Yr4rd3
 AHKnOD2+ZddsGaaHs8+WTl5NEA==
X-Google-Smtp-Source: AHgI3Iapz39/3yQZRCF+uHmfXu69Xop0ni4M2S3ZgnrOAG5XW0ZRDiVdZ0Gxs2XeXVFRNtbe8Nw78g==
X-Received: by 2002:a17:906:e0d6:: with SMTP id
 gl22mr18660163ejb.239.1549120025766; 
 Sat, 02 Feb 2019 07:07:05 -0800 (PST)
Received: from xps.fosdem.net ([2001:67c:1810:f051:b8ff:4dac:8778:256f])
 by smtp.gmail.com with ESMTPSA id d15sm2753023edv.20.2019.02.02.07.07.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 07:07:05 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: dts: imx8mq: Add on-chip OTP controller node
Date: Sat,  2 Feb 2019 15:06:37 +0000
Message-Id: <20190202150638.13672-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190202150638.13672-1-ccaione@baylibre.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_070709_113979_3A3CD9E8 
X-CRM114-Status: GOOD (  11.95  )
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

Add the node for the OTP controller. The IP is the same as on the imx7d.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c34cabe9b356..f37f17b71151 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -241,6 +241,14 @@
 				reg = <0x30340000 0x10000>;
 			};
 
+			ocotp: ocotp-ctrl@30350000 {
+				compatible = "fsl,imx8mq-ocotp", "fsl,imx7d-ocotp", "syscon";
+				reg = <0x30350000 0x10000>;
+				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			anatop: syscon@30360000 {
 				compatible = "fsl,imx8mq-anatop", "syscon";
 				reg = <0x30360000 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
