Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639CBC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373BA20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n1sHwExm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373BA20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZmUcF6J0PkCe3epI1WVLirXujhQdmh4quIGGGqromHk=; b=n1sHwExmN7qgoNtbzwda8lwPvB
	dUXCC9Ow/IRfWQ0HamcjyFmlN9xTD3EOOPzM96L/LANKL8WadsuJagGwlThEe2066dng2qmkufnFm
	Smp6S78AsiJuWD4Y5UsBQGS1Dp8TTn6kfgjFlLc67HIsD3IV01Sc3hkixECBAjw0BCJg6xWQktdrQ
	7dWbFUdx0qNp8auFAyEPAcBWpOzJoB0vP8jyP724SiPahzv2yjUXhwex8UPSaHii8VKRzx9HBFSng
	6jFI7mRaGB9BFs9MZl+6wFqThoZ8QlzS4xfoMgqRBYEJLQIvMZnBQaNncoOL9MqLGwWqNAhRplaRR
	VovkeWqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnnK-0000TX-5h; Tue, 11 Dec 2018 19:34:14 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnnG-0000RX-61; Tue, 11 Dec 2018 19:34:12 +0000
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWo2-1ghIBO0hd8-00ATwi; Tue, 11
 Dec 2018 20:33:40 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 7/7] [DSA] mt7530 add linking to mdio
Date: Tue, 11 Dec 2018 20:33:14 +0100
Message-Id: <20181211193314.10695-7-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:/kdyN1LlQRxSXve23iYRsooYQC7XQPE+MLFtGKmyRq6aCx7CaWF
 FFL6X0ozaLhzOaPZ3eJCcfEwGzk3S1V9Zo7ZboAQYEsgKPf/nwlEUPzIFwssc85YdjqdhTI
 JKif1PECzon/COVE/8r0ICX+VLuqtLg/NrMAjNUUUXjJYgNy+taT3P8yofBNTQR2Luwut+W
 6g7qSqdsx6j994w1a/V7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZLol5aRfGU=:S/NLkB66pQ1JpOSRV6VaBg
 mZQkqCMr6AAsAqw8AIO3kNQaYc87G8ISC9zFztrd+Bu3WyotEIEsqPfUgJVr0IauWbYS+yKSx
 5o7FC09dWNdbHkP2JZFwkb2T2Fqe2wHrIUPGcqtNve2lf3Tm75Tt+WXVBH0L0yu6qe9E4Q0an
 okgJVM74knJ8iScSOW6jRYHr0zpoiWW8UYpg1ITvVrXLpFMlJtwxvu+jVYxvIN/IEOgaR3hw4
 4wxrNRCQu56Ozu2vdvpkOa7A9P7GHkp7jDAwubgdYihOQ9BFJsqYRFAy9FIY5mPWi6ZeUiQOY
 H+2DfHacy+/KH2fZXUW/THAHBvCMTQ6jYuyCmSgBuwj7nCR8peeVUF3YtwZkWJIxG/xnX/KTS
 TKA18J+NcPRiaJuM4anQl/mf8MZ+F6/BwcT4OEOuo8MR0bh4LmWEaSSx1ZTE4WGVMWW4F1Adp
 /irA6jNdSJ3i8Z2gShraycWxAKhDV/QCL97v2mAjkmqHFOi6+Fv5ZuXV2y8/zPmSK6Xun6eMA
 tZTEXa8SduPQlvTOiqp6aF6MR1yd05sU0ZgM8jnzB5R8k5ogvEh6/2fIKyWWHYjlkluu98SvP
 eJ2VF64PEhqmi4XyQrXlbH+i+xIsHMIzVD9/EDeKeu/mo1Y0kDsPJkrpzuIzKZRDkn+d1ylwO
 KrKMLXmd0qCJWoaGbbhNoQ1ODOv+P8NtuGM/B0CsoETcPKXv5hatDqday83Bh1xuamBa4hy+v
 jMTUXAKD9lq+gGyzuQUggVXk5HG24S03kKlOewFXCRvVj+ErxHaHh1YBJ9FbwaY0DFyB6wqK9
 fHjM8FJiTY61DPAMDTA82uS3LaOb0D1bf4EHB4A88+e1Nc4iM6WlGlRQAjfas7AGAOkyN8eUI
 2HmbsWyYREDqIS90ZVBb4UIoA9nqMg8SBLkwOPO4LB8aXjIlfjpM03JTE+/FJ1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113410_526237_2E7503E5 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0045-net-dsa-mediatek-turn-into-platform-driver.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 83669f53cb36..e529bc334459 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1345,7 +1345,7 @@ static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
 	struct mt7530_priv *priv;
-	struct device_node *dn;
+	struct device_node *dn, *mdio;
 
 	dn = mdiodev->dev.of_node;
 
@@ -1392,8 +1392,14 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->reset);
 		}
 	}
+	mdio = of_get_parent(dn);
+	if (!mdio)
+		return -EINVAL;
+
+	priv->bus = of_mdio_find_bus(mdio);
+	if (!priv->bus)
+		return -EPROBE_DEFER;
 
-	priv->bus = mdiodev->bus;
 	priv->dev = &mdiodev->dev;
 	priv->ds->priv = priv;
 	priv->ds->ops = &mt7530_switch_ops;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
