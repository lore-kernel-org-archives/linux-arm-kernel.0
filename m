Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD468C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:53:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF842171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aiFdSp5z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYMxfrht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF842171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5QJVIqfGdd8dbl5rak611n8XNjqHshSrmYOn2aRvy/I=; b=aiF
	dSp5zDaCoIQH+68ZylcdkAO4ztoSqOabZMhSAXZ2lRaO52CtoeFHq9Zvdi3U5LzPPWd5+HGNbIq/h
	K47Sl0IpCeYmouAjMwo22zpC8T9/WKBKsRPMC5xtogAYjnvgpNgSzBqkrjmVbwVnY7Kq8bxua//xp
	sCCAcE0rmR0YwRMvNdZPpFswGqU0KE6mGxLM8fGkZKu40mgBX1d33kVps/2/vZWOUOY7gLU3tKFGh
	PhNeKRXdqyfQHHUC3/+2WaOOaz3U+sHB5WuEHz8iZgn6jajyf1hO1kNiyELNWCZ5cQkRBxYHFBrAB
	VgMj4MgJvjz7chez1ag6hc2BikqsLHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9ca-0004f9-PJ; Wed, 26 Dec 2018 13:53:16 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9cX-0004e6-TI
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:53:15 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so7585875pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=5FXaWZsMfVjfhjeSAU5ziKDkglFowmr6zU79UoVGuz0=;
 b=KYMxfrhth6JXWBRUr61nVEdxdElVrV9/GJcC46ypIDX/w5earrx2pa5KGkN+LwkEEy
 4psO0Hrhbl2zhLTbPlUovsduSe8BndtaX5w/8qj3UYTr6DcG6ezUDiTS4bPzEAgvnuqr
 X4zR0fEXPgf+OmO8IjNr7cZ/wkqv1nEyarJWH3bzN08g1VetywlwfPAoT1qCLwORzU9A
 fMtr09Q09SdqFGF6voJ1imyJiZqyqhkSQ05j+w/EMQJMGfKcc6DxOBIFf/4aNIxa5h2B
 N3lIEGgIyChdZJa4DGMVilq4+ILzf9TOj5nZOfxRBtjp4+4HhrgGum3N+7AftURLLZRw
 baBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5FXaWZsMfVjfhjeSAU5ziKDkglFowmr6zU79UoVGuz0=;
 b=uSVG+85A+5Nf2C9b3Ti4Ny5ucxky0PyNF9xmjlcFOEn8MNlun/JE7AihGcu4x1M0G2
 bbq7g5OpsStlLC6vOAQxslWEcRo9hfOQ01ZaSoIE5JeJPygyoIQkymVZiCaB0J2hP2rE
 B06zwCGR5m5fLT3Wh/CyKlkGJ3Lime8aBZidWqPWtaJ7injoyvxLgeu/2Ld8GR7G3LvX
 CT0bfurCHAkxo3/brJVGwzLDDvsBI+7TislXf55IQEZT+D0iStrzbSwfddemL9VMFa+m
 EumJSYT1PdyEKxTRYhdvoHusLLvFfN5VgzKrGLXwxjta0pgQwllJHJH7jOXIi6wp2uDK
 alYw==
X-Gm-Message-State: AJcUukdunsDufvkjK2RobT0L1RcGLA9UAAgtNZHSrJftQElcm+k2fsuk
 SVQ7tyxDqBb/nCcXIcFM+fg=
X-Google-Smtp-Source: ALg8bN5Ou+0fMbc+6GCeji2jxLv41sAd5SmTkCV9oV0PXl3I8/BgHoiqTzdGml9gPxUkTXWaAZrRmQ==
X-Received: by 2002:a63:d604:: with SMTP id q4mr18732008pgg.175.1545832382282; 
 Wed, 26 Dec 2018 05:53:02 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b2sm51280777pgg.87.2018.12.26.05.53.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 05:53:01 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
 sboyd@kernel.org
Subject: [PATCH] clk: imx6q: fix refcount leak in imx6q_clocks_init()
Date: Wed, 26 Dec 2018 08:53:00 -0500
Message-Id: <20181226135300.5710-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_055313_973752_65B9461B 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bbe0c60f4d09..53617e0632a9 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -424,6 +424,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base = base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
 	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
