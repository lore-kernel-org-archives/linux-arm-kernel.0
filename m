Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8548C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BF22147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h8am5ppA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U45XSPt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BF22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JAN4XVCHKz7vxH0/QgEjSCtlcV/D3eofF8B8p8EY118=; b=h8am5ppA/+kFZn
	TEdgu4cfBhq4psuiK20ysXMNvoA1XpG7W6p5pR0M258wWng1ICLtnLLkW52QqKYhCYw2WiXyj6xOG
	X/0O7UlaklvRuJ+p2+IXyoaGBURvkRqMumAnPmWcxtimdvin/oq487yF4r3p384itJNdAwgej4Dua
	0YYpNAACmQSTp7+Ddkn0GYAJoU3g++SAeAVmcovPnCfwSL+ozIjQcLV/AOqRaTC4ePBW47Ebbjb56
	PueUKpjQ/MTQz2yIeVMB2UGIm0yZ445fPKTFayaoEp1mu7+iFEG+M2RFdfDdokSbWpE8J1VtuelxB
	Bc5TBn6VbF3MOmKPOQNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqasv-0004KB-8Y; Mon, 04 Feb 2019 09:49:49 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqasn-0004CJ-1g
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:49:43 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so13613517wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1aJKpDy3gSru5/yeZkdF8qEEYyeLbGINpZQT5a5qGfg=;
 b=U45XSPt3vXXADrNKM1Cn4aYrHY1JoG/c8vqzxpbzdEswLo9kIU7WvMm52WehCXJ6MP
 JPxmPAm1z7W3XWiB4eJ0K/NgLgdBR6oK72IyU4ra9F1t7mIwLWP0xRCPn/CLUTjwhEm5
 yLf5yVNmDG+E/lOcDLtyBIjGtOorCk6o/bKIitmlg6tDJlaVSG0/XwII/rBWFzOiUsYt
 AGsZcZ5iJ6KY9KK5139AN76yyYM41z0g9ZA+HLoHbIfyaTPNRpslF2E7/oSbJ33kUnRk
 Vw8TMT4KrQTkcT1H/cinaEsAYzh37d3xrBREP/19Bz7rOk8EaQ1FXfHEicLn6BEuNMaW
 LY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1aJKpDy3gSru5/yeZkdF8qEEYyeLbGINpZQT5a5qGfg=;
 b=CKJnfwzet+x4+0M8ESxcsJVVFhJV7/IQXPqRGcumJPVDEWRkjuON9x+XJnY773qcXm
 lNxgan6k0jX4K+QmRSAAGa+R+c3LjQRavzVD431o8FRxkNzKTqIg0gt+8SplkrwDJM0o
 TptK9W++rwx++08+uyj+XQIPnOcsaw7NLzKWZhQFoqotdHsdfPhgsZzUC98zLBcLwM2c
 VtcvqXnpug8T/PLaFxVSsZzMktd6Qo8NAawrx9yNB0e5AWURMfVshTFOzxmtmbtaKst6
 tb6NUGsx0NKG30CbPBprEnn5syT1yCwAPyEJ8WqUJPORLqn/NBomfMwRuIYPOlSgknmd
 zVFQ==
X-Gm-Message-State: AJcUukdJoEjAGSmzjicTkGMfq/CZa91cG1UZrbzMPVcRX3fTNJnxP0bP
 yq77ObvHwiY/fy+PjmH+8u/CcQ==
X-Google-Smtp-Source: ALg8bN63COmWcluxOx4nbtfWy7lq6CO1QBOGik3CaPZ36RwQvhhuGEGhIfXSjdfZSa+GA7ZgZQf7jg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr49558677wro.32.1549273779348; 
 Mon, 04 Feb 2019 01:49:39 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id y20sm10248655wra.51.2019.02.04.01.49.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 01:49:38 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe failed
Date: Mon,  4 Feb 2019 10:49:37 +0100
Message-Id: <20190204094937.22763-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_014941_404752_498693F7 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When probe fails, a platforn_device is still associated to the node,
but dev_get_drvdata() returns NULL.

Handle this case by returning a consistent error.

Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

This fix depends on "soc: amlogic: add missing of_node_put()" at [1]

[1] https://patchwork.kernel.org/patch/10794545/

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index 87a6c6e23591..151aa84bc593 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 {
 	struct device_node *canvas_node;
 	struct platform_device *canvas_pdev;
+	struct meson_canvas *canvas;
 
 	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
 	if (!canvas_node)
@@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 	}
 
 	of_node_put(canvas_node);
-	return dev_get_drvdata(&canvas_pdev->dev);
+
+	/*
+	 * If priv is NULL, it's probably because the canvas hasn't
+	 * properly initialized. Bait out with -EINVAL because, in the
+	 * current state, this driver probe cannot return -EPROBE_DEFER
+	 */
+	canvas = dev_get_drvdata(&canvas_pdev->dev);
+	if (!canvas)
+		return ERR_PTR(-EINVAL);
+
+	return canvas;
 }
 EXPORT_SYMBOL_GPL(meson_canvas_get);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
