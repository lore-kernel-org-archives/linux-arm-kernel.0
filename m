Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438D7206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ue93c3Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D7206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KjhjMrkMOfSfe1iuwFZpGOscsCrr9PwguxAF0w1UPX8=; b=ue93c3Km9X7nos
	dsDypfUm9bWopsldP2+AMso/TIDSoaqWvkD0KROTB6ct2kNNlTYVxafUGHI/nq+Z/gAsH4QS/5FZ8
	B5aSW7fEbMGocVFUvu93ZW3sebXESNN+lkQQU37W0FK7SwQ4dlvNVUDguZ+j/v3G24JT3evlfA0+n
	+HTpajGt5z+e+Ibja1t9ci3+IuWizq8xGeuvF4Ar4tEr8nEPWhNyxbg0p5PMbeYNplW2gknFOYy43
	Dhl+vx2g8es4VFOBA7VS0t1Pckg0DVJEo8blQvPXLdomEmWzSKtOGH1J8pmOTb8wvg4b9lIt4pyDY
	SgOeK3KzohGhBtVrg/bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5zR-0003P0-0W; Thu, 03 Jan 2019 16:37:01 +0000
Received: from avasout03.plus.net ([84.93.230.244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5zN-0003Mz-K6
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 16:36:59 +0000
Received: from localhost.localdomain ([87.112.196.180]) by smtp with ESMTPA
 id f5yHgSh7KimnMf5yfgALWW; Thu, 03 Jan 2019 16:36:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CoqRjEwD c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17
 a=08VI1bL2Rn6wF1MGSkkA:9 a=HBl-pWRkaHKTX-Y4:21 a=MtzrMieHWah2KP3q:21
X-AUTH: davidjohnsummers@:2500
From: David Summers <beagleboard@davidjohnsummers.uk>
To: marcel@holtmann.org, johan.hedberg@gmail.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCHv2] Patch to add the realtek bluetooth device tree refs to the
 code
Date: Thu,  3 Jan 2019 16:35:38 +0000
Message-Id: <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfKp/Fej6mjPKswONZyC4agicIrTZ9nByZ4b6fOHvjpnJPaROuNW62pluqWf7VT/n7mQZXCP0YKtCyxnzIHjfGf9IWY3t34ro/cZ7wyUnA54Dz3QJvIfg
 +8ohX7zCBRdhIWDTtJBzC13ujYW+bMtlPGJWukFGz5q1XpdgaOArFv8Kq/h+otHObMqBCFQeEqR2Mw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_083657_799835_D73636BD 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: linux-bluetooth@vger.kernel.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the necessary device tree hooks to the realtek
bluetooth driver for serial connections.

The realtek devices that are listed btrtl.c are searched on the
realtek web site for the version that have serial connections.

Most of these devices also have wi-fi connected via sdio, that is not
covered by the bluetooth driver - but as that interface will also be
needed in the device tree, the hocks here have "-bluetooth" added. The
exception to this is the rtl8761atv, which only has a serial
bluetooth.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..2fec7ff2ce7c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+       { .compatible = "realtek,rtl8723as-bluetooth"},
+       { .compatible = "realtek,rtl8723bs-bluetooth"},
+       { .compatible = "realtek,rtl8723ds-bluetooth"},
+       { .compatible = "realtek,rtl8761atv"},
+       { .compatible = "realtek,rtl8821as-bluetooth"},
+       { .compatible = "realtek,rtl8821cs-bluetooth"},
+       { .compatible = "realtek,rtl8822bs-bluetooth"},
+#endif
+       { }
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-- 
beagleboard@davidjohnsummers.uk


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
