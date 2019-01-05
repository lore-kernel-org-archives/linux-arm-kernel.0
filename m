Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6994EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E14218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FjAVsqEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E14218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VMGdP4eTgK/4TNEqf9iPG52lpiEQjeJXorH+XCKXww=; b=FjAVsqEvcFADDH
	FhElxx0uTgAksgEfZ54c77m5on6wyMD7f+egq0GuMwxxWpmbLnv4E8HheasWY4qIXbp2Oixm60oMI
	B8XQEoLHAkgMGtwzZkA33TLHb8DdlKijtVrAdKkG8AnXz6i9znv8gdp4OY1V0OCyQip2umbaIin0E
	YJDyqvYJACJHuutAsi4Nnf7p9DyNJhWt/yWk8OKBbC4iwoKfv3D9vir+Zazh1KLHoiJxnCcRNbKuV
	k5z8VnYc0Cugh+raz9YrUzyvPOPBQccuj2xyv48Wz7GwjYucd2yiBya+kPB1tkmv//SuoLH+uDmU9
	K2yGWYHIfcISzaX0dkUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfq4O-0006a8-O3; Sat, 05 Jan 2019 17:49:12 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfq4C-0006Pp-LS; Sat, 05 Jan 2019 17:49:02 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id 91048101714;
 Sun,  6 Jan 2019 02:49:36 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 1/3] clk: rockchip: add video clk parents for rk3399
Date: Sun,  6 Jan 2019 01:48:35 +0800
Message-Id: <20190105174837.19378-2-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_094900_811827_DAA34140 
X-CRM114-Status: UNSURE (   7.43  )
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
Cc: ulf.hansson@linaro.org, zhangqing@rock-chips.com, heiko@sntech.de,
 geert+renesas@glider.be, sboyd@kernel.org, mturquette@baylibre.com,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Video codec won't work properly with a clock too low nor
too high. We need to export them, allowing the device
tree to assign a suitable clocks for them.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/clk/rockchip/clk-rk3399.c      | 5 +++--
 include/dt-bindings/clock/rk3399-cru.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5a628148f3f0..fe6cebcb26b6 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -740,7 +740,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(15), 6, GFLAGS),
 
 	/* vcodec */
-	COMPOSITE(0, "aclk_vcodec_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
+	COMPOSITE(ACLK_VCODEC_PRE, "aclk_vcodec_pre",
+			mux_pll_src_cpll_gpll_npll_ppll_p, 0,
 			RK3399_CLKSEL_CON(7), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vcodec_pre", "aclk_vcodec_pre", 0,
@@ -764,7 +765,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(9), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 5, GFLAGS),
 
-	COMPOSITE(0, "aclk_vdu_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
+	COMPOSITE(ACLK_VDU_PRE, "aclk_vdu_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
 			RK3399_CLKSEL_CON(8), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vdu_pre", "aclk_vdu_pre", 0,
diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 22cb1dfa9004..dd13554aaf76 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -219,6 +219,8 @@
 #define ACLK_GIC_PRE			262
 #define ACLK_VOP0_PRE			263
 #define ACLK_VOP1_PRE			264
+#define ACLK_VCODEC_PRE			265
+#define ACLK_VDU_PRE			266
 
 /* pclk gates */
 #define PCLK_PERIHP			320
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
