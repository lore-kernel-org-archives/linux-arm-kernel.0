Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF89C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C48A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DWNIGcRV";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="GJ/rk24w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C48A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nS858YbnElHE8uf5jkH4q6LYCUEavw5IbIT8QDSMYJE=; b=DWNIGcRVc6td6y2HTD7D1iwfpg
	nhVQNRVarewTAmu9GSp2P3N1XFPYcKjgIpkh4TIWA+o8zAaZSCB84W+p4ob+C0sAfORFbKVbImeyb
	IfRXpf4PEXS/UDS8HS2+2DL2lI1HS3U3fBGZzHHo/9NpQmqGoNcvSLAkEW3TihVqGxdkGcps1ubL/
	dDU0/iVK/oVmcv7CCCRl7ru1Zp0pYkyHQM2Ii7KxyjtXMAu8nJxpuW8M/h6D9KjtjmlTLGCtEnj38
	qYJwYsDYF6UhAW1jc3ruhRejBUHNeibMdBEGhPcv+xDVfV9owBsK2imY3S7mvLac1Yww1vi85mojL
	MKPoSkiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgYb-0005N2-B6; Sat, 08 Dec 2018 17:38:25 +0000
Received: from mail1.kuutio.org ([92.222.216.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgYX-0005KD-Bp
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:38:23 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id A56342092C;
 Sat,  8 Dec 2018 18:38:09 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=dkim; t=1544290688; x=
 1546882689; bh=2Ufa8g2X6gl38LQeXSxK1nafFVhKZ/h1m5RVhJnwc00=; b=G
 J/rk24wTV3LF+sWsqF7w97R44D9BFo5crW2fQMcOzPhpgVaQqprcCeVRSycuUfoz
 MwS1unWimMKgfY2MwJvWkYPil9VENGJ3E65IBShtLoW+CuGBVzBHnU3RuwpwyfKw
 IhEGFMMeKE8jWn0Jz0fd4YJdfs8qG9Q+50TG4QT1zFAmEB5GOCUhpJHejjeqMAa9
 tiUYvduH/wse0zUAVVOSsS0n5pnxqW9ynylENX+Zfai/4tzG1jRqyy1Lu5jUK2h8
 ax8YF4MUIlxQ0XevLFKw+zEVn+BwBObVr0f8+RUJ+w349n3/ChCFQBwUa+Gol3yF
 nrlfbm3Wlrk6Uts4MamvCFjpsGAQ7H6C1boSq4l2Cr4q1foEP0c/RW8rFISvSsTF
 WAT7PJCSMdk2HOWqIwvgSN64NGQRZMPjN2dSWjv+6Lj4zhvQO5ZUS7DVVBsVmOEm
 R7IXmpmqDYmSwsslCiEk9lwWCHwnJJz8z8Cpv1S+gOLUy0psTQQVZuKuS5QfZCxX
 ffnDcxd4tTYSd5hdy9GgyDJoVIHMH78q2QnRBq4GtSncokQjEDRx841ws27BOngD
 oj/T55L9YNcsg2csYsBAbG1BDvJfynMYjnLQbqNJqAjHagTifBlb0yselWWeBSm8
 4jgI8DvTpzxgs6n8gcQsgcMMhag4aTOvoUCRv69R4Q=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id I1KkFdTi7BsM; Sat,  8 Dec 2018 18:38:08 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id 6C71F1F96B;
 Sat,  8 Dec 2018 18:38:08 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 4/9] arm64: dts: allwinner: a64: sopine-baseboard: enable
 power supplies
Date: Sat,  8 Dec 2018 19:36:13 +0200
Message-Id: <20181208173618.31395-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_093821_547841_58027BE1 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oskari Lemmela <oskari@lemmela.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
AXP803 TS pins are routed to the baseboard 3-pin battery connector.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..4695b0d407b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -80,6 +80,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
