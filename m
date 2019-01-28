Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50163C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBA42148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDUEram+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C1GUr4pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBA42148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fhjUFOvnKf4lWWv485NCMEwQU4EGEMpmVfio5o7gAng=; b=BDUEram+dQBJEg
	OkK0JF4BMQz5n77etOIlEQnstRVWMW0g74FwFyx9DHkjKlZgmoKwtDjtkbsZ83yR+cNFiLV11+c2N
	Yzc7+fgekePohV3BwyJyEocvNW2r7Zb57CWOYG1rcug94ZFari7cErc4KnZ52b0JYaF56YJmHFKOu
	9fMU/hGYnDUgW7wk2u/ZnPp1J89gBZfNP1nFmspXOGDU0h1g59Hneg2xP/PVWzHbsuz1VgqGZKwjn
	UAREOhXk76bU3ZZubi8m4W59Ywc/WxZ0sCmiAsIjN9UWcK3Z2pUc5DN5kBSHgg3Z6sJAEI5DiAe9x
	HVqrDUTSSzjZcDgwiAag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBIc-0006BC-5Z; Mon, 28 Jan 2019 18:06:22 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH7-0003gb-A8
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:04:56 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so19142089wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r+WHTSkzlCo1wnAPo/2Tpux+aNiN2OcVk0MvXqGi20w=;
 b=C1GUr4pieutpMKwI39/1w6pXhducYBNjduMWnqHc/+8ykx99zy2bSZ83672NJsrZ3S
 OlynYzQNFkiHHftuCE7WoeyJGnadG2hxM9P38PpPEOcdIGf+zxpJNXFhzNpHe7OKsuTG
 H/n5tJ52pvXmHf4zbcTyjbiG55/y6AC5Jnm1u4bSCJcdtUkvC5NrGwK2OxEEfP55DBRf
 93Ma9F4YVhwKSlh/m8SJBtWf1CYtpgnHUNkrFxNaiwgy9Di+hIH/GbJSJGsno1lh7YuZ
 0TDzN0g5J4BJ284OKXhY40SZK3qLtrV1aXRpivNSRK5JOC8//d7fzRwb2BWxXkw1+t6g
 +csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r+WHTSkzlCo1wnAPo/2Tpux+aNiN2OcVk0MvXqGi20w=;
 b=LkuPqJCjx+bLMVIJnVHi+nFaiU8L+8JKmBa6ICX4HWokzCw3Gl4asdYiBLA3cKxSnc
 vVx818zIip5wOR/J0DfZMJk9JffTnSXn8r2qoFe7QzZ56iGfZp1yDZhpc2Lo/urHY0ps
 GYl0VwXkgIzWdXB+4JReQiBNMx4FvGmyO/Oie0cwTmkGHd4SrbVhI2+mGFtX2WsVJzhj
 XYmMFQciVZBbs9sK2eLlV6d0NFW/ouanA1zvcTN2rBbR65TwLtANPhYJRSMzSIYhiTzN
 m2lAE34sctQLhRTJf+3J2qbni8SIR7H/nK1AaUeLPkuM/6ZMaLn0qoatqOrAdcnOzEmh
 0Rzw==
X-Gm-Message-State: AJcUukd/lvbjZp1sy1Nw4H+hf9Xp1KroAxJn34f+ezuzLeVRCjS/7496
 O/77nS5uvvGiTcXXizlxFIFFnw==
X-Google-Smtp-Source: ALg8bN6+zBlIsLdvH0rPTB6ook6Al5zMZJFCCDkzoZ574m1bxusoJ/GiWAUd7oEjSj+qBUP5QEc71g==
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr22393190wrx.134.1548698687963; 
 Mon, 28 Jan 2019 10:04:47 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:47 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
Date: Mon, 28 Jan 2019 19:04:20 +0100
Message-Id: <20190128180430.28689-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100449_375753_86474E0D 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c        |  1 +
 drivers/clk/meson/clk-regmap.c |  5 +++++
 drivers/clk/meson/clk-regmap.h | 15 +++++++++++++++
 drivers/clk/meson/clkc.h       | 15 ---------------
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 1c6539eeee7c..474412234633 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 
 #include "clkc.h"
+#include "clk-regmap.h"
 #include "axg.h"
 
 #define IN_PREFIX "ee-in-"
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index c515f67322a3..dcd1757cc5df 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -4,6 +4,7 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
+#include <linux/module.h>
 #include "clk-regmap.h"
 
 static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
@@ -180,3 +181,7 @@ const struct clk_ops clk_regmap_mux_ro_ops = {
 	.get_parent = clk_regmap_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index e9c5728d40eb..b7a085bbf072 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -111,4 +111,19 @@ clk_get_regmap_mux_data(struct clk_regmap *clk)
 extern const struct clk_ops clk_regmap_mux_ops;
 extern const struct clk_ops clk_regmap_mux_ro_ops;
 
+#define MESON_GATE(_name, _reg, _bit)					\
+struct clk_regmap _name = {						\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ "clk81" },		\
+		.num_parents = 1,					\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+	},								\
+}
+
 #endif /* __CLK_REGMAP_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index e3cd442db739..35768c2327ba 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -95,21 +95,6 @@ struct meson_vid_pll_div_data {
 	struct parm sel;
 };
 
-#define MESON_GATE(_name, _reg, _bit)					\
-struct clk_regmap _name = {						\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = #_name,						\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ "clk81" },		\
-		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
-	},								\
-};
-
 struct meson_clk_dualdiv_param {
 	unsigned int n1;
 	unsigned int n2;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
