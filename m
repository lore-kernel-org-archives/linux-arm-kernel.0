Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C1B204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dq5toOfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2leSgjB4NNPTHlWvPgWgaSJd2hZzFwJfZe0jX61bfQ4=; b=Dq5toOfGGBI0Fo0dtOUSt1nceB
	DjNkLKp967kZgSKctbe5Gk+3mGO4FyK8OHolqOEv8vhtHavO+ybMAYk9jAUvGB3EzRWz8i5umyCb6
	Rvj2RBWReAtwIzdSt7sySzX5k3PrYHI2bx4B/jJcv/V3suhTmmD+98x39u+NT2vA/IFEbwtdch5BN
	nEOWkvRSb8dP3vMRV6VcoQkWk9gcW7GWf8J3DtPOejLOWyuvckKiH+6CYBZVFkIWqF6j0O0yUk3bl
	J7uS2jaIP02K3c6dO0+CHtY6WJzXOW57588E7U3aAxlYvURJLTKRET5eK96F4Y9j6V3HLMV6PtxHo
	ZFpf/aQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmAo-0003bT-O0; Mon, 03 Dec 2018 11:13:58 +0000
Received: from relmlor2.renesas.com ([210.160.252.172]
 helo=relmlie6.idc.renesas.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmAK-00033Z-Lu
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:13:31 +0000
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 03 Dec 2018 20:13:26 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 73562402D031;
 Mon,  3 Dec 2018 20:13:24 +0900 (JST)
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name() error
 values
Date: Mon,  3 Dec 2018 11:13:08 +0000
Message-Id: <20181203111309.3709-2-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203111309.3709-1-phil.edworthy@renesas.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_031328_823926_E850EC6C 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It's not immediately obvious from the code that failure to get a
clock provider can return either -ENOENT or -EINVAL. Therefore, add
a comment to highlight this.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clkdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..cc5df3970cd3 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -52,6 +52,12 @@ struct clk *of_clk_get(struct device_node *np, int index)
 }
 EXPORT_SYMBOL(of_clk_get);
 
+/*
+ * Beware the return values when np is valid, but no clock provider is found.
+ * If name = NULL, the function returns -ENOENT.
+ * If name != NULL, the function returns -EINVAL. This is because __of_clk_get()
+ * is called even if of_property_match_string() returns an error.
+ */
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
 					const char *name)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
