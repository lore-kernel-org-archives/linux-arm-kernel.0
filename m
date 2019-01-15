Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115C5C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:03:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC1220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WKlbMkE4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKCJjQT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC1220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qzPJiMBdDimtmNpJQ5IyIir62fjT8n0OxEFA8m6OM6k=; b=WKl
	bMkE4YWK7N5IlW02IKhBrv7oLfzXbtL+W4t7d9RBLuJMS3Wo35hFymIpmckDvItg5Fh1Dwguw0uQr
	kLqTj/tFQaFXxnMaS4gzDEtxRjQzuzKAOa3sNKUVpKzDzkVQI5p/26SPArWbLOUGNsTUHjIvA68AS
	gybQBBqESUfQfww6qmn7xmkn5UvU5Vmr2INZtLu2pRhAAyb2WT8vwBGQ/+3bYD7jx72hbmiiP9C+A
	p4/oMiYzn6WRxvRnt9OUNsO64dZ/DYJuepzJrw8f925ASFi9A7SLWIXzFPWpVBIR3jzWt7VyOYZnm
	CgmTVIi8WdbS2biuMZoH8QGtxWrmlYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNR7-0003b1-CQ; Tue, 15 Jan 2019 12:03:17 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNR4-0003aW-88
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:03:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so1205969plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 04:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=vOR3MkD+36PX7kfHg0GNPwmhMeDJF2JG8bnig2yC5Os=;
 b=PKCJjQT0yDr8pQJG4f2NMe0pbd3HgaSkZN00LGzA3hA3H4IHm7lVKXd2IV5kGgY4at
 j1/bEscM5Rr83Yfi6GDOw3LEfQuKWQmKI23+RI4jL3aBfbOp3dd8wWVtVSAXfiWfJr1r
 xbS/wknELDnd8mt5eTuUmbpHhC5eFgoH3dhxdd82ZUnXBdolrtaAMERhOdbF0lPobGsr
 VMk1Suwuf0CLAtmpwSYrwTRDg3W6OeOyRKXnQasdjoZQ8nAIv5+hfoUXYScwfvEEuFp4
 VEgPJwlk73pIjdDwLx0pGiWDtIXGy6QmuP8QH2ZptZBzFZ85S5h49qK1yG2BGfRiPdDT
 aRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vOR3MkD+36PX7kfHg0GNPwmhMeDJF2JG8bnig2yC5Os=;
 b=FF1B/fapoXqvu/xP+/dkp/Vd3fo6MNr4QixZuyFQ/sEPCwKcjuUapineCEH/y6+uq0
 XjbKWKvELQA8TNXoeO9DbmA60jKdfT/dZ+osUjwIniHYT47e4MaUflTtrWbwqb9torJn
 2Wd8ahivY5K3D/1dTrusASmf+yMdD9gXBk/N5nMft7Qqc4dGeR0VXO7uSj3Bo4R8FlFB
 IwvIseXoJ199y+SCW4SYJ7iG2HR20ZoyojMs96tjbB4jwJrmUzRHFlKOe3IA84U2ORoi
 l3sIeAkatIre92+j/FrCfui27/IOlvjcGilgVNCzDU5ibFqEL75ta82E1BpKIxmxGO9b
 fuHw==
X-Gm-Message-State: AJcUukeZDeukJSvLWK3P28B5LMnKiWzG4sDh8gUxjyaXicZqoyWpaC1v
 60D4i8rDfDL1w5se9yPB/Ak=
X-Google-Smtp-Source: ALg8bN6fSV2RULObECD6zdb5DI53pDQnAybzrU/jreictBziXWcJBI581/ziFxOUeKITGeDBNSAR7Q==
X-Received: by 2002:a17:902:8484:: with SMTP id
 c4mr3674270plo.59.1547553793254; 
 Tue, 15 Jan 2019 04:03:13 -0800 (PST)
Received: from localhost.localdomain
 (p7732116-ipngn36501marunouchi.tokyo.ocn.ne.jp. [114.158.79.116])
 by smtp.gmail.com with ESMTPSA id h185sm4109903pfg.143.2019.01.15.04.03.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 15 Jan 2019 04:03:12 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add OPPs table for cpu
 devices
Date: Tue, 15 Jan 2019 21:02:42 +0900
Message-Id: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_040314_320131_D3E542BC 
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch define OOP tables for all CPUs.
This allows CPUFreq to function.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 84bbe70..936714e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -55,6 +55,27 @@
 		clock-frequency = <0>;
 	};
 
+	cluster1_opp: opp_table10 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -66,6 +87,8 @@
 			power-domains = <&sysc R8A77990_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_1: cpu@1 {
@@ -75,6 +98,8 @@
 			power-domains = <&sysc R8A77990_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		L2_CA53: cache-controller-0 {
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
