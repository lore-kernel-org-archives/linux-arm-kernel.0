Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638F9217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JR+Ql2ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638F9217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4XIBYIpJZnmmUdCHjTFFAzBc/zvwkZtCKtHoKQVLF5c=; b=JR+Ql2ckKRMoTB
	rxSTP40f7b312rZvsLRuL23n/I99gvYADuZ+5QHzotWH/WQ9OdloVu8hshS/gecoajKDismhC3b/S
	KFj+bCyXp7hQFQ6lJs56fQkN8JHiddH68qgnhw9hZ3D3F+yak0Ueli5zQgeK+3j9dUeB8HS85a9yG
	Y65TvanuPOe3phwBN4vDD9LT9cGnDe0e1T9wZc3IvC55FalBYANcjOjmUyniGfp+IWZTpwbeWK2M3
	cSG2GXSmNHfU6hI440w/HXjjD5uaYqa3ReNIm80vsMu+4bkl5ntvnuRL+WSm6X8vVssaqWsPDJ/WE
	EPPgMoIqj9QBpAVBI6ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdDEK-0001La-BQ; Sat, 29 Dec 2018 11:56:36 +0000
Received: from avasout02.plus.net ([212.159.14.17])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdDEH-00019l-4S
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 11:56:34 +0000
Received: from localhost.localdomain ([87.112.196.180]) by smtp with ESMTPA
 id dDDAgftdex6b6dDDLgdY8I; Sat, 29 Dec 2018 11:55:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=T4GiscCQ c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17
 a=sjixkyzJrpERljILJL8A:9 a=CutxRP_YRTV_cuNQ:21 a=L3cMPTktaLIlAMl3:21
X-AUTH: davidjohnsummers@:2500
From: David Summers <beagleboard@davidjohnsummers.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] bluetooth: realtek: devicetree: Add device tree description
 to bluetooth rtl drivers
Date: Sat, 29 Dec 2018 11:55:13 +0000
Message-Id: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfGWpfgDJGq/6Z5PCdvCotcAdq6D36LMqkjmgO9tSI/Merg8Tr39DLUW5/8RjSw33DUOtMFgKPdQNufLbw1eTC1cFvXNt9YeT5NpU0QF0tIiC6XuqPInT
 +HLpzIWGUGiZuNsDvA3oCx9JiFyVMt1xzez8XVidsi6ROocCjqrgFYNB/Inl8Icgq2wW7n5oF/j7Pmkc7pX3/t2lq2Clrg8vRmQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_035633_321278_64092C84 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: mark.rutland@arm.com, Johan Hedberg <johan.hedberg@gmail.com>,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-bluetooth@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch add the relevent device tree handles to the bluetooth driver
for serial realtek devices.

Specifically it takes all devices listed in btrtk.c identifes from the
realtek web site which are serial devices (this invariably means
devices that end with and "s" in the device name).

Most of these devices are dual wifi and bluetooth, with wifi on and
sdio connection, and bluetooth on a serial uart. As these two
interfaces will need independent listings in the device tree, the
nodes here have "-bluetooth" added. The only exception is the
rtl8761atv device, which is bluetooth only - and only has a uart
interface.

Can devicetree people revive the naming scheme used here, and confirm
it is acceptable.

Marcel, if the device tree people are happy can you apply to the
bluetooth tree.

Thanks,

David.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/hci_h5.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..61c9e729efc1 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,20 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+       { .compatible = "realtek,rtl8723as-bluetoooth"},
+       { .compatible = "realtek,rtl8723bs-bluetoooth"},
+       { .compatible = "realtek,rtl8723ds-bluetoooth"},
+       { .compatible = "realtek,rtl8761atv"},
+       { .compatible = "realtek,rtl8821as-bluetoooth"},
+       { .compatible = "realtek,rtl8821cs-bluetoooth"},
+       { .compatible = "realtek,rtl8822bs-bluetoooth"},
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
