Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D1C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F172C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g00waAWa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="j7V8g0Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F172C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=TWDHnLmAU+6EH1q1EaT5pB2FFOuxeKuzLtw4GPhsFis=; b=g00
	waAWadAAbDwTIIzxCOAomuN93OgoNl45K66lgRNM7/sfapDyYXSzceFmnJFFi+i6R2BMVzHoM4mec
	RqAkHBNM5n0MJ2/0h9YYuwW970/Qi1jI8OzFtsRz2mqljGdjbq1ty3jWSJeji964YVD4gRyAYBzNH
	p+++P6bedt8x1Z86s8PF02oZA6SVn8YCQsu0pt/OovvqNylGDtPIAUzrOnXDFGOUtfrTlsI0B4WZp
	ParESE8wGOUx8mcxPeKDF1U3TVRCaXkAft3BvpGWux6EMFeumXW4oxoR0iRXU8P/1dpQJThVJz5aN
	VUJR2Dvftwwr9w9ci9QazQBroxMrWcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr919-0003O1-56; Tue, 05 Feb 2019 22:16:35 +0000
Received: from mx1.ucr.edu ([138.23.248.2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr915-0003NF-Os
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549404992; x=1580940992;
 h=from:to:cc:subject:date:message-id;
 bh=cNkg2Xb4v6zj8LUbrGCNxIBVY9mdRdd173BdKbDCchw=;
 b=j7V8g0Xrrku7ulaVfnQw/Zekp4tEN8zxmkcPYTZ4mP9aDaj8AuJo1sPi
 LuRXT2Zwgj8fHVAG6CHZBcoOnOwOc7I4Ka7ceHRS/Va0A3vx2qHQ0FMRW
 1CEPa0Z1UCjI/2Z1FHo3SBd3xg/cSKVNQiOpf6c70/dENzEniLrO2BtbV
 Ij3w5TJ1bHYifaDjlUKwfjU/oWencC+PTg6POTQ7GrcwXet0eabRLmn4+
 c5SaHsY9iUQi9a6wmVN4aBM5h5mgVqy8HzEUqWWFdtkYtzLuRutOpIvAa
 jUezEMDGuwNvDFd//tAe9x/+kauxgWyxryNd/usG8s8z2C+GmHVha3EvT A==;
IronPort-PHdr: =?us-ascii?q?9a23=3AMy2fdBC+sxTTYlXeh4KLUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSPvyr8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzfqbcfdMBXmpBX8BRVyNcCY2i?=
 =?us-ascii?q?doUEEuQBPedGoIn5ulQFsB+yCAewCO/qzDJDm3340rAg0+k5EQ/IwhEuEdwNvn?=
 =?us-ascii?q?rTt9j5KLseXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBUrBxccvQyUkvCgTFhUiX?=
 =?us-ascii?q?pI3lPjKV1v4Cs2mH4+Z8W++ikHMnpB1rojS12Mgjl5TJi5sTx1vZ9it52J44Kc?=
 =?us-ascii?q?OkREN/e9KpE5tduzuEO4drQs4uWXxktSI4x7EepJK2fSwHxI45yxPRa/GLaZaE?=
 =?us-ascii?q?7xP5WOuTLjp1gm9udqiliBao60egz/XxVsyz0FlXsCVIisLMtnUR1xzL7ciHV+?=
 =?us-ascii?q?d98l+h2TmR0wDT7flJIUUumqraL54t26YwlpUOvUjaEC/6hUH7ga2MekUr/eio?=
 =?us-ascii?q?7OvnYrH4qZOGK4B0jQT+Prwvmsy5H+s4LhADU3aH9em4zrHu/k30TK9UgvErkq?=
 =?us-ascii?q?TVqo3WKMAZq6KhBg9ayIcj6xKxDze819QYmGEKLVJEeRKHlYfpOk3CLOz2APqk?=
 =?us-ascii?q?nlSjjC1ry+rYMbL8H5XBNmLDn6v5fbZh905czxI+zdRe55JSF7EAL+v/VVXrtN?=
 =?us-ascii?q?zdFxM5MBK7w/zhCNpj0oMTQmaPAq6CMKPOql+E/OMvI++CZI8PojnyNuYq6OTz?=
 =?us-ascii?q?gnMjnl8dZ6apjtM5cne9S8VnMUWEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6?=
 =?us-ascii?q?sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AjAADKClpcgMXXVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBgztKD4wdX4sXUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQM?=
 =?us-ascii?q?BAQIBAQIBEwEBCQ0JCCcxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIYgEHg?=
 =?us-ascii?q?UsJAQiHcIRBgQ+BB4NuiFOCQwKBLAEBAYpNhTuRRgEGAgGBZYFDjwslgWyBSoZ?=
 =?us-ascii?q?+OIdaAS2bOQIEAgQFAgUPIYElgg5NJYFsCoFEglKOLB4zgQeNcwE?=
X-IPAS-Result: =?us-ascii?q?A2AjAADKClpcgMXXVdFlHAEBAQQBAQcEAQGBUQcBAQsBgzt?=
 =?us-ascii?q?KD4wdX4sXUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQMBAQIBAQIBEwEBC?=
 =?us-ascii?q?Q0JCCcxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIYgEHgUsJAQiHcIRBgQ+?=
 =?us-ascii?q?BB4NuiFOCQwKBLAEBAYpNhTuRRgEGAgGBZYFDjwslgWyBSoZ+OIdaAS2bOQIEA?=
 =?us-ascii?q?gQFAgUPIYElgg5NJYFsCoFEglKOLB4zgQeNcwE?=
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; d="scan'208";a="1052818069"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
 by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 14:16:15 -0800
Received: by mail-pg1-f197.google.com with SMTP id o187so3215481pgo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 14:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pRKoSfdwVwNdyz3mDpwMRoy9Lm16c1WzLiKmYaYvmpE=;
 b=dWUdhA/fxejoUFvjd8XjaARG3vNP+bxPULs5aYYHr5rOcJNQJgEO0a7QeChnYHfvpi
 wTkd33xKsx917PTU9o9MoweUONQuR4y42Tv4TVVFMMCcPVz1id3bnOWj4is2ezGUCnzT
 0zgzO1SoFfMUMD4EOEcaXXncOPNHCMWzXZMI/zcaXcoqTfBZVs2FgaEXrhM5bMDFCBox
 Tv61UGff1xYwgkHb7PGdqYyPZ0xZ9K0K9zUra5bVjLD4I1mIPkbtqgF8RBSbFcNptsGe
 Lon307v+F9FLwTiagarvuqeQ50Sj9iRm/fByoaFe1H8+hU6QuGiMu8/PS/4KFcwrRXb2
 IC0g==
X-Gm-Message-State: AHQUAuZ9LpknL/LxnlISz25IzM7zcZ1XzeiKyo/3hW5OeJeX4t6xt1cE
 3j+drBWj5tLGRW/C8NHUjgjLZVKWkCh/ENQ6Lg1Um3kRifhsgGhMilx4P0KjWr5/+td8x7pmbDl
 zlBbPprZHBQU9GjXS/sQ5chK0ZmRm774B11bv
X-Received: by 2002:a63:571f:: with SMTP id l31mr3789827pgb.91.1549404974102; 
 Tue, 05 Feb 2019 14:16:14 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZCsiMpsIK6rGFrgQ8DS7SKjLCGYc9FvgfZmMIbuVkDRAGCjMCY6cD2q1+TJ8D5jJk+fQPLNQ==
X-Received: by 2002:a63:571f:: with SMTP id l31mr3789795pgb.91.1549404973698; 
 Tue, 05 Feb 2019 14:16:13 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id d13sm8942729pfd.58.2019.02.05.14.16.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 14:16:12 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Date: Tue,  5 Feb 2019 14:15:59 -0800
Message-Id: <20190205221559.17545-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_141631_807182_2BC689A0 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: csong@cs.ucr.edu, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Yizhuo <yzhai003@ucr.edu>, Chen-Yu Tsai <wens@csie.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function sun8i_dwmac_set_syscon(), local variable "val" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the if statement, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 39c2122a4f26..11d481c9e7ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
 	struct device_node *node = priv->device->of_node;
 	int ret;
-	u32 reg, val;
+	u32 reg, val = 0;
+
+	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	if (ret) {
+		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
+		return ret;
+	}
 
-	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
