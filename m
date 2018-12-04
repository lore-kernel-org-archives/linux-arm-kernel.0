Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9421206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C7W1R5Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9421206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Dl5jSZ1s22maaDo+uBzgFYlgQk6DgjwEgb+hkAAP8Q=; b=C7W1R5Rmv4zxJy
	gQAUWWphFoe+pOkNJZHOQUheTyRZmjQxAi+TYCeykgD7e6qjrEwbwiFeRmhiKabGdzYWsgpaNdmSw
	tyQu88qmQ5DiRiJq1X2Fj7LikT1r441QSkpXdYuJjsm27627dxUhCNr1nW0Bn820zHEu+A4jeVkOI
	mAeJp7V7+Z6/X2yuB55pzcqYL6ozuQ5GqQ8EMpgDOOkMpA42yAwCvzNlS2fzhKxz9b/zMTR6tV6/8
	NhwZEHrOcgs+/hxr0nXZuPuI3xcZgqQ1OUhkNJGkKpQbSoOKJGkbE+Xi3cav9siaCmpiPvPaKx2WZ
	3d6i2r1DoGrAKP45sNEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGNO-0000Ld-Gg; Tue, 04 Dec 2018 19:28:58 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGNK-0000K5-Vl
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:28:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7D4392074D; Tue,  4 Dec 2018 20:28:45 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 855DC207B0;
 Tue,  4 Dec 2018 20:28:34 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/7] ata: ahci: mvebu: remove stale comment
Date: Tue,  4 Dec 2018 20:28:26 +0100
Message-Id: <20181204192831.12440-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204192831.12440-1-miquel.raynal@bootlin.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112855_165448_B55BCD51 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For Armada-38x (32-bit) SoCs, PM platform support has been added since:
commit 32f9494c9dfd ("ARM: mvebu: prepare pm-board.c for the
                      introduction of Armada 38x support")
commit 3cbd6a6ca81c ("ARM: mvebu: Add standby support")

For Armada 64-bit SoCs, like the A3700 also using this AHCI driver, PM
platform support has always existed.

There are even suspend/resume hooks in this driver since:
commit d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")

Remove the stale comment at the end of this driver stating that all
the above does not exist yet.

Fixes: d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f9cb51be38eb..128d6f22926d 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -197,11 +197,6 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 
-/*
- * We currently don't provide power management related operations,
- * since there is no suspend/resume support at the platform level for
- * Armada 38x for the moment.
- */
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
 	.remove = ata_platform_remove_one,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
