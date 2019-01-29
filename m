Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE770C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:17:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3542175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G91CMBbJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zd3P3XCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3542175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mna3LuAewFa3vSmj60BiwU8wufc8VRqTnpX4HyE34yQ=; b=G91CMBbJ89Phek
	I+B9qDdyp1m6tzae3bNtbL3AYjxCRWpvv95a8HH5QuEYKW3q43NSPUYzyrcHFQKibvxRTzJlwKhSm
	zJUkP3VbRhaNVP7ALuasyOFTExnyFglZm2WKLlV3i+rZntL8XfeTrJ+mix8Hr1SSbd9KBFAWJXMaF
	hjKk/OMUN4OKRu/ZF3WRxVL0B0g0DyF15zECDVFpB+FAypIh2JwLfONxh5cObvuoQdBdeXlGwniBz
	zF5YPWgbowy0CFL7bvreOTuRIqsBzM0FobbuM3DSozt+kp3N9o3ow4wssN9VCk6mLaA2MfxGHMuZh
	FwbiQ/uZQWOKwalppivQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOZk-0004hP-6w; Tue, 29 Jan 2019 08:16:56 +0000
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOVR-0007Cv-0Q
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+yaZ49ALojOoQX58iqHhsCjuFdLiiJCirRDsnfSmwU=;
 b=Zd3P3XCo5KkaRBroNIZ0XhRYX4G1xYmpqbkO0j5v7HgFwT2fbB8CbpWzm7dYejpNG+0sDg1TRhDMq11XvngsjqBw7K8mZgInTc3DACZGPL0A40HsCbKuWs2+J223qkRBVvmu3GiPRg8mAiKaTzieG/C47M+h9uKLno20j2bqcug=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6117.eurprd04.prod.outlook.com (20.179.7.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 08:11:20 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:11:20 +0000
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
Subject: [PATCHv3 27/27] arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv3 27/27] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Index: AQHUt6o3uDb/JMV0a0uoMStsRYIxvA==
Date: Tue, 29 Jan 2019 08:11:20 +0000
Message-ID: <20190129080926.36773-28-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB6117;
 6:86yYTXdu/P+VnqGsgXlGOv2MRk+pW8JYNMP6oL3efrNueHeBgYgtN5xbiRgVGKsPbgy45rGz3b+6EQqzx83lAFbFyyFU2OUlJlTYtDsdnj3eZQFo0lMmMk0/eFrIz5HYGFcRLK/aN04N6rnSBxuOx8qHZrvQVj+kgyNfluV+Ql9iPj2z9Ks5l65mLC7b9eBwyjGJ4wGW7fL+11gaBzn7upp2KVowolIJbEah7JkmYRu703RPVGjoJXuPkVr3q9K8xwyIcSre+x9sZevrcCEii+LOP5RS84fCsTP720/ZfqySRoecYtyuNmrV/94YE6Gta2e//NrnHZ6XKL4q2wJ+e/a23ocAf+3VyYh5LwmvWsbUpCdFsrBwltCiY7+9yKt/eUnOELKIWRYF0tQcCWHAIVEW2kjCbDhm6QCH3MkL4Biyi0emyMuaQEzD7/NBE5/8HObsN+TwfgRf7iUlUMQ1og==;
 5:H1SVxdEv3x8FsGjvEVL0FZUV+MIHnGddYf9RA2aM9eAK6aBids1zYW2SxlcKkXdjEXtn8uGiq36F3pDllHjtPZB/rE7APy24/2YcYhcy9IcoCWC38SVK7PftEfdupQeASqHpHZGZ1o8tLFd6zRM1KNgg5ha9bjLOy5HBu9OzFZ+5eUcpQpC6M7Cx/6PWvibdocScBzdOPr4TTCTrvSU38Q==;
 7:ZJKP097Il0okfKnaUym7BKhX5ALS1pw0+Iamgl1u7y/59G/FSvyOLEHoAEj/emdgOJ5mwe4mUMelMO9K5CV+p0dW9ZQosOUvbG6kf+uPaBXph6t8sZdbDZSo4Uga30g8FvmpA4zoXLoMcNRrf9WkOg==
x-ms-office365-filtering-correlation-id: fd24535c-80e6-4327-1984-08d685c159b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB6117; 
x-ms-traffictypediagnostic: AM6PR04MB6117:
x-microsoft-antispam-prvs: <AM6PR04MB6117DA73CC771C8B3FF3242084970@AM6PR04MB6117.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(3846002)(6116002)(486006)(81166006)(81156014)(8676002)(7416002)(106356001)(14454004)(478600001)(386003)(446003)(11346002)(186003)(102836004)(476003)(6506007)(8936002)(50226002)(105586002)(68736007)(71190400001)(2906002)(2616005)(71200400001)(36756003)(2501003)(66066001)(97736004)(26005)(4326008)(25786009)(6436002)(6486002)(53936002)(6512007)(4744005)(256004)(54906003)(7736002)(99286004)(305945005)(76176011)(2201001)(110136005)(1076003)(316002)(86362001)(52116002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB6117;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DggRXVSyPmdwMZ18GbkRMeUfEasW9glgcyaXoZP5blAAZkiZphBxiLV3FThyHQ20zFMZjJ8wHkmDckTCWNDCmhc2rn4h5D5AN0qM6BXzLr0DAzfCQyXzd5nk5xjKOkcZCFMCGUpNxlexDqioVlhbz72VsZbKDfZm5zUHLBYOUWnE9G5Lj6eg9GzBofr1aoIXSo2zpPBe2qqPwsPdL7ber4fBUO3U7553pGd+Odf3XwwKqUTeyII/jrXiD3+r96JTjQ8fTPgartywu5uCyyowuYYWkjKS0JyFkfoFdGr7qD01/cXPDKIPA6aDWCqyv0/+QFEzvvLa/p8xzoMoashIYlJjLCbsMxczxBbz2U1JkPqtnCiCaJAdYfVAHMuU7afnxr/mpSXOvFM0n3pfRB344Flv6kh9i8Wa0/BMGUF6mn8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd24535c-80e6-4327-1984-08d685c159b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:11:14.3672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001229_557837_C7F17619 
X-CRM114-Status: UNSURE (   9.37  )
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

Enable the PCIe Gen4 controller driver for Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e5af2563ef5..5363c1fdce2e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=y
 CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_LAYERSCAPE=y
+CONFIG_PCI_LAYERSCAPE_GEN4=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
