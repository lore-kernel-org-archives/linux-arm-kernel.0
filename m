Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:00:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDFD2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucDpQuSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDFD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=O5e54yv6kLyOLBzs1eaJryZeNb6L0kpMWAqtIlJFXWo=; b=ucD
	pQuSt/w/BdYh1ZdelwTo7NqPrQ1pN5t4tlRTVsoTu/mvCH300rzEjMKOSQwnoNJFBEbGrdRcT2okK
	NUfIVIOInBlnYz55v2Qv7miUtO6tB0elGst02MjHGgO0mqRkZtOlaBNBdObbNS2T022rzB44KubSi
	Ra2VGohHK7jh1Oy9u5Vols7kYTlwVADCCFNJtTRuKIJxt2zpgXAf1hlG4swuWSWY68RAMs2RaTmPM
	xm2CTHH8uo1ChtS1FOofrehvMg+f9vV3UanNrWCGoHNB3if5PESXQ3mew/woeu5I9omBJpbVkFawe
	TIcptXoZSi5xRSjcqEZZTMCH8AwShQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHnU-0007vb-TR; Tue, 04 Dec 2018 21:00:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHnR-0007uW-Gb
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:59:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2BB512074F; Tue,  4 Dec 2018 21:59:44 +0100 (CET)
Received: from localhost (pou84-1-88-186-186-126.fbx.proxad.net
 [88.186.186.126])
 by mail.bootlin.com (Postfix) with ESMTPSA id D67B320729;
 Tue,  4 Dec 2018 21:59:43 +0100 (CET)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: tony@atomide.com
Subject: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Date: Tue,  4 Dec 2018 21:59:01 +0100
Message-Id: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_125957_690847_F1717752 
X-CRM114-Status: UNSURE (   9.10  )
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
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 linux-omap@vger.kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for networking over USB device,
which allows boards such as the BeagleBoneBlack Wireless and
Pocket Beagle to boot on an NFS root filesystem. Such boards
have no Ethernet port.

This is for consistency with CONFIG_ROOT_NFS=y
which makes no sense if there is no networking.

Tested on BeagleBoneBlack Wireless and BeagleBoneBlack

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/arm/configs/omap2plus_defconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419b1dad..7e8a8ed028fd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -403,11 +403,11 @@ CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=m
-CONFIG_USB_MUSB_HDRC=m
-CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_TUSB6010=y
 CONFIG_USB_MUSB_OMAP2PLUS=m
 CONFIG_USB_MUSB_AM35X=m
-CONFIG_USB_MUSB_DSPS=m
+CONFIG_USB_MUSB_DSPS=y
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TUSB_OMAP_DMA=y
@@ -418,10 +418,10 @@ CONFIG_USB_SERIAL_SIMPLE=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
-CONFIG_NOP_USB_XCEIV=m
-CONFIG_AM335X_PHY_USB=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_TWL6030_USB=m
-CONFIG_USB_GADGET=m
+CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
@@ -442,6 +442,7 @@ CONFIG_USB_CONFIGFS_F_UAC1=y
 CONFIG_USB_CONFIGFS_F_UAC2=y
 CONFIG_USB_CONFIGFS_F_MIDI=y
 CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_ETH=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
