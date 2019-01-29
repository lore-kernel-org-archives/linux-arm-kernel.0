Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29753C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF1C2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCS3KzXb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eM2adenx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1C2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TRmlqADrjReAS4QV6q2hc9jNgf1mf3NbvYeYc+nZ1ao=; b=uCS3KzXbh29/IV
	PuAURy9P+8HANB14krydA7+CggAh+CqvPLW3eyEEyV7Pn6K2zn7BixMpi3wXfCja7C8XTDMYdCNjx
	SvP3PMde/j3HPAKiNZ/UJArUCFueXgH2nsLE1oMkf/3GxomPX8lYuHjUsGHguP1jK2DAH0yGh1aEv
	mReLOECXc3KAtysllsv3xYYbk09lyRkLqChTZFSxR3RjWTaGkU9W5l356GCfrdW5zh66HrY5SSSGd
	sV4V44+QLnDpgLIBVNGeG90fo5dXMD/bCceDnV7LzjW2zVzs+ihrSPnea1+vNshXgceM1ZtPSlsku
	6I7lyKw+W5fc4OK4Z81g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goORh-0003ci-4Z; Tue, 29 Jan 2019 08:08:37 +0000
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goORc-0003cD-VB
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPPBhB/PEqxZaqY5vkmcIdTM6symstCZ4vRv7rDGd6o=;
 b=eM2adenxW36oQKGozF8V4JJFYAuBQeZ+TrKFFNNYI5fWRckyGPBbW4/QSwchugexsBO6tvxh7OYXzuu0djpt0UUdu2jWu0Y+wu7lyP4rQTLB2ofSaKuztWkFQEvEqvkw9kYWUWjp2wvKCHfBIvdCt+RYZTUK40nMmKZz4O0xTV4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5847.eurprd04.prod.outlook.com (20.179.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:08:28 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:28 +0000
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
Subject: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHUt6nQIKafKgn6QEuhQ0P6HOWTOw==
Date: Tue, 29 Jan 2019 08:08:28 +0000
Message-ID: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5847;
 6:U/uzNn17v3Ts8Nw2LkXlfq9FZAZECR/W4g0O3BPebRNYZpr/Ey7dDGSBTYRxJqxrmeINh1wQxNCcn81eF4tAEB/Cj62PLprzKBhTYOrTPuYUKA2tcMvU+bIouIw8O/q2awQDWAoXjo9XvV1xZZ0Q6u1OtEazZGHn9lD39y32hETZOSZN9x6bWATmK+lcDA7ajC2RpKqjsocdEsg9ZETRP0bQrTm4WMJ2WeeXKa+XQYf/C2rWb1VBLsTEEaj/tF2w0gXm09t7d3ZeTxMvfcMalUE8qOj2joAbrD7Vw/r8BQ6yt5CMGfHhhSE233N8kteGuAR2zQAeqbFkls9UDevkadOTDSNYsSJk+g6Ir+4mQCFu4lf2FD74i4e5FFRVdp4WX9m0N6OiUDH0Q4NgUEbQLbGIX75DLecX34QppBZBPpoRYp9Z32BCvu8cwDJzyN09pitqh+T6QTqWmN0u88WfQw==;
 5:zkX9dJysNEVq2isolr6NbT6XNlqCNPPgoD+9qrA3kczSxs6owSVzjPZl40BWL3t2RTIRzHWYS1SzDNZsh5HiFw11NjVwuMI6PwgZ4fdsy4JunNMamt6gXcDp4evgmVLOeLaVx5AjqxdSTIob35gGlYEmJhSqrmYfOEQ3VoxrPcsCXnhu99cZ/hIJA9YI6QytMDxVHjS9/L9Ee7zIcc2/rg==;
 7:tXAIJaYpcQw2flBfczYrZOW/9OOKbZQVJ5pWsF8OC6i9ittpsjzOfCiPQCKkd66Oeu/jrM/b/JB+4DYl1qztjAiP/mNLEsW9+Uu1W+kZVGod1/v7PuGInA3n+1JVBcx8BryhFbcrakAge33pL6IZyw==
x-ms-office365-filtering-correlation-id: 68ff47de-c64d-4b64-8885-08d685c0f33e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5847; 
x-ms-traffictypediagnostic: AM6PR04MB5847:
x-microsoft-antispam-prvs: <AM6PR04MB5847A224B25D0D01E8F539E484970@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(14444005)(14454004)(66066001)(478600001)(2616005)(6436002)(71200400001)(486006)(54906003)(476003)(99286004)(110136005)(52116002)(256004)(6486002)(36756003)(6506007)(386003)(316002)(97736004)(26005)(102836004)(71190400001)(186003)(81156014)(81166006)(7736002)(8676002)(3846002)(50226002)(305945005)(4326008)(7416002)(25786009)(1076003)(2906002)(53936002)(6116002)(86362001)(2201001)(105586002)(106356001)(8936002)(2501003)(68736007)(6512007)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5847;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /FCZdVJJqKkPid9cVjqd/kAhBvfkELSaDBWv8t60wmv3IoNxSsbbAlsmK0J02LJr+ljVojt0s+BAwDGumDpKm1z0wErVJ7eJOzPkszgV2asfm8chi1JwkN3dPr0yLrBwbWBLlHr1Nu60a8e8Pl2RoZ7B4zA+xCSUcNODdMzsBBSECg9WAnWfU9LjbIZfGfvlRE/Dbhw8JjxOQHxW6zDn8JT8D5Vnr4/E+XE877tBEFvrTckKs21Saui9zp46VYa9L2X+6yHLYwOtmSocXLilKDHZdBPyPor0hqHQvRb6dEMMt/XkkAHx1xotPrhUsSxDTQteNHXx7MLuTx9bhYvuxcyPgup3STlsmWubwyrIzHDHSs+EgsCe0tWEO2RruuPq3+pgHFVSwqJOaDRb5lGICqPm4dVC8UVW9zS7UsG2jbg=
Content-ID: <5EB28B97FCD6E348AA7971A9D134AA44@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff47de-c64d-4b64-8885-08d685c0f33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:22.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_000833_104387_87B7287F 
X-CRM114-Status: GOOD (  13.82  )
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

This patch set is aim to refactor the Mobiveil driver and add
PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
PCIe Gen4 controller.

Hou Zhiqiang (27):
  PCI: mobiveil: uniform the register accessors
  PCI: mobiveil: format the code without function change
  PCI: mobiveil: correct the returned error number
  PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
  PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
  PCI: mobiveil: replace the resource list iteration function
  PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
  PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
  PCI: mobiveil: correct inbound/outbound window setup routines
  PCI: mobiveil: fix the INTx process error
  PCI: mobiveil: only fix up the Class Code field
  PCI: mobiveil: move out the link up waiting from mobiveil_host_init
  PCI: mobiveil: move irq chained handler setup out of DT parse
  PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
  dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
  PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver
  PCI: mobiveil: fix the checking of valid device
  PCI: mobiveil: continue to initialize the host upon no PCIe link
  PCI: mobiveil: disabled IB and OB windows set by bootloader
  PCI: mobiveil: add Byte and Half-Word width register accessors
  PCI: mobiveil: make mobiveil_host_init can be used to re-init host
  dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
  PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
  arm64: dts: freescale: lx2160a: add pcie DT nodes
  arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4

 .../bindings/pci/layerscape-pci-gen4.txt      |  52 ++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
 MAINTAINERS                                   |  10 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  34 +
 drivers/pci/controller/mobiveil/Makefile      |   5 +
 .../controller/mobiveil/pci-layerscape-gen4.c | 306 +++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 640 +++++++++++++
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 246 +++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 229 +++++
 drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
 15 files changed, 1743 insertions(+), 873 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 create mode 100644 drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
 delete mode 100644 drivers/pci/controller/pcie-mobiveil.c

-- 
2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
