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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86467C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:59:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578C9218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O1oLKXVe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUjEfuUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578C9218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xDOYK7CXjJNDojSldHgJ3e2/eOOvpbCFiFutvr8pVpQ=; b=O1o
	LKXVeDiQBPCi+Uc901D/DQCpGu7Rsj4nr3HQHz8ylHKV60tisyKxwLOpFMMc42ZJVEbMzIftUMGBn
	hLEPjrVpjWsTn2gKu+eRfdpbQoSNeFOkPYYS3qpgTD3+VtViIsq6gosfQEXv81G4fHCkXrjHh+wRQ
	ut01cke0zAz1riio2oimW9NmuDX9o5jsWVrB9fyYylfNW9OxyI+aReFms2dWDKETnl8jQ2j5aO0fb
	R/wTbDG31ugNggnY/ddzNGDZfjlBIf0WQo/ygd7P7XvfcOh0fhm+PD/JqYseizXsuieBaD8AhrMM3
	qzU2SEQBqREwQ+lYCV8kgiv+KLFDhlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9iy-00074V-Kl; Wed, 26 Dec 2018 13:59:52 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9iv-00073b-0N
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:59:50 +0000
Received: by mail-pf1-x444.google.com with SMTP id b85so7903090pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=O2DVCEK/vJVB+NMtEOXLiEGoK+ETh9cQ5Byi9Hzg60c=;
 b=JUjEfuUJm1vVwV51/nZhtQW0UXpCdYDm3CccAOTt52ChVWbubwz/7Owl4/cmVtBHNH
 CoxAvOp/L7WGTfIu4I6HlLBE1OWJQ2SY5nrCQV8TvSpvpzoggNwChzYDdwT2sBwUmklJ
 7YLKgl00UbFrNMs7l43WW3bm0wJIDxUYBgRXQitItPtRdU2tAapUamXlcfPbkoXnAFXS
 aNLqKbXrRXiNguPqAlt+sj55CGR3CTF94GrMGr4PyC8GmXhTIa+RFkgjePsFs6ObMu6N
 zdDl4FMvNu0mMJ+b7WIXwYbnlvOCCK+vnCMPpLmTNO5biMsz+D31Z93sw7eDmg9wAvZ6
 102g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=O2DVCEK/vJVB+NMtEOXLiEGoK+ETh9cQ5Byi9Hzg60c=;
 b=VFMbT8rUHRMssuasq+yheTegcMNClOu+uesV/q5kqOknFD3SOK9GHJdEXOn2ErZveo
 BZmtThgJZ6vl3AmI4tZYQTDW6ryiTpQDwGWws5BH6bmH3i9hCrJpW/VhnsNd0+sxDHts
 RaKRuEGkOj9KWEzgCowbbx7W3myMEFaJT2H3swOBXdCIC/M85z/X3WfurwvSehnl4jSf
 IYrpQxGv8w8quwbg45F903u5seivc4Dp2FQRB2DGv5i6X9p19edlhA8vWFz0safqzAtk
 mGAEBWKqOpOuOrwLvc32GF60BuUohx+Am8uzkUvIpLkrixrAaW91kAwEkAhMI4H5o7ZH
 YkaQ==
X-Gm-Message-State: AJcUukfyUgz/en7H296gCFwpdciC/x/mY52pSYLWIv8PnkqK7wno2STe
 3zeBWUimMZgMaUGYA4Poj0jDZJRdhVM=
X-Google-Smtp-Source: ALg8bN4zOcEpOW1DkON5KL4ZWIHT47MFGAXjjtPbFaAvrTqM+woWuSSBdNw1BKDn/jpivWwKN5fVBA==
X-Received: by 2002:a63:e21:: with SMTP id d33mr19032559pgl.272.1545832778325; 
 Wed, 26 Dec 2018 05:59:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id g11sm50426381pfo.139.2018.12.26.05.59.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 05:59:37 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
 sboyd@kernel.org
Subject: [PATCH] clk: vf610: fix refcount leak in vf610_clocks_init()
Date: Wed, 26 Dec 2018 08:59:36 -0500
Message-Id: <20181226135936.6102-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_055949_047287_37315690 
X-CRM114-Status: GOOD (  11.25  )
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
 drivers/clk/imx/clk-vf610.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 6dae54325a91..a334667c450a 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -203,6 +203,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-anatop");
 	anatop_base = of_iomap(np, 0);
 	BUG_ON(!anatop_base);
+	of_node_put(np);
 
 	np = ccm_node;
 	ccm_base = of_iomap(np, 0);
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
