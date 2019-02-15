Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF732192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MF6yiXGa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Y8ABFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF732192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=I7rlD2JsQeWr5RDNu6ThPBi7ysAxpSM3eUBmGSEfZm4=; b=MF6yiXGan9gZBeugyBTXg04bgV
	pAnonGyBka1eJXT8cL6bDQtuwYBEEk1GHGBO/SbOoKFjItudSRNNYGxGPNGUILOYCOXCeX02/jlk6
	S+y0qKOGlaYoWzTkRX8AA77UOuYRs34m8NZ6ROFNxTrWBpapZiDw5QG6hzoy0FgrqCP2W8dbdRdGS
	Y95/pYwVu0V11psHYZLOEwUiELCAMEYrOXGNZ3yMm+63ldq02WqKDA39Z0MYCuuI8D3FpiW537/qU
	QX6Q8tWJ+UDsJmhvnA8YtlAKd7rw1DzFIhl3puRMmWHmcLZSx1VYfmXSUGrVQKTAnu1KSsHsBnpib
	4jUIx1Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudsm-0004gE-3E; Fri, 15 Feb 2019 13:50:24 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudsD-0002wH-Lq
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:49:51 +0000
Received: by mail-pg1-x542.google.com with SMTP id w7so4831358pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
 b=U1Y8ABFNe6DijqVmeFghi1ptQycTLD+AneOaZGTppxTLyooSw/+mP+mPaQPTgJ5jLg
 zGJBTFfultmw9FNXiUzJ7NbKw5IbHOq07XuI73OTMPZcYsmyMY4b0+SifPOpik0+VWVe
 3lp7eFdrtkAUz2tn90iufIslKWgaEMd5thLSbi0ru6lnRE7Rvnbt80bTlMFqGS5FC/yO
 bBvBw/C/ui0AcQm2amMXlBDDPimk3rHUJAGmA55oRh2OakBUbkaxOicGmYyEL7fhub7R
 A3VvbN4OL3YzjuEjlJUgT45g67RVDhi4dv2sRXKMlO+Rux62gGm0+/slngYHCePB9hWq
 K5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
 b=FD2rM61wX7MefwxgO+skO+NK8dSnohgFhdJvL+JSzHgtpgXtJQFMtgYX+c/Ce8On24
 6iGs/WFfBAeyCN7+9XTeWwpTcycaN47kVrvvlDIHhV+eKXJD9zN1OMmX2GGUTyEGZJ+R
 6jhEOtC6XV1TKs9SzVPuevcH5TCkQleqDxK2bjKiwKaW6ErSvwJFtuyMsyoNV9TArJOt
 lYcmg2oqZcpH8+HGKlRN1XVcti4Ai+gWC9xeg8Ec74/Ms4IZszkjf/l0xwmrJuPFqH6b
 J9fyhWyV6QBVwX35OuMe66398wFi1Xq9kB6WklSp9d/KU6X5+KoL3OWcCJvao2QEixrH
 an+A==
X-Gm-Message-State: AHQUAuZmAKGl0De5IwWcyhnVRnMjMJ1KtcTqCT5FaiPHaQsEQPgmY/uL
 nRtU583lmTLUaS5HN/rLstw=
X-Google-Smtp-Source: AHgI3IanpSBU/woZi/rbo/sAUBkkZZHXhkf3OiaM5s7cI2TzXZ53uDCHzdYMrtQ9WKuwbM7l6bm5cg==
X-Received: by 2002:a62:e515:: with SMTP id n21mr10020282pff.159.1550238589121; 
 Fri, 15 Feb 2019 05:49:49 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id z62sm13122129pfi.4.2019.02.15.05.49.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 05:49:48 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATVH v2 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply
 regulator
Date: Fri, 15 Feb 2019 08:49:35 -0500
Message-Id: <20190215134937.10259-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054949_749313_F5D00963 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller. For
some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..95c81250c2b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -213,8 +213,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -251,6 +251,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
