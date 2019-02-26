Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53754C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:57:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2262421850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bljT7qIE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XxrENTlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2262421850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCbWs20lVQyGWVHDU7oeJAl2JVgJ/p+3KNxGK6PP/+c=; b=bljT7qIEBt0qqT
	eJDfx2G5bSYMAJ2VVvs3Ln9HuccamQ6QJ3uq86oA+sUQH7wUMuq5/qJuUewEnfjjWVUsv7W+K6znZ
	sTV/dI/1qM0yM+azkbiPp3WmmLOrgt+5xGpeaIkScYRdHXDaKbjVUBCQJjGTg6HbT5bTJliSt5SR0
	9JVjgBcFdp1QUVXIIR9lGsqzHgL+ezY8A0waV393mJfcpnpQWc7/gcxjFjmrBT1aCVXR0MoVUPOtA
	C+xgDpauphbU7YqCVutqebBHGaGJOHkI/VT+Rz3xmQcMVGMOkEItpaCVMeRM13neuTSCQeP2BLnde
	dCYJHv17LpqHE25xO9rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybM4-0002Yy-6j; Tue, 26 Feb 2019 11:57:00 +0000
Received: from mail-bl2nam02on0604.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::604]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybM0-0002X3-Bc
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:56:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex6uyZdWem6jPJGDdDtu1KGRvPYljhIDe98tVWT8nUs=;
 b=XxrENTlpe/5QYKfuq9SUOnD2AAYf2XOZWGIYLFJvQNu3fkZ4FyRqVutF0mVj1QOw2z5kS1eL3xua4uIPiPTEfk+iRrA++oQBnGUOQK6EyEdlFy3yJ1redOO/caShrULqFsJ5qpYuCVssZ4rVMS8AOslGpPSZD6oU24bxbDO3wW0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4423.namprd03.prod.outlook.com (20.178.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 11:56:52 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:56:52 +0000
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/5] PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
Thread-Topic: [PATCH 2/5] PCI: dwc: free the page for MSI irq in
 dw_pcie_free_msi()
