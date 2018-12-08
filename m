Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:39:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3352081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nfo7AAjb";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="OhxVa3wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3352081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mLoTjZtH9vK4IzDIMpQp95wIDqdChSnB/+1bLaHi/Qo=; b=Nfo7AAjbKtqy8TLlVb6vekIEdc
	o+J+xffBqYwT9zTiQVdCHOCmeLgDW0KKvF1zzN1bEqW/X+K+HCtuNTto+2lXRQWqGO220q272xAQF
	YcB8UY9upDtCG5lO7gDQQP/ed891RB0/YlKvObNlHTAExyOrBPHcCHDpIr0RYsZVNnH5zbYk6Gxpt
	aFWJA0WrVZVvROCMb4/8n25iu/LDPRe0mhxRMZUY74z2YZH6GPy5eI61ieMXRaZW78VWgOiouYQXA
	xSZaAwwkF+EyamRclmymjy30NQySbTYFiEWG4tSzBjc2t6VLP9LcjuBeHe8iGMQAzZc9sTBH0Y5Fa
	imCPJwYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVga1-0006e7-UA; Sat, 08 Dec 2018 17:39:53 +0000
Received: from mail1.kuutio.org ([92.222.216.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgYk-0005Mp-DZ
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:38:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id 3275A1F96B;
 Sat,  8 Dec 2018 18:38:10 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=dkim; t=1544290689; x=
 1546882690; bh=YtsaaInLaSJV+mW4ZGJfvOx1QGYgTi0mgpQkgtrzmII=; b=O
 hxVa3wUBMLWd+dVgF2jYcYoWa7rmS5/ptazA8nQty5EKySZmcY7aBOWlGq30gSG/
 6N6SNu8mJVpyqboo9itD/SnrO/4XNTOl05zwL6ewugrsJa1mDXBmcQt3NFbhiStf
 WD56XAUtZzi1pdv5Y6uUElvwJ7R23gdTxNSCDfPVZOgJeGVw1He/VoBlRbvrUPaa
 RsCfm8b2vr2hub/swDj7KAFclRHZWLjpgJm+RgSyMwIAjOpZMBAyC7X5J8WntbDe
 Wk8cVBFhdY6T1LhW1VENjxnLBI0VH13J/ag7oz7UWu8zvj9gFupJO0rj3ctpoOD0
 D2OaxqdDfY9j0ay7qvmtZQDTz2411ONMHN0ytV9LzXqDmPWtDBoDiKo21QpAOelb
 ElnJmcFPeWp73P5X8ow83kzG2AthkY2AmFTi4egyaWEECIP5Tm9uxGkQ4QwzIU9/
 2MQsDB3OGHHQyn4Z892hQZgSep2DdGys8M5v6Exr6nUtkmpwoUxR72FsI20CNm+O
 VwwnImF12RLUMSpRU49wwWEVxESwZ8J8cxqgV81mdHJsp7/MINGgw01hhDwevjso
 8w8g2O/F5t4Gs2yLtQ0XQVvPSoVUiAuabe2F4eVLt/26Tc1SMp5JBHkBJ8LVwFSB
 G+7TehFqGsfaj+gkTxitYVHM/OQvMkn0+0bOdXwE8s=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id QB1lwNE5Rws9; Sat,  8 Dec 2018 18:38:09 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id 08A921FB8E;
 Sat,  8 Dec 2018 18:38:09 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 5/9] arm64: dts: allwinner: a64: pinebook: enable power
 supplies
Date: Sat,  8 Dec 2018 19:36:14 +0200
Message-Id: <20181208173618.31395-6-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_093835_180478_6205CFD6 
X-CRM114-Status: UNSURE (   9.71  )
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
 Vasily Khoruzhick <anarsoul@gmail.com>, Oskari Lemmela <oskari@lemmela.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has ACIN connector and 10000 mAh battery.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 77fac84797e9..6a1402bf0362 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -148,6 +148,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
