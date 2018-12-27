Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934ADC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E702214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ANJJ6FUM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="teKjecCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E702214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=meMCDqCgAYmjbrQcQY4/RFB8N+jRAgJr+dc2pVhE7JA=; b=ANJJ6FUMNg8hBC
	Yv3/mXpl5NnQpykvNMv/VaheAUBlGwidZpPUUDOB7rcYWCE4QhLgY+rI/WwoaI/vuqPDE6hdueozA
	fsXDS3CSYhkEPnEdwyHP8L6IzA9Dl+xNZh6Ob8Cjth5M08hLG0EhCnI/FrW0sYlotFeM2jCBdun3J
	SLQxkbTPu73Tr5WBZlDVHiHWXE4He/nev9Y3sRBUKXPndXhUSojXJJOsv6nKyzY/xOUSbtEbY2GFN
	7v/2n2Y6DcdK0/OpQWEwbWUpXPoRy6Y1AwrKeB0VLbVe8XZSYqWwXyJvXq3eqVL57W0s/cUAjoZpv
	eqtx6yFo+zPOc0JwYQTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOvk-00059Z-O6; Thu, 27 Dec 2018 06:14:04 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOvf-000589-3u
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:14:02 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6Dh4q027065;
 Thu, 27 Dec 2018 00:13:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545891223;
 bh=JtLuv5r/WkYlBZXMpTRzqAq+gi7BysBSUIUw78LzkRE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=teKjecCWzvbz5gL0m4TJxofjqMObFyCZ4MJfeXJT4spUtEm5A9g7nruuxUUxNHv3s
 la/Zu3z43k0zFZvU23wgyBmHdpRrcWcTjWamdKSzH55/ajMQY1bfFKZAgU9OW5VlXD
 rYcuJRBM/o7Nx4LfVcctUwJU0eoRVxdAYEpyogAk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6DhFR108472
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Dec 2018 00:13:43 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:13:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:13:42 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrA026064;
 Thu, 27 Dec 2018 00:13:39 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>
Subject: [PATCH v4 04/13] firmware: ti_sci: Add RM mapping table for am654
Date: Thu, 27 Dec 2018 11:43:04 +0530
Message-ID: <20181227061313.5451-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_221359_247445_7A0F3096 
X-CRM114-Status: GOOD (  16.58  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the resource mapping table for AM654 SoC as defined
in http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
Introduce a new compatible for AM654 "ti,am654-sci" for using
this resource map table.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
 drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index b56a02c10ae6..6f0cd31c1520 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
 
 Required properties:
 -------------------
-- compatible: should be "ti,k2g-sci"
+- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
+		should be "ti,am654-sci" for for TI AM654 SoC
 - mbox-names:
 	"rx" - Mailbox corresponding to receive path
 	"tx" - Mailbox corresponding to transmit path
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 987bfb29475c..c2f0815edab6 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2500,10 +2500,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
+	.rm_type_map = NULL,
+};
+
+static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
+	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
+	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
+	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
+	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
+	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
+	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
+	{.dev_id = 0, .type = 0x000}, /* end of table */
+};
+
+/* Description for AM654 */
+static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
+	.default_host_id = 12,
+	/* Conservative duration */
+	.max_rx_timeout_ms = 10000,
+	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
+	.max_msgs = 20,
+	.max_msg_size = 60,
+	.rm_type_map = ti_sci_am654_rm_type_map,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
 	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
+	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_of_match);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
