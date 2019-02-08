Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B03C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCB3206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLXt5cnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCB3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=np0YqZR4jfYJjpme3H9r1zck6vXhzQeEGCcSmyTBwdo=; b=eLXt5cnc20T/17qUk0B0vACdwD
	E113RU7qRWh0FaATcBYYElBkdpE3WTAA27zUbAMLuLruYvH+HB/U3Um4GFRXN+DXyl0Bq45pyJLLi
	iAin7V4Gh7ZHuau1ymP48rXyKEBfqQXFC1gBnc9KOOAzlDh+IZ9NaTa5hc3EaqtjhQK9undT+IqGG
	Q1cr1HUDJX0Sf9jkQ1VyUiTGI/Gi9f0Wckafu/OuDRTjiXlURlOAN3rGkkJdnzgN/yAE9fpZY7zdM
	4vb7JzWL93VQI7B8HROyxnmXwADsdE5uUPmO8PbvaZnRsYUd+1fWHkNf/D2iTklS4W+XPVg258p7H
	OUGAFw3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5A3-0004Cv-0a; Fri, 08 Feb 2019 12:21:39 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs59s-00044a-2h
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:21:29 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MtwlO-1h6SH40ZTw-00uIBT; Fri, 08 Feb 2019 13:21:18 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RESEND V3 1/2] pinctrl: bcm2835: declare pin config as generic
Date: Fri,  8 Feb 2019 13:21:12 +0100
Message-Id: <1549628473-4485-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549628473-4485-1-git-send-email-stefan.wahren@i2se.com>
References: <1549628473-4485-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:aG6w6q9G2UXSjev252HYWUBp5SyLBtNod/NOmJbXrJaKjOlW6OU
 QdPYmRsUT76lx1WIdjJfLcN7a9TtW8oa/IBuY0IoD2Hk45Ekw393F4/rZx/AI5H5CpkFYGZ
 Zsv85Ndpdf/LnX7OxDnEk2VVr+NoJic3xVnxB1sMLKT2gK1UOgw8Yc54ZwPKwLWcERjhgHF
 m7R9NqzVAGeNPImzwqjTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8/LdylsVJZ8=:7rnOZWNUB/kX8CYvmrv4+x
 AoNWc8rfGjllbqltNFEKq5McydnQWL6FSc8shm+eFFI/HzYyzmG+t6nfPtnAuOgQyAyCAQJmn
 kwCabNJAp7P6aI6laFtgh65g9m5Bmn0bK4JcAJFylUYGmdSslZ6jbYwLS8Pq6Uq/j3/uNL0nS
 IgiInyIH5LZ2PJgF53TcCVEkjAOs9PrFgoDC2Xa6KLQty6W8FOMJT4MioV9x+bAOcKPG2JCmY
 FZt+rWPz6A+zAQsyx4fdrR5Yhtr/b5sSxZDFAqxe80Ezhzv3d3OxBAWz3JHN4OVel3+Li5lmj
 thZgmgPkf15c9MzJhhUTAEOV7j1PPJl2AOb1mtYsOxX93awygY2pjdmnLmILTTe4kSoL5DKtN
 kLnp1RMCkeJpoaBGqsmwO2Xk2xrbb9BvWtA9GzWVGZf6t8CkJK+3lz1RH7xyZMNRHujf55Jgn
 u5pJq/Va3NvVyYC2Txto2C5MZmkFvEwpXg9Jqqq9ZqS8NOL299pvnLgJW/wEjYX1JRnzvM2tn
 mCLvutmmDqUVZQMLRWwQHWjEavGqnTIGmSP8Mcw54rF7Eq9uM6zydFtTLM0shekBZn17sjyPP
 1KDN/cxcXTEAnNrlb3F+M4PQRk7FqJ7wfhgwFc+ji13NQOdQknKkbuqMC7EzY76okAwYNKeit
 HC/d+DMVwW29aea/iy+0aV8DCL6hDsD0Ur9NDfJKe0O7z++c7cmFK4Wxx9Of4tWljp2hns+m0
 EIfvCBDrmnLLv46JuV4C4P16KSWAd/tzHkwKCH3NrM3dRvjOIJ186Oj13e8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042128_417940_B64F460B 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-gpio@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit 0de704955ee44 ("pinctrl: bcm2835: Add support for
generic pinctrl binding") this driver is capable to use the generic
interface. So declare this accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index f180aa4..19eb4fd 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -969,6 +969,7 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinconf_ops bcm2835_pinconf_ops = {
+	.is_generic = true,
 	.pin_config_get = bcm2835_pinconf_get,
 	.pin_config_set = bcm2835_pinconf_set,
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
