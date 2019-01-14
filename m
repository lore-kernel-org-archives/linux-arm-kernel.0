Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39ADB20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="olzsDZI+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XC/wStIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ADB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jpo91Z8JMVnVD2oGx+ad6223fBObtFJ7e+qX7LPASms=; b=olzsDZI+/467/r
	SBFeAgNp1vRmyb/YUbZU8I0PUSnHIsUNx8pfSCatB+gPlwzdvocC3VHIcwCEz6XxYViRNLesAB6kn
	OwmCtvj0bQfdSsFjeF1wrHEHe7P+3oyMtCI7Huffw/DmrrxrlZjM5sPxTla9uBM40h1HyDQNC2WDl
	zAblD2hwLtD1LRWt98iAtgFOLc407OWepW2r3qlUmMY9BRtl0rqJUHb9W+jlEw0nJfa/Eh2IcoGT6
	rMUpfNOl3JH8m7PwSUXwVKXZiI89d4DOZT3WhSLzsOV5qxau+W2+trsS7kve1K1nswjiKnhOYEu30
	qmWCGTzdqaUXakwPMp1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0Fp-0001x6-6s; Mon, 14 Jan 2019 11:18:05 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0E3-00005W-UY; Mon, 14 Jan 2019 11:16:26 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGA2j112722;
 Mon, 14 Jan 2019 05:16:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547464570;
 bh=em3nniSoZzdBLeQmpghEPOG4OiEKNFjH6jr71UxEv8A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XC/wStIeqY/aZOLxjVCCHhzcxgJmCYr7rNxHZ4r1v2r+KUP4nUPg8q9RSdjTXq+FQ
 DOtgyp4sImkH1gyp0anajHNyO8CVuB3qIHWGUUknwDOpWJhzlGfPqE3mCrczzrb/84
 Er3TaP098NTS5pAFzuqaIQ65RFRMAuzjCShTFsIk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGAqp023949
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 05:16:10 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:10 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:10 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1Z011560;
 Mon, 14 Jan 2019 05:16:07 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn
 Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 07/15] PCI: endpoint: Add helper to get first unreserved BAR
Date: Mon, 14 Jan 2019 16:45:05 +0530
Message-ID: <20190114111513.21618-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_031616_945882_000D000F 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a helper function pci_epc_get_first_free_bar(), to get the first
unreserved BAR that can be used for endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a099479d9ab..e4712a0f249c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,29 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
+ * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
+ *
+ * Invoke to get the first unreserved BAR that can be used for endpoint
+ * function. For any incorrect value in reserved_bar return '0'.
+ */
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features)
+{
+	int free_bar;
+
+	if (!epc_features)
+		return 0;
+
+	free_bar = ffz(epc_features->reserved_bar);
+	if (free_bar > 5)
+		return 0;
+
+	return free_bar;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+
 /**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 79fbcf94e14d..94e1ecff98ce 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -180,6 +180,8 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
