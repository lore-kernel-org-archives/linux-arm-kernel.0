Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB311C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:20:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E672070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JvyKoOJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E672070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LPw/vK2rk33BSfWIiQ3ZIqjlh1FkIXlRBY8caLPSJS0=; b=Jvy
	KoOJWzLtjo5d3lrcY53Op81Man/hp0YQJqSm8bYynyZ2nQM9HZZD3xpNL/GqlVmLWu/5rcG1O1qV9
	K1SLM1kRTEoHT+W6/sn2VWil/52h3e62Dw8jGntM5H6NRLokBF9YH+jDhL4Vkhee3VO6V6eFeeqC6
	z/JHPEMNHm322bCxf4r20qBd89r2OxtBYY5CcwEw+nn6SYxnKI2HP0sJfC0llqnFd3R6Z5jh8jPJa
	lXYNR9o2lsBOvyj3zxAxclLCZP+QbM4QxCVbcM1IyOM4p6ZN+taXjQNlOvcLC2LvLe9cGkXCrMJfY
	2ok/fwaxpWTp0IdM6YYG1rPoF2DqBjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh8AY-00080g-0n; Wed, 09 Jan 2019 07:20:54 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh8AU-0007zy-9n; Wed, 09 Jan 2019 07:20:52 +0000
Received: from localhost.localdomain ([91.14.66.43]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkPBT-1hIg2h256J-00cQgu; Wed, 09
 Jan 2019 08:20:36 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Felix Fietkau <nbd@openwrt.org>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@kernel.org>, Nelson Chang <nelson.chang@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: ethernet: mediatek: fix warning in phy_start_aneg
Date: Wed,  9 Jan 2019 08:20:28 +0100
Message-Id: <20190109072028.30513-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:X+P9n7+dcvzK4YEKYgfFG/89inj71IR6H+vjVSkqCAbooF7BlZ1
 u+VGp9EzbeDTXEkcP+8Z+eRJ2vKXfKsjXjFq6/538owkPh/mJstAsoyuQ+xyUJOytocirQZ
 zbwsCbc2ATauJwY08+xX7V/oAl3lOH5LFvENzkuJOimLFC9pw5Egp5Zfw4FSb0niazSxwSX
 9XnafNcNo5TzMYQejDA7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALF7/w3xXiI=:jXgG056ilDrDU7D5FXL+Al
 ebmRyHXTSLgfzatDIfV3qbj6GUQp3NZL1ZbICQWzlG3JJYRxa942EYu33zlQZwb6opS8wSoS3
 ZJTMhGXGfFGFOAac+77EEmMbyv9sFPyIJEhu4kNwNf+mWXwZ0rLE398s1lNRfj1Qwmjjj8M4r
 i9R1wJ2Ah5KsODIgLL2tVSTpXb+v8g6BanozW6c1UVgG3MMdcoP5k1WkwyX3tnWKIsLUTavn4
 FLLuUnUFkw0wxcY/3Neyi45YcTp3UcUheNPfA8VbtDmFxg6Ohang7C7lbrxmUccUvBvKW7rSI
 akYiuu1fdAGELTIAqBeO10Orj1R7xgaIlPMOBnMGhradDeeQ0jCoFdhJd2ji1tM6V+s5p7O6b
 5fL6mFc3rBsfrAxblZhZ8KilqnRpQ76Cuql4mODEuuQm+V4KEqf+a1vAM+jCVefVMoCP6knU5
 5cZpvdXLhQcyEOn2iOMfaDCvFtE0im3wc0gfvGW/499cH7nV771oichMJVm0kXzefYgA2IOTE
 P3wFnDxa7sCI5vmHMXVkuHeJ7+KLgSjcLLJuzlgqxTVan5vyzYRKRdAkKciviCKqSX8wobpLk
 a+6NzUXGNKIZRcz/uyNGIlhKh0b/GTByzgJaZK3jeVx9RNiMyYAImVg88V07AEw+r9AxHEfA5
 QxCv+zgyMlYX+44kt3MWT/Tfn3sxxHSNXidFeSJn47CstQgdr6ouOx99iPHv/qjHVagFfUfzK
 yS9tAmhjUOyJ3EwCnGm6smx1ggh2OGepsi2T/FbIpzD3h3CwB/xSD+uGzKYrc4ylF9qa8vlsZ
 X3V2EZBbOUcdgpZSg246X/g7fo8tS9DwMy25B+9uFoMwmJj8SyOvHZIRnPYQ4AE2DCVxD2WUq
 Uy40dUJ29iTInC/s6vdFbG9/wsx95lkQhZoHhW+1MHS9rf6M/sp4lJSzqyBKy7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_232050_640642_3F05A9ED 
X-CRM114-Status: UNSURE (   9.79  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Heiner Kallweit <hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Heiner Kallweit <hkallweit1@gmail.com>

linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:

[ 5.170597] WARNING: CPU: 3 PID: 1 at drivers/net/phy/phy.c:548 phy_start_aneg+0x110/0x144
[ 5.178826] called from state READY
....
[ 5.264111] [<c0629fd4>] (phy_start_aneg) from [<c0e3e720>] (mtk_init+0x414/0x47c)
[ 5.271630] r7:df5f5eec r6:c0f08c48 r5:00000000 r4:dea67800
[ 5.277256] [<c0e3e30c>] (mtk_init) from [<c07dabbc>] (register_netdevice+0x98/0x51c)
[ 5.285035] r8:00000000 r7:00000000 r6:c0f97080 r5:c0f08c48 r4:dea67800
[ 5.291693] [<c07dab24>] (register_netdevice) from [<c07db06c>] (register_netdev+0x2c/0x44)
[ 5.299989] r8:00000000 r7:dea2e608 r6:deacea00 r5:dea2e604 r4:dea67800
[ 5.306646] [<c07db040>] (register_netdev) from [<c06326d8>] (mtk_probe+0x668/0x7ac)
[ 5.314336] r5:dea2e604 r4:dea2e040
[ 5.317890] [<c0632070>] (mtk_probe) from [<c05a78fc>] (platform_drv_probe+0x58/0xa8)
[ 5.325670] r10:c0f86bac r9:00000000 r8:c0fbe578 r7:00000000 r6:c0f86bac r5:00000000
[ 5.333445] r4:deacea10
[ 5.335963] [<c05a78a4>] (platform_drv_probe) from [<c05a5248>] (really_probe+0x2d8/0x424)

maybe other boards using this generic driver are affected

v2:
optimization:

- phy_set_max_speed() is only needed if you want to reduce the
  max speed, typically if the PHY supports 1Gbps but the MAC
  supports 100Mbps only.

- The pause parameters are autonegotiated. Except you have a specific
  need you normally don't need to manually fiddle with this.

- phy_start_aneg() is called implicitly by the phylib state machine,
  you shouldn't call it manually except you have a good excuse.

- netif_carrier_on/netif_carrier_off in mtk_phy_link_adjust() isn't
  needed. It's done by phy_link_change() in phylib.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 399f565dd85a..2968d29a992f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -258,11 +258,6 @@ static void mtk_phy_link_adjust(struct net_device *dev)
 
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 
-	if (dev->phydev->link)
-		netif_carrier_on(dev);
-	else
-		netif_carrier_off(dev);
-
 	if (!of_phy_is_fixed_link(mac->of_node))
 		phy_print_status(dev->phydev);
 }
@@ -347,17 +342,6 @@ static int mtk_phy_connect(struct net_device *dev)
 	if (mtk_phy_connect_node(eth, mac, np))
 		goto err_phy;
 
-	dev->phydev->autoneg = AUTONEG_ENABLE;
-	dev->phydev->speed = 0;
-	dev->phydev->duplex = 0;
-
-	phy_set_max_speed(dev->phydev, SPEED_1000);
-	phy_support_asym_pause(dev->phydev);
-	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-			 dev->phydev->advertising);
-	phy_start_aneg(dev->phydev);
-
 	of_node_put(np);
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
