Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F22F2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ArK2GXxY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ssAyL97J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F22F2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=i5vxWMmI5ZlabfCbs3XcdC2SsDgn36y+0NnF0QFo7Pg=; b=ArK
	2GXxY71hONdFu0E2b//echuMejHqCVyzzinsKhieA3af72O5p4wx7sO4SmCg2Y8kavkkHF5TjXWkM
	lx8fVdVfLfpCci6i/4WANkmb6gn5DGVlkz6hJ5ubLKNLjZYHHP9H8Jg+CEYAXlOqyeebgkx8/ou16
	CpOKkmXAB9Jdt5bTme7u17D3JBsgGVgRWAlNmB75DhTOe0Lo1l6/T8aD8RUJji0GqVXlsntBvqd9G
	CchUGjodMIniQytzjf+U1HJfL42pmpClZi/hEOt9o8eUbttNz6GjRhKwY4MmUxd1k6IuznNjUymbr
	I4VIEY8x+Svueh2thfQwx+nkirT7nHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grCJg-0005Yy-Fv; Wed, 06 Feb 2019 01:47:56 +0000
Received: from mx6.ucr.edu ([138.23.62.71])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grCJd-0005YE-1k
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 01:47:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549417672; x=1580953672;
 h=from:to:cc:subject:date:message-id;
 bh=MkIFH725olQXVn1J0td1c/AMRtWp8ZUI3+26TG4Oq/o=;
 b=ssAyL97JJ7w//K2c6xugz8hfNXCkQKgqM/BDg8PwavvfSZ9p8SMa07NC
 kJnT4GcaVRa0xnFo+j2KI9DeikdJQ79MtXaqwoE8nJY+YmSqh19hPGb2I
 4qDSYiHE0JIV5oAYsFZRlcoJMl95da0b90i7uHYK/h/8OAti8FiZM8XIK
 pVWunjnCDi3LWl0rzw0qzhZ+1NpfnToF5TR7ewF7AlOum6gmEIz3FwXOi
 nVWcuENnTd6asoiLrR788MssgflB5DM0gLFwalE2YyVcOEOnXEdTw66ZV
 NhNxzDUXZ+G0HmxPegxCIuWNRZ9VbOt53tiAnNQVC7NS/BN60ZFagABvP Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AK0cK7x8r9eaK6P9uRHKM819IXTAuvvDOBiVQ1KB4?=
 =?us-ascii?q?2uIcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fDhBt/?=
 =?us-ascii?q?8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1?=
 =?us-ascii?q?Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyhzHontJf+?=
 =?us-ascii?q?RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKWE169b1uhTF?=
 =?us-ascii?q?UACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRzut86ZrSAfpiC?=
 =?us-ascii?q?gZMT457HrXgdF0gK5CvR6tuwBzz4vSbYGQNfp+ZbjdfdIcRWpOQ81fSTVPCZ6y?=
 =?us-ascii?q?b4sOEeUBOftXpJT5q1YAsReyAA+hD/7txDBVnH/7xa003fo8Hw/I3wIuGMkDvG?=
 =?us-ascii?q?jIoNjvKKsfS/y5wLXOwD7eb/1WwzD96I3Qfx8joPGNXLJwcdfWyUIyEA7EjlSR?=
 =?us-ascii?q?qYz/MDOUyugBr2aW4vF9Ve2zkW4rsR9+rSWyxso1jITCm4Ebykjc+Cln3Io4Ic?=
 =?us-ascii?q?e0RU17bNK+Dpdcqi6XO5FrTs4mQWxkoDs2x7wCtJKhYiQHxpQqywTBZ/GGaYSF?=
 =?us-ascii?q?4B3uWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U5RripAjtnMrncN1wHP6sSfSv?=
 =?us-ascii?q?ty4EOh2TGX2gDW8O5EIEQ0mbPDK54l37I8j5QTvVnHEyL0gkn2g6iWdkIr+uis?=
 =?us-ascii?q?9evreKnpppiZN4NsiwH+NLohmtCnDOgmLgQDW3KX9Oe82bH540H1XbpHgucrnq?=
 =?us-ascii?q?Tdsp3WPcEbqbS4Aw9R3IYj8RG/DzK+3dUYnHgHLEhKeBObg4T1NVzDO+34Auul?=
 =?us-ascii?q?g1i2jjhk2u3GMqX7AprRNnjDjKvhfbFl5k5YyQozy81f5p1NBr4bOvLzX1b9tN?=
 =?us-ascii?q?/GAR8jNQy73eLnBc551oMfQmKPHrSZPLnTsV+O6OIvOfODa5ILtznnNvcp/fnu?=
 =?us-ascii?q?jWU2mQxVU7Ou2M4maWK4A/Mud1SLYXPt2o9aOXoBpEwzQPG82w7KaiJae3vnB/?=
 =?us-ascii?q?F03To8Eo/zSNibSw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AAAaPFpcgMXWVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBgztKD4wdX4sWUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQM?=
 =?us-ascii?q?BAQIBAQIBEwEBCQ0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNBaEPPIwXM4hkA?=
 =?us-ascii?q?QeBSwkBCIdwhEGBD4EHg26IU4JDAoEsAQEBiESHRFiQbgEGAgGBZYFDjwslgWy?=
 =?us-ascii?q?BSoZ+OIdaAS2bOQIEAgQFAgUPIYElgg5NJYFsCoFEglKOLB4zgQeNcwE?=
