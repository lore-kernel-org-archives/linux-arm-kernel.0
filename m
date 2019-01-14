Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64125C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3183E20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jbLVCBxE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pMzv83cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3183E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NIyg8gUJOZrQ7rFtrO42e98fiqV64EeQEilrwkXzDHM=; b=jbLVCBxEL1WIW8
	iP66j8wyuF7NYEEsPv7TkmowCleTh+iotY0HfNnqsoANxTBtzwrgJGM+WbodYkuY9s8er12QvswvI
	z5ikz8wCFSx07/ixfP27Dt2+rARfsuBGCgqpV1ntfpn9+qCJxPqGIQds1y/nbX1GBM6cZMJBp9jq/
	qyIlECQ1rA4p3Miwwt2ZrL4EfIzVebTgUHIlx4/bmjkJuE3JxxR3ARYPmqu4bJziSjoqZaRzYkKmc
	MvGEiLEhahO/WOnZ19KNO7tPbrGl5iUeFfaPDPJ5vtnb/2fyEX3sMxkiIjcikQ/IqXbsbNNcl1muy
	UrKwoJKpywJ62LqeqIYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj510-0004b1-Vk; Mon, 14 Jan 2019 16:23:07 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj50x-0004Zg-BB
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:23:04 +0000
Received: by mail-wr1-x442.google.com with SMTP id t6so23516116wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=78t8t5aJAh2lJS/DVWCOAAUfzOZLIRzFq7ne2kpHrMs=;
 b=pMzv83cLJsDs/jPNbYToLkRh+x0/jjeyVjGHqBy16uN3IpV9nNcxWRtUt6dqFCFRuP
 ve0YGVV9lqgvurpjWxDLS27kDzjOUaJIv46OZM1PxTE+SPEG2uniYmKQJa+LA8SHIeNM
 fdU5b5twgmv96VzJp60ZDEl9/lWVXanXbJpT5MAbxFQLBO1Cnr5W+wNBlPJLhUKWwhWA
 +5U1OzCZUZsP5FZI8iIPxIXeGNKvSesmlvejSXRa9jkLIZ1VNANL4lBOU0d1Tj7s1xUD
 SxYeQaAJPWWSMzhLkCL5+sYtDcBwwLjI0Nt1uccbBWgCqw/BZRlCUs5A0hzITJcPReIV
 jqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=78t8t5aJAh2lJS/DVWCOAAUfzOZLIRzFq7ne2kpHrMs=;
 b=UvKZLwEnLu2Y4SwMgz6dmpbCNyiZVn+MGcwJIiS2wmtS3YHQrVAMNJICHi5MuHbvHN
 hcvl2aImULrIUv7u+3cXSzOdpScjDoiVwfS2hT6AU/RmAeedYOPzGbk3N6jUbsgcznRz
 +GhjEFu+mzBDkNaPzgBEwFip2CexP0cdNds6+TzV6H2FjJNUBuRsjFnrq0ujaP0WWdqW
 VnAtiQaiA3k4lMlPxEdNkjvD0LmUPx1qXLuXto5xey5NIpNmqFw+wdTHBAgVrHPP28m/
 6yrAjViYPwS2J8MIILpVchNDSlJOyGEuf4tiy84XvvBZfJZi+kRaZHDFnjEw+9xUOOpj
 /HnQ==
X-Gm-Message-State: AJcUukeGlAoDgXv8Gviv0koZgM2dRfgJT8QMjWePOlkMJe2NXxXSJJu6
 yMWz4Rl7oi/G5MnEZc2OcAro3LF1R3thFg==
X-Google-Smtp-Source: ALg8bN6xPB/GWgv8moGXhtR9EB+HitQgjRHYhA2km3idSCj8U97SQrUCh+Gs3Tem1zI5Q06WOWzPwA==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr25799030wrf.206.1547482981472; 
 Mon, 14 Jan 2019 08:23:01 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id v133sm25931441wmf.19.2019.01.14.08.23.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 08:23:00 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] arm64: dts: meson-gx: Add canvas provider node to the vpu
Date: Mon, 14 Jan 2019 17:22:29 +0100
Message-Id: <20190114162229.5412-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082303_380580_5DE7392E 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allows the vpu driver to optionally use a canvas provider node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 44c5c51ff1fa..9b0ac183ee0c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -510,6 +510,7 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			amlogic,canvas = <&canvas>;
 
 			/* CVBS VDAC output port */
 			cvbs_vdac_port: port@0 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
