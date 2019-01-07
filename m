Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48731C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184F72085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBRJM5uJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W8zH/Zjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184F72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lv8aQvSuWKJ4kNdgJ8htYGI4i6lkallzbgrue1FjJ5Y=; b=HBRJM5uJ9uikwI
	qQSHHYPmPS0R9qer4XTXUMhuXV3UOXUDS3YJKIcHBJI8LQ+qzvw05zwo7LNnLYm1nb4nDeBLiB/1w
	dDsE0MPTVehE5D7eBkEGNt3aHU4f/xFkw/HlSqD4b/ygZfiU0ciChZ5C1EOk8cwAnZ3136Xe4GmpI
	LUo9GYeaNY+aV4oxym0ZqvNrd1J/BAtMj4Nm8n1W1aQgPzc8dmgGZjdyggXjfoUGq16N3GK4zTSLB
	eOUVfXQYSbwSRem1tcftElmUrILybQ0+3BUcetFWx7nVP7E/eI1Qtg0jlUNYLnoZLZfwmQWMatjtp
	ApUYXSXxK6foHhCZAoYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOfq-00074C-Dn; Mon, 07 Jan 2019 06:46:10 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOdB-0002wd-9a; Mon, 07 Jan 2019 06:44:25 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hI62021681;
 Mon, 7 Jan 2019 00:43:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843398;
 bh=wJzish8jKdOVXhvaJ7MTD1mt6K3UYjBXhrK5Hbnol9E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W8zH/Zjhszg3u1sMPVtKto0NvGJTmMf2q8FabmjBspWvtjOuZEawEp7qr8Is7V051
 iR6iWyfnmPSyXHJn77KzkxoeZJcMUbWEEiy3GhD2H8kjeBMbp3PzICw/OUfXtQmAjk
 4f2Z/MQM7roIY3iOkoZyJMEsdMcoApmw/0tIzftA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hHit048943
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:17 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:17 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:17 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo4002672;
 Mon, 7 Jan 2019 00:43:14 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 07/15] PCI: endpoint: Add helper to get first unreserved BAR
Date: Mon, 7 Jan 2019 12:11:40 +0530
Message-ID: <20190107064148.10152-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_224326_108348_45297EBA 
X-CRM114-Status: GOOD (  17.59  )
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

Add a helper function pci_epc_get_first_free_bar(), to get the first
unreserved BAR that can be used for endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 22 ++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a099479d9ab..b1632f91e33e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,28 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
+ * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
+ *
+ * Invoke to get the first unreserved BAR that can be used for endpoint
+ * function.
+ */
+int pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features)
+{
+	int free_bar;
+
+	if (!epc_features)
+		return 0;
+
+	free_bar = ffz(epc_features->reserved_bar);
+	if (free_bar <= 0 || free_bar > 6)
+		return -EINVAL;
+
+	return free_bar;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+
 /**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 79fbcf94e14d..dc3513a2f88a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -180,6 +180,7 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
+int pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
