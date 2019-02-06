Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F95C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EFD217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtQ6li7z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XBQTjLOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EFD217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dNn+UGj5KPWw8OR3jxMFYlDnLN/Tcr+d8UFzZsO4ShY=; b=XtQ
	6li7zJHC4KqNT3h9mc0JAVqyeU8TGcF2C/UTy/xRHZabLbJbg9/9eFLn3fNeb1vbPLmQWGWB+CNHi
	OHhbflOcL52PCgrgprVXaiwD5HoFIHVm4JEPtWW+2r681nO/MAVEtIgr+K/GfDIJVjj4o0788owW/
	B6pfeF+bM9F1Df2dyz5XbxfPVSufq9TjZIpmCHLQdQavgX1TiDFKmBk3IF9v5LXBL5bFRGkRmyZqg
	+MhPjQR55/HMLFqDXF7M7WNfdS1xZq5k1XJKb0pf6+exrNhSziQe7QfbEKdcZZC8lkOeKF5dyGyjb
	WM0sjqb24/7ocAVyHcayO1Oj5nM/D+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDeE-0005I7-Uj; Wed, 06 Feb 2019 03:13:14 +0000
Received: from mx5.ucr.edu ([138.23.62.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDeB-0005Hn-7l
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549422791; x=1580958791;
 h=from:to:cc:subject:date:message-id;
 bh=RoHy0oCGXIhna6y33HCrI+i2WKeLdKhVB5imxc0MR+A=;
 b=XBQTjLORAdWfi0poKH34xLYivvQODrXADSqORj8gFkFj0rrw55SXKIAt
 oNZctBIJHofLmoyoLA9etOlLi3l11gUf3aa3ifLuEOvxKOmcQppjQupPj
 f+iBSExCXt8LloQqGt+vkNRUfPG44LYtHflJ8Js2crFdtqM3lj3PL2DcP
 6Y7AvUwjQZM93YPE2hKo8z7yo+R2X1cLZJiFLomnpPPL6Nsjz9RDV7RVM
 n/7oT5h/0mGe7G5xKvTmhePaoPq0usRxeGmi8nW1HLC72fFkzstfpTCeJ
 2wWNoL41QkJ1B23f2jgHaSG+DLWSoMTwaCxMo8CRT+rhhFBXkkzeqxu6e A==;
IronPort-PHdr: =?us-ascii?q?9a23=3An4sQFhZNiJ6JbkihYAkSaLL/LSx+4OfEezUN459i?=
 =?us-ascii?q?sYplN5qZoMWybnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUxJXwe?=
 =?us-ascii?q?43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRp?=
 =?us-ascii?q?OOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0AbCrGFSe+?=
 =?us-ascii?q?RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG81/9HktQPC?=
 =?us-ascii?q?TQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58axlVAHnhz?=
 =?us-ascii?q?sGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7deNIaRXFaXsZQUSxBDZ63?=
 =?us-ascii?q?YZUWAeEcM+ZYrpfyp18TohCjAQWhCv/jxjpOi3Tr36M1zv4hHBnG0gI+AtwAvn?=
 =?us-ascii?q?faotLuOasOTey41rXEwC/fY/9K3zr29YjGcgomofGJRb9/c8vRyEgvFwPYiVWb?=
 =?us-ascii?q?tIvoPjOU1+QNqWeb7vZsWf6hhmM8tgF+viKvyt0yhYbUm4IY01bJ/jh6zoYtPd?=
 =?us-ascii?q?C0VlJ3bNq+HJZTtyyWLZV6Tt4+T21ypSo3zr4LtYamcCULzJkr3QDTZvKHfoSS?=
 =?us-ascii?q?/B7uVfydLDV3iX9jZbmxnQy98VK6xe35TsS01VFKoTdbndTUrXAN0gDT6tCASv?=
 =?us-ascii?q?tg4ketwTaP2B7X6uFDOU00kLDUK58lwrIpjpoTv1nPEjb4mEnriKKbdV8o+uev?=
 =?us-ascii?q?6+TgbbXmooGTO5VohQH5N6Qigs2/AeImPQgSR2WX5/iw2bn58UD6QLhGlOM6nr?=
 =?us-ascii?q?TFvJzAOMgWoq20DxdQ0ok56ha/Czmm0M4fnXkCNF9EeBOGj4jzNFHPPPz0Efmy?=
 =?us-ascii?q?jk+xkDh33fDKJKPuDYjQLnTbirfuYa5961JAyAo01d1f45NUCrccIPP8Q0P+rs?=
 =?us-ascii?q?bYDhogPwy33ennEtN92Z0aWW+UBq+ZMbjSsUOT5u41IumMYoEVuCznJPc4+fHh?=
 =?us-ascii?q?l2I2lUUafamz0ptEIF6iGfEzEkSLYWfryoMQA2cDv1JmF8T3g0fEXDJOMSXhF5?=
 =?us-ascii?q?kg7y02Xdr1RbzIQZqg1fnehCo=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMAACCUFpcf8bSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUgYBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJCwsIGwwxgjopgl82UoEVAQUBNVuCRwGBdA0FoQY8jBczi?=
 =?us-ascii?q?GUBB4FLCQEIh3CEQYEPgQeDbohTgkMCgSwBAQGQCJFIAQYCAYFlgUOPDCWDNoc?=
 =?us-ascii?q?AiBQBLZs9AgQCBAUCBQ8hgSYBggxNJYFsCoFEglKOLB4zgQeNcwE?=
X-IPAS-Result: =?us-ascii?q?A2BMAACCUFpcf8bSVdFlHAEBAQQBAQcEAQGBUgYBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJCwsIGwwxgjopgl82UoEVAQUBNVuCRwGBdA0FoQY8jBcziGUBB4FLCQEIh3C?=
 =?us-ascii?q?EQYEPgQeDbohTgkMCgSwBAQGQCJFIAQYCAYFlgUOPDCWDNocAiBQBLZs9AgQCB?=
 =?us-ascii?q?AUCBQ8hgSYBggxNJYFsCoFEglKOLB4zgQeNcwE?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; d="scan'208";a="26854468"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
 by smtpmx5.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 19:13:09 -0800
Received: by mail-pf1-f198.google.com with SMTP id o7so4170041pfi.23
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 19:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YYDz1uajXM2BD9Gmd2pvUl+dFDUhIgT0Qevcatq2bns=;
 b=FTYDg/CQuzra7ceyKsgwDd7htZNTJxSVEhCrXDvgvQDtUjT56AtgKrx5+LrEtvrrF8
 KF0eo8+BECtW8iPfAQuWy/nNTabwcJZJOrOuncQ/SD5nWb772etHjU9o9VM3L0pf74PO
 nsCFp+wol20gxVEyYcxsyZztgBDTp4DQh3U3lwvWrIbKENiICHXlagjIdL74jPXiSZlQ
 H9xXyaX3ntLWRsfuP7y7e7GFfvUOVmoy7LiSvxdLQ1GMYF6RNFru/otueKARnhdxlzzC
 alZlyEfOqveeJklbO/votMfuWQjIRXTt4qXLT+XwaAoHJifHotdGvPjDlyx5EIgjm6Yi
 350g==
X-Gm-Message-State: AHQUAuaLBANfyxAByQ0ofyLMKtEA+6EGt21UxBfk1Ve5D1NdJvbYTU0G
 kf82a5AiF1/HCyOa9fcWjWxh9PQFjoWPMRC6yrO3gG6hlaFU1Kmws5AjWnOfAdDKxFANvlzIMeY
 xSsTR4SCc+Hy4YilPaoNOT2DyoxKB9rT5BI4B
X-Received: by 2002:a17:902:145:: with SMTP id
 63mr8461158plb.256.1549422789164; 
 Tue, 05 Feb 2019 19:13:09 -0800 (PST)
X-Google-Smtp-Source: AHgI3IaeCRQc9opHP2/SPoEliLwcrh3aaO85I7bM3TBhacFo7U2dv422YbEPqOxKBlckPLSaLHN+mg==
X-Received: by 2002:a17:902:145:: with SMTP id
 63mr8461132plb.256.1549422788787; 
 Tue, 05 Feb 2019 19:13:08 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id
 q187sm12357838pfq.128.2019.02.05.19.13.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 19:13:07 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] phy: Variable "val" in function miphy_osc_is_ready() could be
 uninitialized
Date: Tue,  5 Feb 2019 19:12:57 -0800
Message-Id: <20190206031257.22494-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_191311_306182_D7418D51 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: csong@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, linux-kernel@vger.kernel.org,
 Patrice Chotard <patrice.chotard@st.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, zhuyunq@cs.ucr.edu,
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
