Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BBC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64258218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGZISCw8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="d3k2FBGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64258218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=hnnKJhECtdGuPFLAyYPT0qlPhRdAhTCC/EVaeQ7QJIg=; b=CGZ
	ISCw8DaH42It9j6b6C1D1UBCOJJJkvVNYPI0OMos/g2xvO45qqXx9X15Khm7SBUpsY/bK85E4oSbx
	eyFpdn3C9b7hEImpEdWNLfo2V7iepXa1oHa+XadkRNwqNBex/hEWIpVTSfnv0sBEkLuSwj8h7qWSo
	6wC4Jv6RbpiQT18UpcMJCcW/YaTIPli13o53s+ret78Cdjet4PQiWsAMueBgYbtXlgJ/ckNMMeU5p
	UJqrrq7SfCpOatZwJQZUxGrILx3SGEbyxDmMcQG+xirVtwTVY7+T/fRswxoRjWyAmshMpDFiH30bd
	Bf7DuRRwKEY2deAAAs+KElNtKGMn1tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grCnD-0005yC-22; Wed, 06 Feb 2019 02:18:27 +0000
Received: from mx5.ucr.edu ([138.23.62.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grCnA-0005xo-3l
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 02:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549419504; x=1580955504;
 h=from:to:cc:subject:date:message-id;
 bh=D0JGImJ9qrSJZ/loF6Jscsoui2BmjSV1/GLZh7cocuo=;
 b=d3k2FBGkmPiAOIIzNYggWLY7gKQOVzmLY4cc2yfeT1/eBFcTs6WrNze6
 BOMSeK3c4OmeeOre3Bs30AaxUnhwUp8xzXV533StXTtHzwMjuleWMjXX9
 kHpS3Qm1dxs9hqC6ZOAVlol4zGasdRbv2PPKLylfH6GdcJthZaFdn0+Gi
 BnqOTMERQ+XOUs6/N1L7SERF7h/QSMsXccoeHkgEcb1637DgtXrQRQK67
 oVzIe5g2gwEIHl2VxzOb1g3jFKWD4TfP/7WWiduiw1QPO6hH8Im4aDXQo
 Eg/+WVm822P6urOpwMgghdEOZBFc+DmgVSX0OpNFwr4owMELzs6bf7T20 Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AmWQ7yxXlaZrjdo6Dg2nhejHk+XPV8LGtZVwlr6E/?=
 =?us-ascii?q?grcLSJyIuqrYYx2Pt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUBEEjc?=
 =?us-ascii?q?hE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRo?=
 =?us-ascii?q?LerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21hbHuGZDdf?=
 =?us-ascii?q?5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2Ao/8LrrgXM?=
 =?us-ascii?q?TRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5KpwVhTmlD?=
 =?us-ascii?q?kIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94aQGtBXt1KVyxABIO8?=
 =?us-ascii?q?YJYEAfQYM+1FoYn9pkUBrR+jCgKxAO/ixCNEinrw0KYn0eouDBvG0RQgEdwQrX?=
 =?us-ascii?q?raotb7OqAJXOyp0KXF1ynPYulK1Tvh7oXDbxAvoeuLXbJ1acfey0gvFgLFjlWN?=
 =?us-ascii?q?rozuIjSY1+QMsmib9eVgVP6jh3Ippgxqvzig2t0shpPXiY0I11DJ7CN0y5s2K9?=
 =?us-ascii?q?2gUEN3f8KoHZ9KuyyZN4Z6WN0uT3x0tCog17ELvZ22cDAXxJkmwxPTceKLfoaI?=
 =?us-ascii?q?7x75SuqcIC10iXBqdb+5mh2861KvyvfmWcmxyFtKqy1FncTSuX0VzBzT79SHSu?=
 =?us-ascii?q?N6/ke8xTaDzwDT5f9AIUAzjafbLoQuwr80lpYKqUTDEDL6lFz4jKOLckgp+fKk?=
 =?us-ascii?q?6+vgYrXhqZ+cM5F7hhviPaQpn8yzGeU4Mg4QUGiH4emwyqHv8EnjTLhJjvA6iL?=
 =?us-ascii?q?fVvI3GKcgBu6K0BwxY3p4m6xmlDjem1NoYnWMALFJAYB+Gj4noO1HUL/D5Efuz?=
 =?us-ascii?q?n1qhnSx2x//aJL3tGIvCIWXekLv5Z7Zy91ZcyBYvzdBY/59UDrABIPTuWk7+rd?=
 =?us-ascii?q?DXFAU5Mwmtz+bkFtp9zIUeVnyLAqKCNKPSsESI5v40I+WWZY8Vvjj9K+I/6PHz?=
 =?us-ascii?q?k3A2g0IScbOu3ZsNZ3DrVtp8JEDMUHv+gsoGWTMbrAo3TbSy03WfWiQVanqvCf?=
 =?us-ascii?q?FvrgonAZ6rWN+QDrumh6aMiWLkRpA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BsAABeQ1pcf8bSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUwUBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI2Bw0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJCwsIGwwxgjopgl82UlY/AQUBNVuCRwGBdA0FoQw8jBczi?=
 =?us-ascii?q?GMBB4FLCQEIh3CEQYEPgQeDboR/g1SCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM?=
 =?us-ascii?q?2hwCIFAEtmz0CBAIEBQIFDyGBLAaCAU0lgWwKgUSCUo4sHjOBB4smgk0B?=
X-IPAS-Result: =?us-ascii?q?A2BsAABeQ1pcf8bSVdFlHAEBAQQBAQcEAQGBUwUBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI2Bw0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJCwsIGwwxgjopgl82UlY/AQUBNVuCRwGBdA0FoQw8jBcziGMBB4FLCQEIh3C?=
 =?us-ascii?q?EQYEPgQeDboR/g1SCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwCIFAEtmz0CB?=
 =?us-ascii?q?AIEBQIFDyGBLAaCAU0lgWwKgUSCUo4sHjOBB4smgk0B?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; d="scan'208";a="26847862"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
 by smtpmx5.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 18:18:23 -0800
Received: by mail-pf1-f198.google.com with SMTP id f69so4126153pff.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 18:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vKCJp8IORvIsHrDyUZajuZHeMiJCJviDrMcOZ6kuFfg=;
 b=JrUtPW69dTpumegmatVb2SzwUCw7SE9Fyco9dfP41m34IxYavLRk2wMxdhtqHYajot
 Lm4IZgM0Hakul9LaOb2TOE7tBo49X9oJ4aoEzfmPpA2EjsJE3/Z3Axs5Kcci+1IAa8Nm
 CIpg25AzRV529W1XjAMB0oTVyKDQR8Hki3zsuNs+ZTVZDoEM0J/8sBAWSxe4wSi8QqhY
 7lCRXn+oXfee67L5YqaFfVhUgLAVo4f08F/h48f4FkFCvX3l4hS/QtETzdZniZe6I0+E
 Zn/kk877illvVONhNhuUuXVwpW63DJCtvITPhHLfP1pnMQoWcrqrfumUlPwA9Bk/DU+8
 aWtQ==
X-Gm-Message-State: AHQUAuaKowWNLm2lxWmTLBvYKnIGx+l2+z1HiIwuq6k5/73TqISJ3AUO
 L9aVsjOb83TtGBH+wJEPxlG4bpdFsnZv5ohlddPgHp+Kupc6A/8x9PJKOCzVwaI/Jio83SqjusQ
 Dwl9gyR4lRkz2KFF76+DqyYWntIuDV4D52dET
X-Received: by 2002:a62:2f06:: with SMTP id v6mr8215638pfv.216.1549419502693; 
 Tue, 05 Feb 2019 18:18:22 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZX1CcpPLb8Db6nC9eW9nN5ZiP7BmEjOoo6MOm0zKDcy9yHAdu7iX0RDp7j7avOaFBbWl3AZw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr8215626pfv.216.1549419502430; 
 Tue, 05 Feb 2019 18:18:22 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id a13sm4893878pgq.65.2019.02.05.18.18.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 18:18:21 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] phy: rockchip-typec: Variable "val" of function
 rockchip_usb3_phy_power_on() could be uninitialized
Date: Tue,  5 Feb 2019 18:18:10 -0800
Message-Id: <20190206021810.21596-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_181824_182917_52396C0F 
X-CRM114-Status: GOOD (  13.94  )
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

In function rockchip_usb3_phy_power_on(), local variable
"val" could be uninitialized if function regmap_read()
returns -EINVAL. However, this value is directly used in
later context. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index a958c9bced01..b1e24418cb2d 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -716,7 +716,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 
 	/* wait TCPHY for pipe ready */
 	for (timeout = 0; timeout < 100; timeout++) {
-		regmap_read(tcphy->grf_regs, reg->offset, &val);
+		ret = regmap_read(tcphy->grf_regs, reg->offset, &val);
+		if (ret)
+			goto unlock_ret;
+
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
 			goto unlock_ret;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