Thread-Index: AQHUzcpcnRavJqeZhE+qMQkNx0b7CA==
Date: Tue, 26 Feb 2019 11:56:52 +0000
Message-ID: <20190226194954.4ad0be3d@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:404:42::30) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc539e5e-5cd2-4edc-1015-08d69be17ed8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR03MB4423; 
x-ms-traffictypediagnostic: BYAPR03MB4423:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; BYAPR03MB4423;
 23:ZcDw+LphJvcqWtGyWJXRnVlrsMzFLHaWaFXmPLRmZ?=
 =?us-ascii?Q?+M2EXpu53LIX9ZOOQAn9u/LX/b3trLthQqezhLbyncisq1SoQqvJmbERxUSJ?=
 =?us-ascii?Q?weTanSHklCjsw+sWcfzck+1UKri5KeZel0uoqgNq7xn1scPSeKU9iHiRbwUW?=
 =?us-ascii?Q?omvrr+04crZGMvs00FnmhRyY0HDdkS0nqRGL9XMcVA2TAEYXsDfzIBXSSy/a?=
 =?us-ascii?Q?xbB/d4mC0CvZyEOgcU/BPlVAv9TOSNdUz5qKZSrvgWFnype2uCDwZQvKCanU?=
 =?us-ascii?Q?njFhgQmTa4jEX5bINO3HWvH2ugUz0JKo2G27avPtSk0W83gNV3pQvppAhEjg?=
 =?us-ascii?Q?8/NGJtTyL1c+T+e+0a0OhOVk4f5rxSggcbZH0ifkx3J2X/pWtoMI5nsNbNSm?=
 =?us-ascii?Q?D4QhAVoLUW+L/+ZBjDKK3cdaHFSsV0Cr/aejTkGg87e6dex7tZM/TgzRG6Bw?=
 =?us-ascii?Q?5gZEAhZAkHDkwBLHFysCqbfOPzXl+LuHTmsr2OZrAK/ogQ1QHBO5D5YO1/pk?=
 =?us-ascii?Q?chgybpClpeL5L3SOgYfA1j9Yo8/3pAHj7HZMjCXUjke3S1VwwySG7AcewaRQ?=
 =?us-ascii?Q?1SK8PyLeKAQf7ImzhWHo6rHpyT3H3sgj9kn18JRUZrUetcVCSJ1/Cbn3kb7a?=
 =?us-ascii?Q?/R8zshM5XEmDOx30NfamA2qbz1/wt3LL94IV83OoJG+sglHN0jLNiMjvm5Zd?=
 =?us-ascii?Q?ULgJ8IqIPJn4+NLn6mpKeQmPMEXDdW3AgDi8VpErPula8oVFQEbeBBYfe4UR?=
 =?us-ascii?Q?48OlXd6oX65JZIjPf/QreOwLZVCxecJUy33HGlas513NkFDFgZDvcjAGOMvP?=
 =?us-ascii?Q?V9v9/kg/YKmKVqH5xVy7drhAHfHF8UjGz6K+Fu25FcOCUErfcR909Z9uGGMR?=
 =?us-ascii?Q?uR0ueFILhapCbeHPaemfkhdpFFrfzDNFXLavsyvJgygn2+ubOBifNivCPOem?=
 =?us-ascii?Q?im6WEI1IbWwOW82TybH2oIN9lWEKGfA2uoj89ekpwqkPaEHJYZ/omuqxrRiP?=
 =?us-ascii?Q?dtquKfy/HrR0GSBH197R7ciu3J0KX7TxH98jv71V1rMVjH8Vr1treie4P/eu?=
 =?us-ascii?Q?YRPrzYPYSpEdDoXKqzvYFXykRWAuDlH+PDUwvII7pSjyhHJEsVpKBn3lYgLz?=
 =?us-ascii?Q?YVItL/M3zrzzrX38pNp76jGjIktLM+ponv/FPI8zdJc/lazPRSG5mHb9RAnC?=
 =?us-ascii?Q?KgZ1MUr2QwJH5qXPCmBxpnE+H2JfeCA6NtQ18t5yL9+Ru1M1g8JotPcag=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4423715963EE4BAB154AFA7BED7B0@BYAPR03MB4423.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(81166006)(106356001)(50226002)(6506007)(81156014)(6116002)(386003)(102836004)(305945005)(26005)(7736002)(97736004)(99286004)(3846002)(8676002)(76176011)(52116002)(68736007)(478600001)(2906002)(8936002)(72206003)(105586002)(110136005)(25786009)(316002)(66066001)(9686003)(6436002)(86362001)(486006)(2201001)(6512007)(2501003)(5660300002)(476003)(53936002)(256004)(6486002)(14454004)(186003)(1076003)(71200400001)(71190400001)(11346002)(446003)(39210200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR03MB4423;
 H:BYAPR03MB4773.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kaektce/DGv2ccOKpZzQV+nK1oeVWd9EbhYEyZUdxOBOH8GamI2fITtNXoUp0M9a8zZOOe59X23pZWyeFeIjcrpGsKhDYppKS4klCPZEPq2FKYTuoi34AOovxZw21VR5/pWbkCXusItYaDt6iEWBcgvOqkYf2wKob7o91DzG9zuhPHtMpkrl2ap3V2YZtPOSGQJYZkrjJTICvV8TYXirNfKmvW3tYS0fzXN1fbw/rzadH4UGMumvNAZQJNy4PhQCFnKq8qtHeqbvXR9VGgu/jHlv4kyYOTliE0VRqHeVMPwXTDjUk+5l187QND/x3doJOh24H4nvOZZ/UK0eenAk80UgLoIHklUbt47u6N3p/AOBgHrdyjKnVMjbSu+7iJAGyOofiGIdLlkGOrXqjq35XgWu2lUrR2aq4J7HneBAnD0=
Content-ID: <3B91CE88369CA0449E23D88A7011297F@namprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc539e5e-5cd2-4edc-1015-08d69be17ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:56:49.7035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_035656_493462_656FFE5B 
X-CRM114-Status: UNSURE (   9.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To avoid memory leak, we need to free the page for MSI in
dw_pcie_free_msi().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a94d3530b694..abe3ff5f0867 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -305,6 +305,8 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
+
+	__free_page(pp->msi_page);
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
@@ -322,6 +324,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 		return;
 	}
 	msi_target = (u64)pp->msi_data;
+	pp->msi_page = page;
 
 	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f6fb65a40f10..3be7ca9f1fc3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	struct page		*msi_page;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
