Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:26:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7CF20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="olOoNaU9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=araneo.si header.i=@araneo.si header.b="aTEaHLeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7CF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=araneo.si
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LvORw0xQcV2VKKdwP65xzVOs0VbSIeioSZ8lhJOoXwY=; b=olOoNaU9BN1BM3
	yVepPbkJ+9XXCVEWHnaQC9JLBY0NsjVy/xT/8A+PUaD2D3FxYVQXz7VOWhlYxWmc/0IQcOS9bCs6U
	Y3cs/XZ6flngJRXl8GuwMuZb+r8fl3W4c7t+Pl07ZsMw+7FF1mllC4R0p/0NBie90LNRXU31Imxlz
	p4NxCy18wik25QbXuTLBtAv6rkT/jI28EMg1++W7nJSG6lK2eyeJ+QJ9EP8m6lgYodkKn7ZOHiRZd
	g70RXnVObafG5n1r3a2OY2C9Ww8o2RQxw4NFso8HxIgZfZO0+RHi25gSNUz2uOvsjFRAk6NisY+Ot
	sRbRxtOsHSbbSkWDvy0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giTbi-0001jz-FD; Sun, 13 Jan 2019 00:26:30 +0000
Received: from bsn-77-101-244.static.siol.net ([193.77.101.244] helo=araneo.si)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giTbc-0001iV-Oe; Sun, 13 Jan 2019 00:26:27 +0000
Received: from araneo.si (localhost.lan [127.0.0.1])
 by araneo.si (OpenSMTPD) with ESMTP id b0aeee70;
 Sun, 13 Jan 2019 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=araneo.si; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=20180623; bh=WYcNJzRkBf9RHhM51jGxPIUl8eY=; b=aTEaHLeOvRzZa6Ub
 HXoBN6O4i7lDaWY0sSZaH+q9N/sNrKv46ZvtoWqosP0VZRFu0bk2n5dPH3El3EO6
 AWW4Yky1ej87I4hBD7Ht1GkfAfJm3JnYSOEVJti07gxD6DCKW893SJrw7ZK1juz6
 GFV/FVJtDKn3hBLrZ+99OeH7e0hQ1CoPEzhSAwEpYRcVprwjZr4XceAuDAVcEjnP
 hJKyKGTNLY7qWeweRjhIRUzIu6IzXoGtX52gIBRSO1ee/bUYqWxLkHYQgyWRehy0
 DJrmktcY1DJTccKQk772+eHyZqfETF/NwFzenIFwrgvkzsVVNqanrgoJBavZsr/j
 RScdoQ==
Received: by araneo.si (OpenSMTPD) with ESMTPSA id 25b476e9
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Sun, 13 Jan 2019 00:26:07 +0000 (UTC)
From: Timotej Lazar <timotej.lazar@araneo.si>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net] net: phy: meson-gxl: Use the genphy_soft_reset callback
Date: Sun, 13 Jan 2019 01:22:55 +0100
Message-Id: <20190113002255.15310-1-timotej.lazar@araneo.si>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_162625_270941_6824C713 
X-CRM114-Status: UNSURE (   8.30  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Timotej Lazar <timotej.lazar@araneo.si>, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since the referenced commit, Ethernet fails to come up at boot on the
board meson-gxl-s905x-libretech-cc. Fix this by re-enabling the
genphy_soft_reset callback for the Amlogic Meson GXL PHY driver.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Timotej Lazar <timotej.lazar@araneo.si>
---
 drivers/net/phy/meson-gxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index b03bcf2c388a..3ddaf9595697 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -233,6 +233,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_IS_INTERNAL,
+		.soft_reset     = genphy_soft_reset,
 		.config_init	= meson_gxl_config_init,
 		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
