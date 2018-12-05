Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:05:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BCE20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rsFFekiD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhlIFExv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BCE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qVFg/BBzyRLE1iMG7q2uc+hane7/+VWCdlgoZd4hRqg=; b=rsF
	FekiDVkNvZy4Psrbat5oCK8Z4WaJysQ1ZsCZtMpelmxsPXkM7cuyjOdMUlxSfBQjAfr1B1nYLYxFK
	5h9cbs852gkvDVT9LVraTn7NP9Zs/Cq9kuchoCwQdZspV0Naw2v+e8XYOOb3PRg7De54TSp0vrP6U
	B/D4aVRAHnNJnSNnrQ9QQWWddWGHpqxO8yJJZNOD9L+Zso58pcrUPsVKrue61gK/p0KBPdVkGJIGl
	K6wX3VTGT4FjM9j1WBsOCrnUj2+mn6L/DAPlz9/BYL69Eb3GBVoDJMnCAN9ecu4B+eK1CqoKOkugu
	Vbw0GQNsiOzpRGFzgkLjqQLGh4m9eng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV03-0007vt-3a; Wed, 05 Dec 2018 11:05:51 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUzz-0007vE-R5
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:05:49 +0000
Received: by mail-qt1-x843.google.com with SMTP id n32so21689248qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 03:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3UmcJm9E6pMQ3UJ80g1Sv1Qy1/3KnPWvROaujeX66Qo=;
 b=uhlIFExvuUmV5dECNaA6mi+04Dtdn3tEOVF9v/finuFakAC2EP6sRMqVOqgfhGkVqS
 kqfH1COKdSccQjI/kAfX+8u5K2Ic8PRBLpOQ5R7wOiy63wTsGIaTgh0u5saU9dl2pYzp
 vma4jlKj5F2hDG9I/tYzlNTbg1niVFxqQJMIvGs84APdKUxml98AHiVxX9cfjjEZtgs+
 Bn3ml0315sUKYVWvmmiJARZNSJotMSLWIOFbhyfXH2YK7lDixmsf3NTzAJCTdQaamJBN
 voW5iXzft0G47RLGMWF4uUPTxcEtCJ0rYbWUq0yNd1VQ9N0Evm69aczPymcJ/KBIMr+c
 pnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3UmcJm9E6pMQ3UJ80g1Sv1Qy1/3KnPWvROaujeX66Qo=;
 b=AkicbqlgqSL3YWKIytFqEbmY0e3e3xnu9UxHaJhkgp9a8DZclT/MFOWd3sIhfbvsX9
 eS/y7fDMj63/sxi+Z7h1IFDpwHLNZ4XfnG83hLq2WLLvehRbR5p0z7GRoMKf1KzaigWQ
 s+OVUs0NE8hbqUezc30YY36ZLoUK9SiOPLFUZv9SuS55XDVJTn9KxE5vLdO4UApxy2a3
 Yqsyjc7SdoX0Fhsu4EDe1hapVjkgjGlUaT/Hrda/TVaJGeMOqjn5hlkBzUC8jr6zpGjr
 W8lQv9FqA3WipF+kE6em0RzSRnlfj/Wf943RwY2Tedweda/PmDLb+BMC1fuuoC+HmZoP
 F3Vg==
X-Gm-Message-State: AA+aEWZQ/u+eNDVm8vD5XJrU63NX0YrKFmyoihEwJORtXhNGCMw39YFf
 OZtcNmNJ1VN8I4YilpX27PM=
X-Google-Smtp-Source: AFSGD/VXKW3MvQYnqfeidt0wARPjp5nHSc4IqoVdlS23Mn2q8Qp6PPytKbpE2EvI39lH5ZjI3Yl5Hg==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr23727898qtd.156.1544007936368; 
 Wed, 05 Dec 2018 03:05:36 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id f8sm13399052qkf.96.2018.12.05.03.05.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 03:05:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH v2] ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi
 clock
Date: Wed,  5 Dec 2018 09:05:30 -0200
Message-Id: <1544007930-16670-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030547_896219_15990E5B 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: gary.bisson@boundarydevices.com, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, troy.kisky@boundarydevices.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to bindings/regulator/fixed-regulator.txt the 'clocks' and
'clock-names' properties are not valid ones.

In order to turn on the Wifi clock the correct location for describing
the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.

Fixes: 56354959cfec ("ARM: dts: imx: add Boundary Devices Nitrogen7 board")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
Changes since v1:
- Use the correct clock name

 arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 4fb7e84..9ba9084 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -87,13 +87,17 @@
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
-		clock-names = "slow";
 		regulator-name = "reg_wlan";
 		startup-delay-us = <70000>;
 		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
 };
 
 &adc1 {
@@ -376,6 +380,7 @@
 	bus-width = <4>;
 	non-removable;
 	vmmc-supply = <&reg_wlan>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	cap-power-off-card;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
