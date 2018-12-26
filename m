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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396B72171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rY4Q1ygJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKYqIJKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=P+wSkbEBLPk2Ie60XmN9qxPWSDMxXhd0B2RDpJaXYxI=; b=rY4
	Q1ygJpHeAXMb0uCL46xHHKOV9fDy1xH/HI+j8I2+z0pNtjX9cfcavd1diGQjKmtbjWPBv9TMomt0O
	NFUUOmFgqyWBYlF+YnvrqZGl5oD4gNeQC7xwDDzsMIu2LfIGYtalX0tf3ljDyAVdL37qsTUGMxXpj
	MXM4A4ZlcU8dqlXuL0yNyKGvguJ00HlU+w5C17LhadGswNe2wRq54Yx9DlRyXgTzuShxwU5/NYyzw
	mmfZ3V0S9dzhAN3/DKRhFOR8fA3f5K4y97GEcjlx+0iiNKRUazYUA/1Rh1cu9ujJVKqcpF7DSXtWB
	OkZ8aaQPpacOsCMh6u35H7apQ0hC1Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9ef-0006Ch-Db; Wed, 26 Dec 2018 13:55:25 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9ed-0006Bi-8i
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:55:24 +0000
Received: by mail-pg1-x541.google.com with SMTP id m1so7601799pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=5Zz16nfT58+XQAHXbGtWdJkBNWf1Jd/OYxpOKCSmJMg=;
 b=LKYqIJKyNKfkqCzs9h46JLq0ftiFFtRumRQo+2D1tJfc/HVzFFtIew5mkZI6nohLZu
 hSUpBjW9h9NnUjSd5MRLq2hdWmaIFBmBXYyeZOsdyl9vDPD9v08sgGZQIzDrc29virs8
 VlSHfZ/vGT77Sgb8wDs/z2JFAgGDUO7rVNEOm6is2A4lzrNfiBlytsjHahxSakWQ3Q/r
 j9VleG6o7u4pQcIqSaxBH/StrafRuMHslc2sDtY8uy+gqlJU8HJBu1FCPkPVelYl7iXO
 Dv7KCEsLVp+Al0QWpwjWjiUFHw71mstaYC1OToMf0LgO9QCMosFAokAoxS/Vw4fkkss4
 U1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5Zz16nfT58+XQAHXbGtWdJkBNWf1Jd/OYxpOKCSmJMg=;
 b=Ddlh3DHqlw95V47LeaGRSGUy49aV0xa820ZAb7yuBiQay+HqS/3t+CjZgxM2JaWLzx
 U4ZE8W0om2U6Wiv2ebPcLSW2ypib87lD2nkRzTPS6CY9QtQ5jwVx9lGckOpzZQZtfoRH
 2cNfBjUjua3EPVy7gR6HqFw84n6+gSe2zmg5zyXAwnwEx+gPsiGtUFIO46CU68GqJhJ1
 gkUIQsfFOf3XE0HghroF1kIA+sqvlPR7HHU17n5Okk2eG3ByhzSMDdnIBos7dUb+Mrkr
 T2vIxaDDlSg4ws5xsqTXQrUab+xsdi6Y+VGmyhAv9CWDjnDq6kXdzzPFSD/kMItu+uIA
 EZlA==
X-Gm-Message-State: AJcUukd7gKQ8CbWANIQlo8yARrP+6fgFE/IRMk3Gzr3+lqVbxcZGgb8e
 5As/QLMbpNah2yVRTM3zHxM=
X-Google-Smtp-Source: ALg8bN5n8c6I0v108i9fF1qEo5zCn37vdEl0XaI2Jj7NXM4rmn0f2RpEsUJUIfgkQv/KPtu+QoCZBQ==
X-Received: by 2002:a63:2263:: with SMTP id t35mr18970388pgm.69.1545832512792; 
 Wed, 26 Dec 2018 05:55:12 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id 125sm70514701pfx.159.2018.12.26.05.55.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 05:55:12 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
 sboyd@kernel.org
Subject: [PATCH] clk: imx6sx: fix refcount leak in imx6sx_clocks_init()
Date: Wed, 26 Dec 2018 08:55:10 -0500
Message-Id: <20181226135510.5862-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_055523_310102_CDBC31BD 
X-CRM114-Status: GOOD (  11.16  )
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
 drivers/clk/imx/clk-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 18527a335ace..91558b09bf9e 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -151,6 +151,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX6SX_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 	clks[IMX6SX_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
