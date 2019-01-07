Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76978C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C712085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MeeuAEKK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4qceFof";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JZsfIhRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C712085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y/9ixf9VOX8djq/QC8xet0vbF5Apx3wECbQ4uxdxNyg=; b=MeeuAEKKBoJdco
	YagLkUGxWGI6qVMzEUKmZyeYML1Emp09uIlkB5BiewPQlWfo56s6XI3+bNgHXQUjWtPLW1RydWAHS
	1ztbVA5EtOKWdT5wrJZ/hwiytuZqayYHev/jggdds32NFQy7Xcv3fFIztyBKLmlPIIXoTLEuZeXN0
	ZjWYZkmlKAwYAp9tlLWM8mG08eiWuT5lztXHuxp25GLhNALqRYgxl+mgbz9kbk1kuVAQcwx31zQ7z
	o4B2Wr16N53n2r1zI7D3YCZ2taaEinmuazBHEYmET2yUvGjjasZFBcI56j5I+zUsV0vBWgBrnAXFT
	WoFLWh9t3QrqX7JGR8aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOeN-0004Mz-Re; Mon, 07 Jan 2019 06:44:39 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOde-0003VK-Ad; Mon, 07 Jan 2019 06:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I1BEPEyj0/HrX7NYKrqEJYA/4rslF5P7456ZRPE0ths=; b=D4qceFofprnGwp9hG/YttEUe0
 HCazXKtCKuD4nyvol09SyAPAk2Yy7npMcWH2HT7GvgPO7rSfnTU5sP/JFwViEYs2+2ZjDtWSxCuF+
 zY9sDhV+xsAGDfp65lsE1JQFlUjBiK1HesydlkDcYuAk7LrgM/NkyvTYGrLqllpcrXLmVwqjtCERP
 wZOtASocy3LEK83MZfiMsiJVYfn4r6L9Xvr/f7jdRAvX6sblQCP8Lx8f/+n5PMkHAz8bALAzRj2eV
 85m7KPno8XVCMW4T/4Z5uyVaklAVlmzvfC5LMsYjVV3fsWgFjpSm4eqFjpnASrPlOgsPxuUscPRn+
 0cvz8F90w==;
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOdb-0002BE-LD; Mon, 07 Jan 2019 06:43:52 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hZRx059042;
 Mon, 7 Jan 2019 00:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843415;
 bh=I1BEPEyj0/HrX7NYKrqEJYA/4rslF5P7456ZRPE0ths=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JZsfIhRr3LWz1cdE8NnKTtVCTFa/Z0B6e7mbtVJKhniihvqefOIVHBYaKQXTxZRei
 U3ZP8hHfDc/R7vciQ1B7JPO6um3dqh78LKcPMvsEit7Cu44LEBT1iH4Y70GlxFCAzw
 2VY2MSm2U7XSF6e1ieXTpDTNhdodLYo7oEEnFGYs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hZKg071461
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:35 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo8002672;
 Mon, 7 Jan 2019 00:43:31 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get EPC
 features
Date: Mon, 7 Jan 2019 12:11:44 +0530
Message-ID: <20190107064148.10152-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_014351_793772_658847E8 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, kishon@ti.com,
 linux-rockchip@lists.infradead.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use pci_epc_get_features to get EPC features such as linkup
notifier support, MSI/MSIX capable, BAR configuration etc and use it
for configuring pci-epf-test. Since these features are now obtained
directly from EPC driver, remove pci_epf_test_data which was initially
added to have EPC features in endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 72 ++++++++++---------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ade296180383..a26f6ccaa322 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,8 +47,6 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
-	bool			linkup_notifier;
-	bool			msix_available;
 	struct delayed_work	cmd_handler;
 };
 
@@ -71,11 +69,6 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-struct pci_epf_test_data {
-	enum pci_barno	test_reg_bar;
-	bool		linkup_notifier;
-};
-
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
@@ -458,25 +451,49 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_configure_bar(struct pci_epf *epf,
+				  const struct pci_epc_features *epc_features)
+{
+	struct pci_epf_bar *epf_bar;
+	bool bar_fixed_64bit;
+	int i;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		epf_bar = &epf->bar[i];
+		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		if (bar_fixed_64bit)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		if (epc_features->bar_fixed_size[i])
+			bar_size[i] = epc_features->bar_fixed_size[i];
+	}
+}
+
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
+	bool linkup_notifier = false;
+	bool msix_capable = false;
+	bool msi_capable = true;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
-		epf_test->linkup_notifier = false;
-	else
-		epf_test->linkup_notifier = true;
-
-	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (!epc_features) {
+		linkup_notifier = epc_features->linkup_notifier;
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		pci_epf_configure_bar(epf, epc_features);
+	}
 
-	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
+	epf_test->test_reg_bar = test_reg_bar;
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
@@ -492,13 +509,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret) {
-		dev_err(dev, "MSI configuration failed\n");
-		return ret;
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
 	}
 
-	if (epf_test->msix_available) {
+	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
@@ -506,7 +525,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!epf_test->linkup_notifier)
+	if (!linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
 	return 0;
@@ -523,17 +542,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
-	const struct pci_epf_device_id *match;
-	struct pci_epf_test_data *data;
-	enum pci_barno test_reg_bar = BAR_0;
-	bool linkup_notifier = true;
-
-	match = pci_epf_match_device(pci_epf_test_ids, epf);
-	data = (struct pci_epf_test_data *)match->driver_data;
-	if (data) {
-		test_reg_bar = data->test_reg_bar;
-		linkup_notifier = data->linkup_notifier;
-	}
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -541,8 +549,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
-	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
