Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E70C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7402175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qry9A+BG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoLa2LgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7402175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RVO+HjHyg7q7FqLpGuXQfqwXkD3Wex8Sblurf7VOndc=; b=Qry9A+BG8HTHoc
	j+TNUPmOcpsSmsIdKaoZh/OnA5d2Y9L0Yag/A6lhWFZypB35ykYWWUZa5iQD0KxyCjVHwAOgtCDMF
	SNWwHNry1sqmeV3XainNrF6xQz0x8yiTqbUCL1hooTBhQNfnvrPPsqjNohmXAdi9crVFrWNDPBlaw
	kOpWYYAGZVhEv1kzASpSlL5Aco2g53fckJxpHEwc5ro561hRYhnnxccpKVIUwExZcZA/Jj1/Vhrgg
	KcsSZ7yATnNFANqzKWUuuGc4uLCAWpfKctrkTuLlX5xTIMtA2quAaWrHvmEFiQ4BE4qk0hYNca3sA
	2/h+R+LBau5vSO6jQKZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOVt-000084-6L; Tue, 29 Jan 2019 08:12:57 +0000
Received: from mail-db3eur04on0604.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::604]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOTB-0004Sn-BB
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjRhsnHtslgjFjWVqiy0MvdHg9iuVpRmClK+PAq5SPc=;
 b=QoLa2LgL/AfIQFAy8htS6BeCGCNjczsoWTbqqwbWfFnRP3joF6PszdzWdXx4rEDRKRjstB2AGqlFpyW31izNHxiQY0bZbM1iwpXXWSBAN5PqmPTxtUKp1tS1Xm5KeVnTr9jLyJ2E2hLeAIox9OC6BGxNJdLWAa++2vd6h2fp5k0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:10:05 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:05 +0000
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
Subject: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave
 and apb_csr to optional
Thread-Index: AQHUt6oKYkXcpaoTuUirxMxQCEM8+g==
Date: Tue, 29 Jan 2019 08:10:04 +0000
Message-ID: <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5784;
 6:dYQdYwIFnPL2jpe0v0hiUpYCfZbwGJGNIiHXgd8igbYoHDO5CsWqLFlasspcto3ojaezprkbQn2hgwS3cKSr2gdHRA0kR25R5Gd2MvdniY5Kr/4jI+6CDiY346whwCCK3P+aLIub1grff4kZ+icf/roXEx6qsVzG2XwmK82ei6tuHnxMsHuBDaVazrqGhi2vkVsTfCV3XxP4HSQ/MrPx0mB99haQq6sYTIka0a4ayK31PbEkZhy/+A5wESDPFlPgsb9dvFPoHVk/QjRynqideJCuwD53y6mvX64PgiUzkZP9qz453e24r8JqpRfPvC2Xw1czs14wluSNM7T7LM6Aff+LlHow9DVded495yn+Ej7JfcCxeDtvz1r0xd+IwkjoLVh7AC66WHpSw/gDwTrTZVfBWObeaSaeK0+nSMBqr5wnNXm+tyL64dE7tkEqIJkpjp0dMp2+D/Y/8LTxePYjXA==;
 5:lray6L7+RybexYM3lniQkkqzkyV1P385YWecZfW0BOw/UjnBRcu/xYmSeXkfv7dPgjLqPuhwmMA4jDTWd6OJMTjVBSlZm+WsHhqEuM+P3VdwMyrzMiKjI94WUqW1N76ZFn3eBbSXYIPZ/5JE9z5TGSF4SjnbHQn1yKiszKL56wdxzi3agyp0HkEQh3cMMibiZMw7yKyBUiBvWKrXdoyIDg==;
 7:6+VK8G3KEvba5WlND+2uRDUHHJZxAMrkE2JtxZZDh9pynn2OipakJjF7NQjA2ZBnQ2PgIKj73nwPRzynd/9VLHhFSWY6hziVfWR4RMkcKccHjQifUGlNRZ9fucL3npJHWNFAEoasFp+1xd98vUWfMg==
x-ms-office365-filtering-correlation-id: 6c91fe45-5d07-44ae-dca7-08d685c12ca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5784; 
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB578435E01B62BE23EF632ADA84970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5784;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C1wS3BfOac9sbjfX3NWqHBWlQU7pJHiNwcFYmbKOxGxIlcoL1qQVkMYTGENY5GacWIJ0iCWwYVvfLbjfewfHpwVUEsADFEveJvCbv3cPZQVSY24V5VkHt5oe62hicS6Sj0hvYaPYsePtXoomYw6TTQ87L94L7uumxuTCONVS9/N3pZYaKRPkd4pBbYavX70lLd/zWvUlW4obmB3VnUVodh3PgtD0Gk0QeeXQbE/BnRL88ppb54vVxJPNuuuiE8HROmWkpkz1NbANjinXzoLUjwzLmSsrA+0JLoMTw+AHC3KKnWf4z21s/pzNtZqVMB0etBEelBjpReg1eVnE5SRH7PM2nBzYog58k2OzNl89xNX8YnRirG6HTHEAUSycx2TfRaWp04xFZ1D0+c9Kx8Pgo/UNQK3ZDOy9FI3JSd2B5qA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c91fe45-5d07-44ae-dca7-08d685c12ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:58.7724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001009_559056_8F5D3E0F 
X-CRM114-Status: UNSURE (   9.80  )
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

Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
is not used in current code, and "apb_csr" is not used by some
platforms.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
index a618d4787dd7..64156993e052 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -10,8 +10,10 @@ Required properties:
 	interrupt source. The value must be 1.
 - compatible: Should contain "mbvl,gpex40-pcie"
 - reg: Should contain PCIe registers location and length
+	Mandatory:
 	"config_axi_slave": PCIe controller registers
 	"csr_axi_slave"	  : Bridge config registers
+	Optional:
 	"gpio_slave"	  : GPIO registers to control slot power
 	"apb_csr"	  : MSI registers
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
