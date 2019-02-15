Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CB82190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C56ReU0A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/r6eql2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CB82190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r0rL/OqMMT6U+cCvXMyfwmU3Xn3otmIRWgk+HIqaQp0=; b=C56ReU0AIYr915
	ilUpH6FwcqxouJaHrdio5FbLTM32837jHsIxsEKR+urZmml5IcoW7XepWV/IrP/vF6SaP25/r0r59
	GZD1UJFqU9zhQcQLUuikE8f4hDxQt4bAgoNNBHVLxri4inYZU8zfXLrgorqKp6TY4bTPF5KtDxjvD
	gzSQS9m3p+MMeBnsIFkY/EdAXTMB7++KztpxkAvVYrvoD5GxvgXH0+0g/HVk1UM51YLvAQKD+m2kv
	LsbyF2MGrMny5LhdYbmU/xRBySncYlmv8PFk0uWVuPvP6ZDj2kQQ5RPRjjrWUc/3xQ5HYzYjPgaUU
	Z5poolPLmJwmzF+XeYWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugQW-00047J-EY; Fri, 15 Feb 2019 16:33:24 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugQJ-0003tU-G2
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 16:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OTYgW5u2+VU9l3HeysFJRPGEzfmY+/8F4kccNf3fORA=; b=M/r6eql2K5sC85kML06fJbgFxM
 IBW4gRCmfFDjH5v69VXlc5y5IcF/1Ug6fYM46qsSI8iYpx4fYp5F/eYnTaijNWcQmET/FWWa/3dPk
 vYPjIj+jz40Wh3dMwXi4Wcx9NGW1blurH8YhdYBGTFe+lP/pzJCDMYn6cS0MO2n9JcijPp3rdd+JG
 x3YqymvCE9UuXwZpu630MJ964tzjx+osQWzX85H2ajKuWwuoGUS4UJEXtBWS8TPor2EDxsIGPuLGT
 ylmhLECn0g9puxeOsx+9EtFeOvCvJc94aMIhAPHz1EYqH14BG9Z9rjzmuUpPj4oqWFctogxyAwyf4
 g6MHtpBw==;
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugQG-0002QR-Lh
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:33:10 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 69853FF80F;
 Fri, 15 Feb 2019 16:32:38 +0000 (UTC)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY status
 read
Date: Fri, 15 Feb 2019 17:32:20 +0100
Message-Id: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_163308_751031_714F14AF 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some PHY drivers like the generic one do not provide a read_status
callback on their own but rely on genphy_read_status being called
directly.

With the current code, this results in a NULL function pointer call.
Call genphy_read_status instead when there is no specific callback.

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
Added Fixes tag and net label for resend.

 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 74a8782313cf..bd6084e315de 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	u16 val = 0;
 	int err;
 
-	err = priv->phy_drv->read_status(phydev);
+	if (priv->phy_drv->read_status)
+		err = priv->phy_drv->read_status(phydev);
+	else
+		err = genphy_read_status(phydev);
 	if (err < 0)
 		return err;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
