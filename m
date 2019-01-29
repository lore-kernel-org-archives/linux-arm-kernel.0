Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C07C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E941214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gn2iixmw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1VxJhC+L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rWkFI8r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E941214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QYfqo8Y/kXt6IA4Zhj02/TpG65IV6D4e5sx6y42zICo=; b=Gn2iixmwUGDpGO
	EWAYdwmspi907kS3klqRrYwblpyMAvt9/aDULPbUpQtc/vBOVP9EQKZgDLEmQwFbvM5D4LHGvfSPc
	4/6JbC5C1h0yxQjHMGUvfcyHgBelHXWjEU1t+QhPEWk4IaTHCbqqlJw73/WEwrSbAl8QndcjZHfcr
	vZDzZmsHS7lAlHHQff8e+WMihi9dJyhjU9jWDoe27kvtd+MbKwHYHOfACHwd6U1wlkPQNpRFk91qh
	8PxsArJ8BVZSP0IbuuxZKSDBxPKQn6il+YDMaenzcA+Wf1BfXe3ID8s6Nn8a7v8AQ6sfBXydPHqvm
	9FWU+gimuR7XGLxXhBEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOUz-0007ls-AR; Tue, 29 Jan 2019 08:12:01 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT7-0004si-9x
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 08:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PlBOMd+seufsghBS3KS0MJplk2qmVcJh6mJIbRqnBDE=; b=1VxJhC+LhlfRjDQHDayLSpNaGn
 GS/jv6eKs4/eWi6EfVEPTWxCgugTs6vDFHaN+eLj2CruJigMKhFZeDxUXts0VdMgqRSsy5DmVF9CV
 4Q7r9/0EX5p4mWDSsE5qL/uJHDNhBQ7CMnjnNWTjcahW5KzW7n0upab2qEr4JJr+QaYwIjA4vkzQp
 6vMAnIn3RBkZ5qOgnCBQSWjPYTC4ju5aKOG+DoacjxbSp3V2VN9u1zGEOCxY69R+RQN1CdpKi7wwg
 A7n4zJYrULkvkRxDtsVocOMBsTe8/nBe+dBghS1M/EPedxMptJ9dXGaQvky+E11nYnQxcIO5ilMDW
 9Ipct14w==;
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT1-0007U6-Qg
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:10:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlBOMd+seufsghBS3KS0MJplk2qmVcJh6mJIbRqnBDE=;
 b=rWkFI8r4Ydi6JOAcDc3/sW5ZIil/rbIzXRSnSso6OMf9efdvcxwh3tKD2IQCvBReL0ZaHy3LqRdui/1lWM2uMvQ8DFJEaTxIJSYMN16HOsynymsX6pdn12LLxRb6i4qLA/GduPcWdWg94cROLZkzj7jd51hXkxiP40EcNabKavw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:58 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:58 +0000
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "l.subrahmanya@mobiveil.co.in"
 <l.subrahmanya@mobiveil.co.in>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Subject: [PATCHv3 14/27] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Topic: [PATCHv3 14/27] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHUt6oGvsMP74HT8k+h+5NNlChWGA==
Date: Tue, 29 Jan 2019 08:09:58 +0000
Message-ID: <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4728;
 6:0Mlm//6gxhwBYTI7Ff8Ucg0KwJeKG6bmb006SXOr0ZLGn6HNboL/p0rFP+TDHYKSy8UaJABc7fyMyfNh9ldpq1ZG524pgw/mkqJ0rUbBZClDVqKU3YB5iRQM93UREhOOZhlrsNJJItBKWLJzP9g8/gVkDYi2866R0jENQyofOd02XQPBccBw+lpyUi0+neC+WGCPaOQt97yK8c/pgSLP3fPRcWYaNjgbF0xQhETik0ouR94I2F+sy+79YfsUfAelw9u2pJjFSq9E/Fgg74KHlhzfkoSeGzpHIVtgtfVayqYPG2GgKDJXsF0L8jOjUBHIGyxjx6Dx1pHYbxGStf9bxmpw3EEXRhcUEIN4bbpLb2wte2UiHBmHp+cIdBwB84GQLRMnnprHb2JpzUHkw/6v8DS4zpkBjSWejbGf8JuN/KxgVIH08n0yTXEuNSbuBPW3KrF3LkctdeleKoC//VkpQw==;
 5:9m1UAaqvFA/jCMf6+g9/yF1+5WLMPTI7xP1a3Efj3disGRnDqEKBvTa8RfQ4UEmwUG+Fn8gHvoVKbI4QpbUALMh1DOphDndQkVntWStAa1H1C3Etulz7d5ZArHb+13u/3Udz61FqSjylyC01kYZAH7FfkMKk1Ke0lPZaI6OYbNqOzXRY/ad3biWHSukZId4Xba4fc20aKxqXAD9dox0OlA==;
 7:imCZJhu3MpuIhNnF3Kt8HPTA3X7dmkyJ4XuXn09/tAuk8icmxJM08LGWrxW1+ly2S5Gwu28Yd7bTn2BImUYgip86z+8z9hlX8KKCyEQZS9I0HYw0frU+TScwTdw29SAsS2CgYIzgql3A77KnCcH2Zw==
x-ms-office365-filtering-correlation-id: 80e748db-24de-4fed-4224-08d685c128c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4728; 
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB47281E9836C72A4BEAD37CE084970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(4744005)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4728;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H3FIxN/t9Jcuu0yh3kR0PbymPpfa0YTP7OlKWo67Pyyfxl7mBV/FjiA/u9xKC81t3053B59kI2TFD6O9Xq/IzesPxVmrrYsWFE3kBSYYCagwNTtE0fJNwxGUc2CLhy4o/YfwfmhZmKaMPGbY5qXSUhDF8UqWEkcenqfEZhpMsPHJ1R6F4vYXQ8d39RHF3bop8czNgujMusyDSgZ5wgz/9JvluKMWkRjB3C0TIp7OIj78uYncWBQPYOn8pAJE/ICkj4/tH6jtOIjj7ejuS9DQVbMssGU0d7zbuvLQ3CmuXAUpmF3cKy7yfUS9rUrzQ/PvB4yOgnOFPZFhNAqEtwv+7TKIbAsRexMI0VyAP5sCKtvLSvLAE41tEJYEy6mMTUO3YIuvE2oJkcWMVa8vxhw6P56iBV2EaGoX8n+SDTLhCS8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e748db-24de-4fed-4224-08d685c128c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:51.7254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_030959_896489_2A59C272 
X-CRM114-Status: UNSURE (   8.39  )
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
Cc: "M.h. Lian" <minghuan.lian@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index db7ecb021c63..9210165fe8c0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
+	/* setup bus numbers */
+	value = csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &= 0xff000000;
+	value |= 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
