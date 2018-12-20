Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EBBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A09B218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mD8IkD3i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYrKi0Sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A09B218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZdQpETiDBKvHVC6VxE2phraeBv/kh2fm4dZMYTtCPrM=; b=mD8IkD3ifgqgopwuZxyvtrpyo/
	fioUudqMcPHlRQXbyHqZY6Ii1bsPIzXxKvH4CVTDx03VWf4HOOCl74WV+09eYkxA1orCbWokBG99E
	Pl8JWUXpcp/4bWveJf9nCgU+hVhFONkBtbgNrfAweRlfbjt6KDBL/zGTfuS6WbJZFJbVT0SYY5oQr
	H1bK0lMv3s0L1sliyeRVZQ4wQ45Bl2euAWtvP7ph8emT4f+SrathYq96vwBqugsY62jGunsLBs+Rt
	8MY0tJrcnXAsMRO4d4iguIcSIHB229Uod001llwNk2P+J3lncNjMvOA5ZJ/M9uqTCTbCD/yr00byL
	Ex+sr3Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5HC-0007xP-NY; Thu, 20 Dec 2018 20:50:38 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Gt-0007Ye-NY
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:50:22 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so1408992plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fFllszrbZpSKDpUS8hDNuEI0GYealzXav3QnqlzAY5U=;
 b=BYrKi0SkVlFW3DoIuuhEaYWOdq8DPQKOxGVWEdwrmEpO0l9wr6LtDcmd1W0H4x5MyO
 sYDJ5Hpncy7Qyv2jp7b1CLuQ+wSNa4Fgr6vNPUKCkpHDeOvMUzlxzM5CotQnA+x0n9oh
 kqwdjr1/hziIqbhaVhIUm2GjxL5Yb1NwAMj9DClnu9hqi0TbXhPFcBnuweARC0/D9Lq1
 UP64Xl/gL+Oj3g1IwCsAP4uLqYcDh44lmHT6obSlaIrxsQtWLilzxWMSvWkMzzm0Pt08
 gj3nlh8ozizbazUtBCKCUseJqBeFU24ai7gmfldrQKtmARsDRIrGBMXjTxlb4LD8boKJ
 CgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fFllszrbZpSKDpUS8hDNuEI0GYealzXav3QnqlzAY5U=;
 b=WcgyqhQJ2dwGdeuBaSPiaIxtfv/t5W3EtZ2d+934tCk2wWSc/DAWcWuFPPSWfZPLFF
 +IKeG6fg82nwNTLYRaHuJ5yoIGHNg78jwaN1NiNTHoyQT8lgkNEr1Khk5tcOIJ/5rSxf
 zCyC2Hs/LY+jvq96+lXeHMFflbkCMiJ1kK1HfLZDA1NwgQMd2gcei595Yz53lDOe8Wgq
 jnCH9lNCPQqUFtgBjbFEP4IJ3TW1GWacG8wj4psTaOb8AJT3C1rLIljf8P5+7jRdVL/j
 /BUa+WmhpOxK35FCSNGx7BQ3Xw5yph5F1hTqpxi0p97cdDgOWpbcVxJ6WH8lzy7mYidK
 uDuQ==
X-Gm-Message-State: AA+aEWa/ctuQBihH6tMFAPstORwazFqET6viVxbbtoWITVf/IvZ3Cs/n
 6br40rfHTWvZL3gYTZx1qH8=
X-Google-Smtp-Source: AFSGD/UF5DARrK+L+4DIhGKqWlRwEztW5w5cvrbdAoQ+hZd6KgGl/vL5PxUwKK4nVfXLmV12/I38dg==
X-Received: by 2002:a17:902:2ec1:: with SMTP id
 r59mr25869076plb.254.1545339009164; 
 Thu, 20 Dec 2018 12:50:09 -0800 (PST)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp.
 [118.155.13.174])
 by smtp.gmail.com with ESMTPSA id r4sm50924003pgn.54.2018.12.20.12.50.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 12:50:08 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77965: Create thermal zone to
 support IPA
Date: Fri, 21 Dec 2018 05:49:41 +0900
Message-Id: <1545338982-19466-3-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
References: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_125020_473329_F6F8D998 
X-CRM114-Status: GOOD (  15.61  )
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

From: Dien Pham <dien.pham.ry@renesas.com>

Setup a thermal zone driven by SoC temperature sensor.
Create passive trip points and bind them to CPUFreq cooling
device that supports power extension.

In R-Car Gen3, IPA is supportted for only one channel
 (on H3/M3/M3N board, it is channel THS3). Reason:
  Currently, IPA controls base on only CPU temperature.
  And only one thermal channel is assembled closest
  CPU cores is selected as target of IPA.
  If other channels are used, IPA controlling is not properly.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: An Huynh <an.huynh.uj@rvc.renesas.com>
[takeshi.kihara.df: fix W=1 dtc unit_address_vs_reg warnings]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 6dc9b1f..a5bf342 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -111,6 +111,10 @@
 			power-domains = <&sysc R8A77965_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <854>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 			clocks = <&cpg CPG_CORE R8A77965_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
@@ -2236,6 +2240,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 0>;
+			sustainable-power = <2439>;
 
 			trips {
 				sensor1_crit: sensor1-crit {
@@ -2250,6 +2255,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 1>;
+			sustainable-power = <2439>;
 
 			trips {
 				sensor2_crit: sensor2-crit {
@@ -2264,14 +2270,37 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 2>;
+			sustainable-power = <2439>;
 
 			trips {
+				threshold: trip-point0 {
+					/* miliCelsius  */
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				target: trip-point1 {
+					/* miliCelsius  */
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&a57_0 0 2>;
+					contribution = <1024>;
+				};
+			};
 		};
 	};
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
