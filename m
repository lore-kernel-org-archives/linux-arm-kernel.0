Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731EB2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sPJ86kYi";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="t4pZXgu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731EB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=T6aNQ4pVqHjqNysvff3LqlqFCoFiJXAxq5lID+1AHu8=; b=sPJ86kYiaZdaxneQMXezJZ8BHQ
	JZEa/X90ToEqeSspUIufwcc2BnRYCzrhgs71DA2EQSp1YMVOs99chSOeG8S5srm2IlRPqkiZd0N9Z
	FzITZ8IjfWlqQeJk3TB4fL/uZMd4aEkcmQHyQJqo7h0Eu49bPvIYlnHTUW9iMlDnMKI6JjeGKtPys
	crXzsYVVjoH7xWmIED+ZhZoZxxctMeNnU4PI5M7b5L2f8p9ktXVOm9S1o4KZ0SMxCZstGgCtcMSVj
	G3OixusuBnqoteYEd2CigIfgBhddWjslrd4sxYP9HULfbRQHJ/eZ3ydoU0C7ewb8h8kUK1RLNl1MQ
	QTiPHpxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgZ4-0005qa-Pf; Sat, 08 Dec 2018 17:38:54 +0000
Received: from mail1.kuutio.org ([2001:41d0:401:3100::431a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgYZ-0005Jz-1m
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:38:24 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id 0B20620926;
 Sat,  8 Dec 2018 18:38:08 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=dkim; t=1544290687; x=
 1546882688; bh=j3Vl2TNmgvtTSUry15fj4Q/WOZ4rGD+1mEVBj65G2EA=; b=t
 4pZXgu8wlYWZF8/qL4FSx1TIP8Lr5sflpdLbhA28cazxnw7ImGo1oVTWoz2To+4C
 1hMT336VKavUehec3fVShv4vGDL91/EWVfye2MC/dG1PrEnYaysyYeW8jap0xLJ9
 5QpmHW19GwFM1PQA2lJcC4V55IbTdbw5V6Gf2e6BRL6V7cisXdvRHcj+XPYrMdQ0
 7CtPgn6/bFRF72fK4vEeNvVSrqcUoGsRdY7LqoZw7OTzMJfHn79PGUAstaSBpAly
 B5UE24WgxVG2/13K0kZI0RExbwZs/eEAlBR5nu8vUQCtScfIng4S+XxmKeJ6eMge
 Cjrr4LxWvKAUrTMIg5GEgZfaDFicMvHDEK1bltNE3m/7DEWcSJqUFD7nvVuAEGZf
 Ji7WsKNJKsb0kKIiszJ6HK9MrzJOmFU3fBfcfmuHigkNu+TjDzsQu86Z9cne4HfP
 9VbVnqnTKZ3MF/j/dAuaXTm0wol57/GFuzddC+ufSdlEUTjbZqJ0W3zbDfMHL+RO
 bc5qKBgYilDN7G7bhuGKuWBD+OwFHDgjVMJc4Mc6x1HG1Ape5h5Et0KVArZ2KI0k
 yxHkl5PMIapVQQ/Z+3H0kWhIsG3YHXOyVPeitT4BgSVCyT3KXN+UKgfMwM7fVVMy
 ycozXTdol+/Zx9SvTp8SzOi0aeWKLHn8dLRkYvHqng=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id qfCflTAya_b1; Sat,  8 Dec 2018 18:38:07 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id ADA6A1F988;
 Sat,  8 Dec 2018 18:38:06 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 1/9] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
Date: Sat,  8 Dec 2018 19:36:10 +0200
Message-Id: <20181208173618.31395-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_093823_268969_A6EF9FC6 
X-CRM114-Status: UNSURE (   9.24  )
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

The AXP803/AXP813 AC power supply can limit input current and voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 826e8a879121..7a1fb532abe5 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
@@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
 The AXP22X is only able to tell if an AC power supply is present and
 usable.
 
+AXP813/AXP803 are able to limit current and supply voltage
+
 Example:
 
 &axp209 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
