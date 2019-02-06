Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40441C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C58A2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I7DQWfTJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NfefY0Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C58A2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dNn+UGj5KPWw8OR3jxMFYlDnLN/Tcr+d8UFzZsO4ShY=; b=I7D
	QWfTJlwj5G6C9PeAdOKmWswcMecH6pTzvIIV88u++VCehL8UfARYMVQp0Aevl5VuR4eh7UfPIYCls
	1Vy6N0isZbZgqw6WkwqYu0VFTeLNLeANxZhtuy0IaLb3x8LG23GQSE8AZy7dvhh+nMduQF/l8wFZi
	aSLCNt8aHG8QehxFnhV6MO9U34UUz7rNrn53umyWERolW5r8LrwjstW/YO3Aa0pTLOArZkIebSrmG
	LecgzGX1RriKsF44vvYXm0jI4Z3KhBtlXqtYZWnZitRWS4hm+Zzbe+P9D63Dam6W1lVOoFNhkG6iA
	FvKtMS7udObZ5FoqyNn6PoI0vuzD54g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDvK-0002Y4-16; Wed, 06 Feb 2019 03:30:54 +0000
Received: from mx1.ucr.edu ([138.23.248.2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDvF-0002Xl-Le
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549423849; x=1580959849;
 h=from:to:cc:subject:date:message-id;
 bh=RoHy0oCGXIhna6y33HCrI+i2WKeLdKhVB5imxc0MR+A=;
 b=NfefY0TpyrDFyPa9/32x9M/MQ/Ipdn3He16GpP7ajdSPRwRTdXeO2KhR
 FReKZ6VRfP8WWGndpsXk4PkxdFeU78Z2nF21GZmBK6SKVrWkR34zcAWiT
 r8U3jsBOti8c7FMRoAVUIVHAPj/4ZDDDvR7L6bwk35mZWu4mRy8LyWTEI
 El7dJhHZfCxdaWowjfbUAp9ocu+ZALSpi7p5XWIrdGurDWSnNZ09OsLuQ
 E5iJ2Eo1e+wJgbP4D0QUItDerTlzFacLD2Qle8HxlhT2BBsRqSimlP1AM
 C8HEHWvIN5sbFzBAkXHWeYTid9nL0iR/9J3XFcphvMc8DYo1JerjRKrGN Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AZS0qlBC4FHc2lEMPpOhzUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSPvyr8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzfqbcfdMBXmpBX8BRVyNcCY2i?=
 =?us-ascii?q?doUEEuQBPedGoIn5ulQFsB+yCAewCO/qzDJDm3340rAg0+k5EQ/IwhEuEdwNvn?=
 =?us-ascii?q?rTt9j5KLseXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBUrBxccvQyUkvCgTFhUiX?=
 =?us-ascii?q?pI3lPjKV1v4Cs2mH4+Z8W++ikHMnpB1rojS12Mgjl5TJi5sTx1vZ9it52J44Kc?=
 =?us-ascii?q?OkREN/e9KpE5tduzuEO4drXs8uWXxktSI+x7EepJK2fSwHxI45yxPRa/GLaZaE?=
 =?us-ascii?q?7xP5WOuTLjp1gm9udqiliBao60egz/XxVsyz0FlXsCVIisLMtnUR1xzL7ciHV+?=
 =?us-ascii?q?d98l+h2TmR0wDT7flJIUUumqraL54t26YwlpQOvUjaEC/6hUH7gauMekUr/eio?=
 =?us-ascii?q?7OvnYrH4qZOGK4B0jQT+Prwvmsy5H+s4LhADU3aH9em4zrHu/k30TK9UgvErjq?=
 =?us-ascii?q?XVqo3WKMAfq6KhBg9ayIcj6xKxDze819QYmGEKLVJEeRKHlYfpOk3CLOz2APqk?=
 =?us-ascii?q?nlSjjC1ry+rYMbL8H5XBNmLDn6v5fbZh905czxI+zdRe55JSF7EAL+v/VVXrtN?=
 =?us-ascii?q?zdFxM5MBK7w/zhCNpj0oMTQmaPAq6CMKPOql+E/OMvI++CZI8PojnyNuYq6OTz?=
 =?us-ascii?q?gnMjnl8dZ6apjtM5cne9S8VnMUWEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6?=
 =?us-ascii?q?sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMAACFVFpcgMfSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUgYBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZ?=
 =?us-ascii?q?QEHgUsJAQiHcIRBgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwC?=
 =?us-ascii?q?IFAEtmz0CBAIEBQIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IPAS-Result: =?us-ascii?q?A2BMAACFVFpcgMfSVdFlHAEBAQQBAQcEAQGBUgYBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZQEHgUsJAQiHcIR?=
 =?us-ascii?q?BgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwCIFAEtmz0CBAIEB?=
 =?us-ascii?q?QIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; d="scan'208";a="1052827337"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
 by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 19:30:48 -0800
Received: by mail-pf1-f199.google.com with SMTP id y6so4219748pfn.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 19:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YYDz1uajXM2BD9Gmd2pvUl+dFDUhIgT0Qevcatq2bns=;
 b=Y+HS6x6Jm+RTPvDDdv1zrBEnIwyp+PXIG5T3cQm9FqPR5ZkKlGYQXm6LKK1sNvX7dJ
 FSYH9DnVmHJIflgtkbDdkeErk2Ms+5fNsOq1rJUuZ2gFUutq4h9jFiottUlx3t9sEelg
 ROT8gUghVEPKzNeaxI6Yfac9PxJ0jiMaPtzoG089+MqEVQoBGir9C3/hVWGzawLiAkcH
 nJD7gWCpnFLVabbOGGNieeDIypw+ADgxwSYbbFL6QSzW1cQFOGAu42VNyDHbyLuKa3dt
 SbX2Pfw/eQzsmLUz5Zmt/fP0/oxCV06rdTPl/MOuGsRbnN8HhnrGayKfttrit7k2xn05
 AUiw==
X-Gm-Message-State: AHQUAuY6e5siqFBhEayt0AtUusgKrwq+rbA2b4u1LKiEn4H6fxfdUOOt
 dFvCXOZUgQo1ORQxZBYKhEM1r5knWLUjU0lMO/FTvXCuS7qhxYXo8EXjppkGfGht7bwk8zphRKz
 KzQD4wqmLtdWMfRJ25P/u6grSuYlF8sJR+26e
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr8345237pln.324.1549423847912; 
 Tue, 05 Feb 2019 19:30:47 -0800 (PST)
X-Google-Smtp-Source: AHgI3IaToAk1qKrM98u2WVG62AntNk2kOh/LjiLDaXOGTAhdEC3TosN9dKtPsvvezCKOlTRbmIcmWg==
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr8345227pln.324.1549423847721; 
 Tue, 05 Feb 2019 19:30:47 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id v15sm5414056pfn.94.2019.02.05.19.30.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 19:30:47 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] phy: Variable "val" in function miphy_osc_is_ready() could be
 uninitialized
Date: Tue,  5 Feb 2019 19:30:36 -0800
Message-Id: <20190206033036.22729-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193049_744030_3E5C89C6 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: csong@cs.ucr.edu, linux-kernel@vger.kernel.org, zhiyunq@cs.ucr.edu,
 Patrice Chotard <patrice.chotard@st.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Yizhuo <yzhai003@ucr.edu>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function miphy_osc_is_ready(), local variable "val"
could be uninitalized. if function regmap_read() returns
-EINVAL. However, this value is used in if statement.
This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/st/phy-miphy28lp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 213e2e15339c..40c7c0a611a0 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -835,7 +835,8 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
 	unsigned long finish = jiffies + 5 * HZ;
-	u32 val;
+	u32 val = 0;
+	int ret;
 
 	if (!miphy_phy->osc_rdy)
 		return 0;
@@ -844,8 +845,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 		return -EINVAL;
 
 	do {
-		regmap_read(miphy_dev->regmap,
+		ret = regmap_read(miphy_dev->regmap,
 				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
+		if (ret)
+			return ret;
 
 		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
 			cpu_relax();
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
