Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3289DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DB4218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNoacwJ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C2Q0VDKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DB4218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cHSwFqe2Fv1J08DKJGkelsHuHblRi4fIBjSaUOUEKoU=; b=TNoacwJ9VjC6By
	UcqY4bTZTX8SSH81nxgykcp9LUsVjiVwHW9lHJ8H8xyktzZCLZMx0LIT8IAWHuhWxjxphhOuMSL4W
	snEnaczlL3CXONcwrkx7/grh4L5euj9bgdgtY74z3Azkp8pGROUFDUXfMyavs2ylj0FmAGBA3XXi5
	n1v57ps/jJM2dKqcwOHOpShIypex0EKw4MHy3Am8QgKwxfWHj2KKKDBgKa4kUMmX2+bNlRh9NRfgV
	lF7sTbER8Z8AfxGVQIW2tpL9ymjEyxmyKFRt56y0hhPYGNvYgmr8+TbOsL5rl69iyJbOAQliuCE3K
	dPcHTb8i8/vcO8L0Fsrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlAF-0007UC-UU; Thu, 24 Jan 2019 19:59:51 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gml9s-00076D-Kp
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:59:33 +0000
Received: by mail-pf1-x442.google.com with SMTP id r136so3534191pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Ak/RzbTyrrXIVZkdGtey2LIaf9k4mP2yZqsX+ON3ZQ=;
 b=C2Q0VDKtacLIgo4Mjh++5QTJFI5flCR8BhPzFH1OJGMSW92ZiSnDvX6ObOTGi3Vh+5
 7GdaDav2EZc4+yTV3gCBsh3xebpBRzpcSM0E8wH+xdfQ8F/juUgrG29Ve/3dL2UTWiXv
 bammi2n2cGE1VQH6vo0jsMBdrZlBe0lWufylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Ak/RzbTyrrXIVZkdGtey2LIaf9k4mP2yZqsX+ON3ZQ=;
 b=B6y6JplbxgCn+dx3OqlIeanz3jjQKCmW5n9R6D4R4hgMLHYKW7IFNrGRU6EgTbtnjo
 MXA9J2RFeacs8vgmajAT2NNlfF8GEcQ80nOPEMD3dij3d/wHj37IXqfSU7AAgXZjJ4GY
 Qhf8F/YYwVDOJmv9DBuCTeP4tZLUFp8cg4tUmFd4TVLTZdO4DnkZmV1aVBPpjJtcKVMz
 l1Fu59a01pCLcyZ54i4iAIF0aQ/z0QCK3n1XIMyKlhxkUZ+o24L8oKLNrkIUcwLk33IP
 xrQGZpEJskIL/kdAGgL2KX7Ata9eMazSlsjXzSR7AzCvEB5s+U6fteV9fhLf9bsnpbUT
 s+Lg==
X-Gm-Message-State: AJcUukdttgIosrcS4XEutOweWXkhEoUzkvcAkCfw0vx2Ow80/Zy8ZRLW
 x/GDTGkimbmTnN48Bsf/a9HwcgOYEYI=
X-Google-Smtp-Source: ALg8bN70Hto641qCAhjyPHIEGxG0+WOYHri2dEXZu/4KY0n5xb4Bmf7S/rYMO8nj1Duk/+WXrZQc4w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr7244592pgd.49.1548359967683; 
 Thu, 24 Jan 2019 11:59:27 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:27 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 02/22] drm/sun4i: sun6i_mipi_dsi: Support instruction loop
 selection
Date: Fri, 25 Jan 2019 01:28:40 +0530
Message-Id: <20190124195900.22620-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115929_515127_699932CF 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a5fcee750bee..813d5523f1c7 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -403,6 +403,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 {
 	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