X-IPAS-Result: =?us-ascii?q?A2A1AAAaPFpcgMXWVdFlHAEBAQQBAQcEAQGBUQcBAQsBgzt?=
 =?us-ascii?q?KD4wdX4sWUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQMBAQIBAQIBEwEBC?=
 =?us-ascii?q?Q0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNBaEPPIwXM4hkAQeBSwkBCIdwhEG?=
 =?us-ascii?q?BD4EHg26IU4JDAoEsAQEBiESHRFiQbgEGAgGBZYFDjwslgWyBSoZ+OIdaAS2bO?=
 =?us-ascii?q?QIEAgQFAgUPIYElgg5NJYFsCoFEglKOLB4zgQeNcwE?=
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; d="scan'208";a="26763083"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
 by smtpmx6.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 17:47:44 -0800
Received: by mail-pl1-f197.google.com with SMTP id q20so3779804pls.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 17:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=v2+oUWDnQz4pz+6QK9pnqRnNQZm/eHZVWJ/uZZFNW/A=;
 b=mPHcWUUeBDNZlGT3swA4U3I/0qEod5JKYFbTpWWh7TEaLt3WOxe0dsQuLOCRumW5z0
 KHgtZAok12WWGJa73CrBgen+3muVvz/+GKYqqL5aBn8VwApbKMQE0WyTo2zdPDn9TO2v
 vc5zZz1QN41PHCRnOhkEIl7ypUSdzUmzhAipLgjekOfY2VkAZ/B9XDYal8iKcn4wByPk
 tR4jRULtg6XLSVhHoVQ4T/yj0F9KYUPliFK81uwTouQU51Jw5d91VwmkApW2ij1et5Vr
 /Y6tUq/KnsTe07SSOJaj0k+5xXeyTZB6+SHA6b18rXuB4f2oK2JdPpCEykKv3cl6T9Ei
 VqLA==
X-Gm-Message-State: AHQUAuayD5muRjJOamtc7q2XRaRdyqh/qAvkckxdGJBVYzLWBu4ASTA/
 Z6TyrTGZ74DaRpH84rXhldfDm7TrtQpjhb+vgj6PsZZ35L3f8pkCdiTmLvEvrNm+Rip6MMfj8ql
 3v1QwGz/7PNtxbuo3LBbROK6+EfMZSWlBJbLj
X-Received: by 2002:a62:4d81:: with SMTP id a123mr8219315pfb.122.1549417663965; 
 Tue, 05 Feb 2019 17:47:43 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZ/Dj8XlceW1pvJi4tE1ublOmi4prcBrw/600wizMg1uz17vyyzMG0/5Rf2549oAiXQIVi4mQ==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr8219285pfb.122.1549417663512; 
 Tue, 05 Feb 2019 17:47:43 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id z13sm8736089pgf.84.2019.02.05.17.47.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 17:47:42 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] phy: Variable "caldone" in function rockchip_emmc_phy_power()
 could be uninitialized
Date: Tue,  5 Feb 2019 17:47:33 -0800
Message-Id: <20190206014733.21094-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_174753_121759_31481843 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: csong@cs.ucr.edu, Heiko Stuebner <heiko@sntech.de>, zhiyunq@cs.ucr.edu,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Yizhuo <yzhai003@ucr.edu>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function rockchip_emmc_phy_power(), local variable "caldone"
could be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index f1b24f18e9b2..ca921ae08309 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -85,11 +85,12 @@ struct rockchip_emmc_phy {
 static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	unsigned int caldone;
+	unsigned int caldone = 0;
 	unsigned int dllrdy;
 	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
 	unsigned long rate;
 	unsigned long timeout;
+	int err;
 
 	/*
 	 * Keep phyctrl_pdb and phyctrl_endll low to allow
@@ -164,9 +165,14 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	 * wait 5us for calpad busy trimming
 	 */
 	udelay(5);
-	regmap_read(rk_phy->reg_base,
+	err = regmap_read(rk_phy->reg_base,
 		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
 		    &caldone);
+	if (err) {
+		pr_err("Failed to read status.\n");
+		return err;
+	}
+
 	caldone = (caldone >> PHYCTRL_CALDONE_SHIFT) & PHYCTRL_CALDONE_MASK;
 	if (caldone != PHYCTRL_CALDONE_DONE) {
 		pr_err("rockchip_emmc_phy_power: caldone timeout.\n");
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
