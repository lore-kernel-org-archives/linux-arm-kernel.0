Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C4F20828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t8zOJwRL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyPASDp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bRVcaCUsinkCEksfAQVX8ecUd6iRGZ+4JG4uGcrmTyI=; b=t8zOJwRLdS+xLHSMIu8eoQdoTT
	Rm/AAjLuqpaOaHq0UJywzEj5DhQpXYQAUuFO7GVqfprIVpn3GAbzIqXQ85QZMciU6QfXn2ZePuvBb
	op6jBfS9pBPGcudhczKsdzaDQ5UkkpIkpcQhYnWizscQ+qGNdNmvkuwg7UVEr30Yv0tN2oEeOaNAX
	YO2CgahbDfYmw74d1W1YmmXAxhVobnahfPb788v3NYtZlBFvHu0quv2+R+3EarIccqOgbNbfsVeyX
	5yOu/UKLnixnW2eDz5+C/o36ChoXiOtBeu6JpN46YNLdgFsRJaa46kH5BFuQ/Fxm+U1+6vs3cJavN
	ClUtPiMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEmI-0008Rs-22; Sat, 29 Dec 2018 13:35:46 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkR-0005Px-1o; Sat, 29 Dec 2018 13:33:54 +0000
Received: by mail-ed1-x543.google.com with SMTP id y20so19444606edw.9;
 Sat, 29 Dec 2018 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1wglHSkxyGTBpW71D3d8wcxzMqGZqy9iDQdsYiDzonE=;
 b=CyPASDp6H+wFEkaEphC6t5MubhljNf1tI9HGfb+FEe+ajudGKBUipMWDr2FVNdnM2k
 kZegCxlOc1PlDILEIGd5YzcrBZm5+Cc2ix+J3xMTEqBkptzzcrv1u0qEWKmnPZE7/l1Q
 Dqj+8lS80rbzD4KPTfPDSxYDIkvG+3/SSMi0hmVtn/BIx9Ll5TyMBLXNO+wu0nlpQQtt
 vM4IPfiqTGeWxZ7wHwomYW/+LVTAzOeyjATN9lZAuWlkGSLOLUan6Fn0439Y7mkkW3gt
 lkPyj8Qn+x2lGBt5GkH8P0nMeIJCOlQ1wxw77h01KzNfaWE5ULQiJ/0E9I9Xgf+8PCYX
 vmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1wglHSkxyGTBpW71D3d8wcxzMqGZqy9iDQdsYiDzonE=;
 b=rhHYkkPuOUmbmqhIGfjbkoQW81PO1tCWX+JMD1cMppt/SjIvnrTCjLgdnmfAqF4wjK
 dgOxFGPgcUaOYFzln2dA30wDsJdEBg3TKmaqgZ3EAwjBA8dQyf+C3c67jKFMdSk4aUj2
 ntmalXhUOGrNCfPJnrblUxdweHizDXJ64ctenG7shf4XC49xsqjVK2YB2S/iK2BiMixo
 hTivD2kekn+AuF23jtk8M9PHqfMOqukLWHNWS0mhHWz4ipO/QIPbgE+1qe6ZqJKKlclQ
 aIChFr15WtOr5QZL6Eua3ZcV8Ed5MaTW3GAM5VmR1p1Ag3eYPY5NR/cWbATtElKAuYXH
 nNLg==
X-Gm-Message-State: AA+aEWaGvHgqGuBnBUePM5oXsd0hQ6EofIIU47jvctXtoATDIkzIo0GM
 sFX5KurSvSv3kQmSSr3lQTw=
X-Google-Smtp-Source: AFSGD/VnaoatO3KAsK2Iay7QYMtSvZSGSJskN89P8E+VTGmuBmweU4vlYmtyd9hhXuFucTLu/GVJJQ==
X-Received: by 2002:a17:906:6c97:: with SMTP id
 s23-v6mr21486841ejr.79.1546090421193; 
 Sat, 29 Dec 2018 05:33:41 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:40 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 7/7] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and
 hdmi nodes
Date: Sat, 29 Dec 2018 14:33:18 +0100
Message-Id: <20181229133318.18128-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053351_419379_5271487C 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch enables the vop0 and hdmi nodes
for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index b6a8a82d2..14a560598 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -91,6 +91,14 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in_vop1 {
+	status = "disabled";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -151,6 +159,10 @@
 	status = "okay";
 };
 
+&vop0 {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
